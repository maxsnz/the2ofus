class Authenticate
  include CallableClass

  attr_reader :auth, :existing_user

  def initialize(auth, existing_user)
    @auth = auth
    @existing_user = existing_user
  end

  # @returns [User]
  def call
    authentication = Authentication.find_or_initialize_by(uid: auth.uid, provider: auth.provider)
    authentication.access_token = auth.credentials.token

    authentication.user ||= existing_user || User.new
    authentication.user.name ||= auth.info.name.presence || auth.info.nickname.presence || auth.uid
    authentication.user.email ||= auth.info.email

    authentication.save!

    authentication
  end
end
