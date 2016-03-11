class Api::BaseController < ApplicationController
  # skip_before_filter :verify_authenticity_token

  private

  def render_json(json, options = {})
    render({json: json, callback: params[:callback]}.merge(options))
  end

  def authenticate!
    authenticate
    render_json({status: "error", error: "Invalid token"}, status: 401) unless current_account
  end

  def authenticate
    token = params[:token]
    @current_account = token.presence && User.find_by(id: AuthToken.extract_id(token))
    if token.present?
      logger.debug("~ #{token.inspect} -> #{current_account.try(:id).inspect}")
    end
  end

  def current_account
    @current_account
  end
end
