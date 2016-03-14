class ApplicationController < ActionController::Base

  protect_from_forgery

  protected
  def authenticate_basic
    authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "Camel"
    end
  end

  def allow_xframe
    response.headers.except! 'X-Frame-Options'
  end
end
