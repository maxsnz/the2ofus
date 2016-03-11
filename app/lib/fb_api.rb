class FbApi
  include HTTParty

  base_uri 'https://graph.facebook.com/v2.3'
  default_params access_token: Apps.facebook.access_token
end
