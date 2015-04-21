module LoginMacros
  def is_logged_in?
    find('header').text =~ /Account/
  end

  def log_in_as(user, options = {})
    password = options[:password] || 'password'
    remember_me = options[:remember_me] || '1'
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: password
    if remember_me
      check 'Remember me on this computer'
    end
    click_button 'Log in'
  end
end