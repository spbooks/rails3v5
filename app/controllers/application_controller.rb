class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user

  protected

  def current_user
    return unless session[:user_id]
    @current_user = User.where(id: session[:user_id]).first
  end

  def ensure_login
    return true if logged_in?
    session[:return_to] = request.fullpath
    redirect_to new_session_path and return false
  end

  def logged_in?
    !@current_user.nil?
  end
  helper_method :logged_in?
end
