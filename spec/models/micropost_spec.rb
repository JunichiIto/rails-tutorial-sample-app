require 'rails_helper'

describe Micropost do
  before do
    @user = FactoryGirl.create :michael
    @micropost = @user.microposts.build(content: 'Lorem ipsum')
  end

  it 'should be valid' do
    expect(@micropost).to be_valid
  end

  specify 'user id should be present' do
    @micropost.user_id = nil
    expect(@micropost).to be_invalid
  end

  specify 'content should be present' do
    @micropost.content = ' '
    expect(@micropost).to be_invalid
  end

  specify 'content should be at most 140 characters' do
    @micropost.content = 'a' * 141
    expect(@micropost).to be_invalid
  end

  specify 'order should be most recent first' do
    content = FactoryGirl.attributes_for(:most_recent)[:content]
    most_recent = Micropost.find_by content: content
    expect(Micropost.first).to eq most_recent
  end
end
# require 'test_helper'
#
# class MicropostTest < ActiveSupport::TestCase
#   def setup
#     @user = users(:michael)
#     @micropost = @user.microposts.build(content: 'Lorem ipsum')
#   end
#
#   test 'should be valid' do
#     assert @micropost.valid?
#   end
#
#   test 'user id should be present' do
#     @micropost.user_id = nil
#     assert_not @micropost.valid?
#   end
#
#   test 'content should be present' do
#     @micropost.content = ' '
#     assert_not @micropost.valid?
#   end
#
#   test 'content should be at most 140 characters' do
#     @micropost.content = 'a' * 141
#     assert_not @micropost.valid?
#   end
#
#   test 'order should be most recent first' do
#     assert_equal Micropost.first, microposts(:most_recent)
#   end
# end
