class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery with: :exception
  helper_method :user_is_logged_in? 
  helper_method :send_success
  helper_method :send_failed

  def user_is_logged_in?
    !!session[:user_id]
  end

  def send_success(message, payload)
    {
      status: "SUCCESS",
      url: request.host,
      message: message,
      payload: payload
    }
  end

  def send_failed(message, payload = nil)
    {
      status: "FAILED",
      url: request.host,
      message: message,
      payload: payload
    }
  end
end
