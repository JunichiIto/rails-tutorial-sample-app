require 'rails_helper'

describe 'User signup', type: :feature do
  before do
    ActionMailer::Base.deliveries.clear
  end

  it 'invalid signup information' do
    visit signup_path
    fill_in 'Name', with: ''
    fill_in 'Email', with: 'user@invalid'
    fill_in 'Password', with: 'foo'
    fill_in 'Confirmation', with: 'bar'
    expect { click_on 'Create my account' }.to_not change { User.count }
    expect(current_path).to eq users_path
  end

  it 'valid signup information with account activation' do
    visit signup_path
    fill_in 'Name', with: 'Example User'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Confirmation', with: 'password'
    expect { click_on 'Create my account' }.to change { User.count }.by(1)
    expect(ActionMailer::Base.deliveries.size).to eq 1
    activation_token = ActionMailer::Base.deliveries.last.body.encoded[/(?<=account_activations\/)[^\/]+/]
    user = User.last
    expect(user.activated?).to_not be_truthy

    log_in_as(user)
    expect(is_logged_in?).to_not be_truthy

    visit edit_account_activation_path('invalid token')
    expect(is_logged_in?).to_not be_truthy

    visit edit_account_activation_path(activation_token, email: 'wrong')
    expect(is_logged_in?).to_not be_truthy

    visit edit_account_activation_path(activation_token, email: user.email)
    expect(user.reload.activated?).to be_truthy
    expect(current_path).to eq user_path(user)
    expect(is_logged_in?).to be_truthy
  end
end
#
#   test 'valid signup information with account activation' do
#     get signup_path
#     assert_difference 'User.count', 1 do
#       post users_path, user: { name: 'Example User', email: 'user@example.com', password: 'password', password_confirmation: 'password' }
#     end
#     assert_equal 1, ActionMailer::Base.deliveries.size
#     user = assigns(:user)
#     assert_not user.activated?
#
#     log_in_as(user)
#     assert_not is_logged_in?
#
#     get edit_account_activation_path('invalid token')
#     assert_not is_logged_in?
#
#     get edit_account_activation_path(user.activation_token, email: 'wrong')
#     assert_not is_logged_in?
#
#     get edit_account_activation_path(user.activation_token, email: user.email)
#     assert user.reload.activated?
#     follow_redirect!
#     assert_template 'users/show'
#     assert is_logged_in?
#   end
# end
