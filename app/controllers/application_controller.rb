class ApplicationController < ActionController::Base
  before_action :authenticate_with_basic_auth
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  # Heroku上でのいたずらを防ぐためにBasic認証を付ける
  def authenticate_with_basic_auth
    if Rails.env.production?
      authenticate_or_request_with_http_basic do |user, pass|
        user == ENV['BASIC_AUTH_USER'] && pass == ENV['BASIC_AUTH_PASS']
      end
    end
  end
end
