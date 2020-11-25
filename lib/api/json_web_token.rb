module Api
  class JsonWebToken
    def self.encode(payload, exp = 6.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, ENV.fetch('JWT_SECRET'), 'HS512')
    end

    def self.decode(token)
      body, = JWT.decode(token, ENV.fetch('JWT_SECRET'), true, { algorithm: 'HS512' })
      HashWithIndifferentAccess.new body
    rescue JWT::DecodeError
      false
    end
  end
end
