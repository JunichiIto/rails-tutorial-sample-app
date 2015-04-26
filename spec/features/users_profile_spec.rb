require 'rails_helper'

describe 'Users profile' do
  include ApplicationHelper

  before do
    @user = FactoryGirl.create :michael
    default_per_page = 30
    FactoryGirl.create_list :micropost, (default_per_page + 1), user: @user
  end

  it 'profile display' do
    visit user_path(@user)
    expect(page).to have_title full_title(@user.name)
    expect(page).to have_selector 'h1', text: @user.name
    expect(page).to have_selector 'h1>img.gravatar'
    expect(page).to have_content @user.microposts.count
    expect(page).to have_selector 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      expect(page).to have_content micropost.content
    end
  end
end

# require 'test_helper'
#
# class UsersProfileTest < ActionDispatch::IntegrationTest
#   include ApplicationHelper
#
#   def setup
#     @user = users(:michael)
#   end
#
#   test 'profile display' do
#     get user_path(@user)
#     assert_template 'users/show'
#     assert_select 'title', full_title(@user.name)
#     assert_select 'h1', text: @user.name
#     assert_select 'h1>img.gravatar'
#     assert_match @user.microposts.count.to_s, response.body
#     assert_select 'div.pagination'
#     @user.microposts.paginate(page: 1).each do |micropost|
#       assert_match micropost.content, response.body
#     end
#   end
# end
