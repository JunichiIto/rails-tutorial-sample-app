module LoginMacros
  def is_logged_in?
    if self.respond_to? :session
      session[:user_id]
    else
      find('header').text =~ /Account/
    end
  end

  def log_in_as(user, options = {})
    password = options[:password] || 'password'
    remember_me = options[:remember_me] || '1'
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: password
    if remember_me == '1'
      check 'Remember me on this computer'
    end
    click_button 'Log in'
  end
end