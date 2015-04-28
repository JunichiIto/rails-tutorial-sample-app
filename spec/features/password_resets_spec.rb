require 'rails_helper'

feature 'Password reset' do
  given(:user) { create :michael }
  
  background do
    ActionMailer::Base.deliveries.clear
  end

  scenario 'password resets' do
    visit new_password_reset_path
    expect(page).to have_selector 'h1', 'Forgot password'

    click_button 'Submit'
    expect(page).to have_flash_message
      .and have_selector('h1', 'Forgot password')

    fill_in 'Email', with: user.email
    click_button 'Submit'
    expect(user.reset_digest).to_not eq user.reload.reset_digest
    expect(ActionMailer::Base.deliveries.size).to eq 1
    expect(page).to have_flash_message
    expect(current_path).to eq root_path

    reset_token = extract_reset_token_from_last_mail

    visit edit_password_reset_path(reset_token, email: '')
    expect(current_path).to eq root_path

    user.toggle!(:activated)
    visit edit_password_reset_path(reset_token, email: user.email)
    expect(current_path).to eq root_path
    user.toggle!(:activated)

    visit edit_password_reset_path(reset_token, email: user.email)
    expect(page).to have_selector 'h1', 'Reset password'
    hidden = find 'input[name=email][type=hidden]'
    expect(hidden.value).to eq user.email

    fill_in 'Password', with: 'foobaz'
    fill_in 'Confirmation', with: 'barquux'
    click_button 'Update password'
    expect(page).to have_selector 'div#error_explanation'

    fill_in 'Password', with: ''
    fill_in 'Confirmation', with: 'foobar'
    click_button 'Update password'
    expect(page).to have_flash_message
      .and have_selector('h1', 'Reset password')

    fill_in 'Password', with: 'foobaz'
    fill_in 'Confirmation', with: 'foobaz'
    click_button 'Update password'
    expect(page).to be_logged_in
      .and have_flash_message
    expect(current_path).to eq user_path(user)
  end

  # See Listing 10.57
  scenario 'expired token' do
    visit new_password_reset_path
    fill_in 'Email', with: user.email
    click_button 'Submit'

    reset_token = extract_reset_token_from_last_mail

    visit edit_password_reset_path(reset_token, email: user.email)
    fill_in 'Password', with: 'foobar'
    fill_in 'Confirmation', with: 'foobar'

    user.update_attribute(:reset_sent_at, 3.hours.ago)

    click_button 'Update password'

    expect(current_path).to eq new_password_reset_path
    expect(page).to have_content 'Password reset has expired'
  end
end

# require 'test_helper'
#
# class PasswordResetsTest < ActionDispatch::IntegrationTest
#   def setup
#     ActionMailer::Base.deliveries.clear
#     @user = users(:michael)
#   end
#
#   test 'password resets' do
#     get new_password_reset_path
#     assert_template 'password_resets/new'
#
#     post password_resets_path, password_reset: { email: '' }
#     assert_not flash.empty?
#     assert_template 'password_resets/new'
#
#     post password_resets_path, password_reset: { email: @user.email }
#     assert_not_equal @user.reset_digest, @user.reload.reset_digest
#     assert_equal 1, ActionMailer::Base.deliveries.size
#     assert_not flash.empty?
#     assert_redirected_to root_url
#
#     user = assigns(:user)
#
#     get edit_password_reset_path(user.reset_token, email: '')
#     assert_redirected_to root_url
#
#     user.toggle!(:activated)
#     get edit_password_reset_path(user.reset_token, email: user.email)
#     assert_redirected_to root_url
#     user.toggle!(:activated)
#
#     get edit_password_reset_path(user.reset_token, email: user.email)
#     assert_template 'password_resets/edit'
#     assert_select 'input[name=email][type=hidden][value=?]', user.email
#
#     patch password_reset_path(user.reset_token),
#         email: user.email,
#         user: { password: 'foobaz', password_confirmation: 'barquux' }
#     assert_select 'div#error_explanation'
#
#     patch password_reset_path(user.reset_token),
#           email: user.email,
#           user: { password: '', password_confirmation: 'foobar' }
#     assert_not flash.empty?
#     assert_template 'password_resets/edit'
#
#     patch password_reset_path(user.reset_token),
#           email: user.email,
#           user: { password: 'foobaz', password_confirmation: 'foobaz' }
#     assert is_logged_in?
#     assert_not flash.empty?
#     assert_redirected_to user
#   end
#
#   # See Listing 10.57
#   test "expired token" do
#     get new_password_reset_path
#     post password_resets_path, password_reset: { email: @user.email }
#
#     @user = assigns(:user)
#     @user.update_attribute(:reset_sent_at, 3.hours.ago)
#     patch password_reset_path(@user.reset_token),
#           email: @user.email,
#           user: { password:              "foobar",
#                   password_confirmation: "foobar" }
#     assert_response :redirect
#     follow_redirect!
#     assert_match /Password reset has expired/i, response.body
#   end
# end
