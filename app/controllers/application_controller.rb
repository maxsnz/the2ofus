class ApplicationController < ActionController::Base

  protect_from_forgery

  protected
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "Crocodile"
    end
  end

  def allow_xframe
    response.headers.except! 'X-Frame-Options'
  end
end
