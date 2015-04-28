require 'rails_helper'

describe User do
  before do
    @user = User.new(name: 'Example User', email: 'user@example.com',
      password: 'foobar', password_confirmation: 'foobar')
  end

  it 'should be valid' do
    expect(@user).to be_valid
  end

  it 'name should be present' do
    @user.name = ' '
    expect(@user).to be_invalid
  end

  it 'email should be present' do
    @user.email = ' '
    expect(@user).to be_invalid
  end

  it 'name should not be too long' do
    @user.name = 'a' * 51
    expect(@user).to be_invalid
  end

  it 'email should not be too long' do
    @user.email = 'a' * 244 + '@example.com'
    expect(@user).to be_invalid
  end

  it 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_USE-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      expect(@user).to be_valid, "#{valid_address.inspect} should be valid"
    end
  end

  it 'email validation should reject valid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      expect(@user).to be_invalid, "#{invalid_address.inspect} should be invalid"
    end
  end

  it 'email addresses should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    expect(duplicate_user).to be_invalid
  end

  it 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    expect(@user).to be_invalid
  end

  it 'authenticated? should return false for a user with nil digest' do
    expect(@user).to_not be_authenticated(:remember, '')
  end

  it 'associated microposts should be destroyed' do
    @user.save
    @user.microposts.create!(content: 'Lorem ipsum')
    expect{@user.destroy}.to change{Micropost.count}.by(-1)
  end

  it 'should follow and unfollow a user' do
    michael = FactoryGirl.create :michael
    archer = FactoryGirl.create :archer
    expect(michael).to_not be_following(archer)
    michael.follow(archer)
    expect(michael).to be_following(archer)
    expect(archer.followers.include?(michael)).to be_truthy
    michael.unfollow(archer)
    expect(michael).to_not be_following(archer)
  end

  it 'feed should have the right posts' do
    michael = FactoryGirl.create :michael
    archer = FactoryGirl.create :archer
    lana = FactoryGirl.create :lana

    create_relationships(michael: michael, archer: archer, lana: lana)

    lana.microposts.each do |post_following|
      expect(michael.feed.include?(post_following)).to be_truthy
    end

    michael.microposts.each do |post_self|
      expect(michael.feed.include?(post_self)).to be_truthy
    end

    archer.microposts.each do |post_unfollowed|
      expect(michael.feed.include?(post_unfollowed)).to be_falsey
    end
  end
end

# require 'test_helper'
#
# class UserTest < ActiveSupport::TestCase
#   def setup
#     @user = User.new(name: 'Example User', email: 'user@example.com',
#       password: 'foobar', password_confirmation: 'foobar')
#   end
#
#   test 'should be valid' do
#     assert @user.valid?
#   end
#
#   test 'name should be present' do
#     @user.name = ' '
#     assert_not @user.valid?
#   end
#
#   test 'email should be present' do
#     @user.email = ' '
#     assert_not @user.valid?
#   end
#
#   test 'name should not be too long' do
#     @user.name = 'a' * 51
#     assert_not @user.valid?
#   end
#
#   test 'email should not be too long' do
#     @user.email = 'a' * 244 + '@example.com'
#     assert_not @user.valid?
#   end
#
#   test 'email validation should accept valid addresses' do
#     valid_addresses = %w[user@example.com USER@foo.COM A_USE-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
#     valid_addresses.each do |valid_address|
#       @user.email = valid_address
#       assert @user.valid?, "#{valid_address.inspect} should be valid"
#     end
#   end
#
#   test 'email validation should reject valid addresses' do
#     invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
#     invalid_addresses.each do |invalid_address|
#       @user.email = invalid_address
#       assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
#     end
#   end
#
#   test 'email addresses should be unique' do
#     duplicate_user = @user.dup
#     duplicate_user.email = @user.email.upcase
#     @user.save
#     assert_not duplicate_user.valid?
#   end
#
#   test 'password should have a minimum length' do
#     @user.password = @user.password_confirmation = 'a' * 5
#     assert_not @user.valid?
#   end
#
#   test 'authenticated? should return false for a user with nil digest' do
#     assert_not @user.authenticated?(:remember, '')
#   end
#
#   test 'associated microposts should be destroyed' do
#     @user.save
#     @user.microposts.create!(content: 'Lorem ipsum')
#     assert_difference 'Micropost.count', -1 do
#       @user.destroy
#     end
#   end
#
#   test 'should follow and unfollow a user' do
#     michael = users(:michael)
#     archer = users(:archer)
#     assert_not michael.following?(archer)
#     michael.follow(archer)
#     assert michael.following?(archer)
#     # assert archer.followers.include?(michael)
#     michael.unfollow(archer)
#     assert_not michael.following?(archer)
#   end
#
#   test 'feed should have the right posts' do
#     michael = users(:michael)
#     archer = users(:archer)
#     lana = users(:lana)
#
#     lana.microposts.each do |post_following|
#       assert michael.feed.include?(post_following)
#     end
#
#     michael.microposts.each do |post_self|
#       assert michael.feed.include?(post_self)
#     end
#
#     archer.microposts.each do |post_unfollowed|
#       assert_not michael.feed.include?(post_unfollowed)
#     end
#   end
# end
