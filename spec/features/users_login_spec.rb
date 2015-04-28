require 'rails_helper'

feature 'Users login', type: :feature do
  given(:user) { create :michael }

  scenario 'login with invalid information' do
    visit login_path
    expect(page).to have_selector 'h1', text: 'Log in'
    click_button 'Log in'
    expect(page).to have_selector 'h1', text: 'Log in'
    expect(page).to have_flash_message
    visit root_path
    expect(page).to_not have_flash_message
  end

  scenario 'login with valid information' do
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to be_logged_in
    expect(current_path).to eq user_path(user)
    expect(page).to have_selector 'h1', text: user.name
    expect(page).to_not have_link 'Log in', href: login_path
    expect(page).to have_link 'Log out', href: logout_path
    expect(page).to have_link 'Profile', href: user_path(user)
    click_link 'Log out'
    expect(page).to_not be_logged_in
    expect(current_path).to eq root_path

    # Simulate a user clicking logout in a second window.
    # => See sessions_controller_spec

    expect(page).to have_link 'Log in', href: login_path
    expect(page).to_not have_link 'Log out', href: logout_path
    expect(page).to_not have_link 'Profile', href: user_path(user)
  end

  # NOTE login with/without remembering tests are in sessions_controller_spec
end

# require 'test_helper'
#
# class UsersLoginTest < ActionDispatch::IntegrationTest
#   def setup
#     @user = users(:michael)
#   end
#
#   test 'login with invalid information' do
#     get login_path
#     assert_template 'sessions/new'
#     post login_path, session: { email: '', password: '' }
#     assert_template 'sessions/new'
#     assert_not flash.empty?
#     get root_path
#     assert flash.empty?
#   end
#
#   test 'login with valid information' do
#     get login_path
#     post login_path, session: { email: @user.email, password: 'password' }
#     assert is_logged_in?
#     assert_redirected_to @user
#     follow_redirect!
#     assert_template 'users/show'
#     assert_select 'a[href=?]', login_path, count: 0
#     assert_select 'a[href=?]', logout_path
#     assert_select 'a[href=?]', user_path(@user)
#     delete logout_path
#     assert_not is_logged_in?
#     assert_redirected_to root_url
#     # Simulate a user clicking logout in a second window.
#     delete logout_path
#     follow_redirect!
#     assert_select 'a[href=?]', login_path
#     assert_select 'a[href=?]', logout_path, count: 0
#     assert_select 'a[href=?]', user_path(@user), count: 0
#   end
#
#   test 'login with remembering' do
#     log_in_as(@user, remember_me: '1')
#     assert_not_nil cookies['remember_token']
#   end
#
#   test 'login without remembering' do
#     log_in_as(@user, remember_me: '0')
#     assert_nil cookies['remember_token']
#   end
# end
