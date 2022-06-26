class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :user_is_logged_in?

  def user_is_logged_in?
    !!session[:user_id]
  end
end
