class Api::UsersController < Api::BaseController
  before_filter :authenticate!

  def update
    unless current_user.email?
      current_user.email = resource_params[:email]
      # current_user.validate_email = true
    end

    if current_user.save
      render_json({ok: true, user: current_user})
    else
      render_json({ok: false, errors: current_user.errors}, status: 422)
    end
  end

  private

  def resource_params
    params.permit(:email)
  end
end
