class AuthenticationsController < ApplicationController
  after_action :allow_xframe

  def create
    auth = env['omniauth.auth']
    logger.debug("!!! #{auth.info.inspect}")
    existing_token = env['omniauth.params']['token']
    logged_in_user = existing_token.presence && User.find_by(id: AuthToken.extract_id(existing_token))
    authentication = Authenticate.call(auth, logged_in_user)
    user = authentication.user
    token = AuthToken.create(user)
    instagram = request.env['omniauth.params']['instagram'] == "true"
    @message = {token: token, user: user, instagram: instagram}
  end

  def failure
    logger.debug("~ #{params[:message]}")
    @message = {error: params[:message]}
    render :create
  end
end
