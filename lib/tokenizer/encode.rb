module Tokenizer
  class Encode
    def self.call(payload)
      new(payload).encode
    end

    def initialize(payload)
      @payload = payload
    end

    def encode
      JWT.encode(@payload.merge(claims),
                 Rails.application.secrets.secret_key_base,
                 'HS256')
    end

    private

    def claims
      {
        iss: 'astronomania-api',
        aud: 'web-client',
        exp: token_expiration
      }
    end

    def token_expiration
      @payload[:exp] || 1.day.from_now.to_i
    end
  end
end
