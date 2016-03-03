class Api::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token

  protected

  def render_json(json, options = {})
    render({json: json, callback: params[:callback]}.merge(options))
  end
end
