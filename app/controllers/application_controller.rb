class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def current_user
    User.find_by_id(session[:user_id])
  end
  helper_method :current_user

  def require_login
    return true if current_user
    redirect_to "/auth/github" and false
  end
end
