require 'rails_helper'

feature 'Users edit' do
  given(:user) { create :michael }

  scenario 'unsuccessful edit' do
    log_in_as(user)
    visit edit_user_path(user)
    expect(page).to have_selector 'h1', text: 'Update your profile'
    fill_in 'Email', with: 'foo@invalid'
    fill_in 'Password', with: 'foo'
    fill_in 'Confirmation', with: 'bar'
    click_button 'Save changes'
    expect(page).to have_selector 'h1', text: 'Update your profile'
  end

  scenario 'successful edit with friendly forwarding' do
    visit edit_user_path(user)
    log_in_as(user)
    expect(current_path).to eq edit_user_path(user)
    name = 'Foo Bar'
    email = 'foo@bar.com'
    fill_in 'Name', with: name
    fill_in 'Email', with: email
    click_button 'Save changes'
    expect(page).to have_flash_message
    expect(current_path).to eq user_path(user)
    expect(user.reload).to have_attributes name: name, email: email
  end
end

# require 'test_helper'
#
# class UsersEditTest < ActionDispatch::IntegrationTest
#   def setup
#     @user = users(:michael)
#   end
#
#   test 'unsuccessful edit' do
#     log_in_as(@user)
#     get edit_user_path(@user)
#     assert_template 'users/edit'
#     patch user_path(@user), user: { name: '', email: 'foo@invalid', password: 'foo', password_confirmation: 'bar' }
#     assert_template 'users/edit'
#   end
#
#   test 'successful edit with friendly forwarding' do
#     get edit_user_path(@user)
#     log_in_as(@user)
#     assert_redirected_to edit_user_path(@user)
#     name = 'Foo Bar'
#     email = 'foo@bar.com'
#     patch user_path(@user), user: { name: name, email: email, password: '', password_confirmation: '' }
#     assert_not flash.empty?
#     assert_redirected_to @user
#     @user.reload
#     assert_equal @user.name, name
#     assert_equal @user.email, email
#   end
# end
