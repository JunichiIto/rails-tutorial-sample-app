require 'rails_helper'

describe UserMailer do
  specify 'account_activation' do
    user = create :michael
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    expect(mail.subject).to eq 'Account activation'
    expect(mail.to).to eq [user.email]
    expect(mail.from).to eq ['noreply@example.com']
    expect(mail.body.encoded).to match user.name
    expect(mail.body.encoded).to match user.activation_token
    expect(mail.body.encoded).to match CGI::escape(user.email)
  end

  specify 'password reset' do
    user = create :michael
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    expect(mail.subject).to eq 'Password reset'
    expect(mail.to).to eq [user.email]
    expect(mail.from).to eq ['noreply@example.com']
    expect(mail.body.encoded).to match user.reset_token
    expect(mail.body.encoded).to match CGI::escape(user.email)
  end
end
# require 'test_helper'
#
# class UserMailerTest < ActionMailer::TestCase
#   test "account_activation" do
#     user = users(:michael)
#     user.activation_token = User.new_token
#     mail = UserMailer.account_activation(user)
#     assert_equal "Account activation", mail.subject
#     assert_equal [user.email], mail.to
#     assert_equal ["noreply@example.com"], mail.from
#     assert_match user.name, mail.body.encoded
#     assert_match user.activation_token, mail.body.encoded
#     assert_match CGI::escape(user.email), mail.body.encoded
#   end
#
#   test "password_reset" do
#     user = users(:michael)
#     user.reset_token = User.new_token
#     mail = UserMailer.password_reset(user)
#     assert_equal "Password reset", mail.subject
#     assert_equal [user.email], mail.to
#     assert_equal ["noreply@example.com"], mail.from
#     assert_match user.reset_token, mail.body.encoded
#     assert_match CGI::escape(user.email), mail.body.encoded
#   end
# end
