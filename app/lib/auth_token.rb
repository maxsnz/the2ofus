require 'jwt'

class AuthToken
  class <<self
    def create(obj_or_id)
      id = obj_or_id.respond_to?(:id) ? obj_or_id.id : user_or_id

      JWT.encode({id: id}, secret, claims: { exp: 1.month.to_i })
    end

    def create_with_payload(payload)
      JWT.encode(payload, secret, claims: { exp: 1.month.to_i })
    end

    def decode(token)
      payload, header = JWT.decode(token, secret)
      payload
    rescue
      {}
    end

    def extract_id(token)
      decode(token)['id']
    end

    def secret
      Rails.application.secrets.secret_key_base
    end
  end
end
