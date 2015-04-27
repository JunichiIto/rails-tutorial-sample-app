module LoginMacros
  def is_logged_in?
    if integration_test?
      find('header').text =~ /Account/
    else
      session[:user_id]
    end
  end

  def log_in_as(user, options = {})
    if integration_test?
      password = options[:password] || 'password'
      remember_me = options[:remember_me] || '1'
      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: password
      if remember_me == '1'
        check 'Remember me on this computer'
      end
      click_button 'Log in'
    else
      session[:user_id] = user.id
    end
  end

  def integration_test?
    !respond_to?(:session)
  end
end