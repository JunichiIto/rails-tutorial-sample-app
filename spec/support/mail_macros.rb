module MailMacros
  def extract_activation_token_from_last_mail
    last_mail_body[/(?<=account_activations\/)[^\/]+/]
  end

  def extract_reset_token_from_last_mail
    last_mail_body[/(?<=password_resets\/)[^\/]+/]
  end

  def last_mail_body
    ActionMailer::Base.deliveries.last.body.encoded
  end
end