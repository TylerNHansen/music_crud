class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  # must call method after authenticating user
  def login!(user)
    user.make_session_token!
    session[:session_token] = user.session_token
    @current_user = user
  end

  def current_user
    @current_user ||= User.from_session(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def logout
    current_user.make_session_token!
    @current_user = nil
    session[:token] = nil
  end


end
