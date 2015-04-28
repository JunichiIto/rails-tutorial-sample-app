require 'rails_helper'

describe SessionsHelper do
  before do
    @user = create :michael
    remember(@user)
  end

  specify 'current_user returns right user when session is nil' do
    expect(current_user).to eq @user
    expect(is_logged_in?).to be_truthy
  end

  specify 'current_user returns nil when remember digest is wrong' do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    expect(current_user).to be_nil
  end
end
# require 'test_helper'
#
# class SessionsHelperTest < ActionView::TestCase
#   def setup
#     @user = users(:michael)
#     remember(@user)
#   end
#
#   test 'current_user returns right user when session is nil' do
#     assert_equal @user, current_user
#     assert is_logged_in?
#   end
#
#   test 'current_user returns nil when remember digest is wrong' do
#     @user.update_attribute(:remember_digest, User.digest(User.new_token))
#     assert_nil current_user
#   end
# end