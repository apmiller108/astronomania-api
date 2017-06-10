module Tokenizer
  class Decode
    def self.call(token)
      new(token).decode
    end

    def initialize(token)
      @token = token
    end

    def decode
      JWT.decode(@token,
                 Rails.application.secrets.secret_key_base,
                 true,
                 decode_options)
    rescue JWT::DecodeError
      false
    end

    private

    def decode_options
      {
        algorithm: 'HS256',
        iss: 'astronomania-api',
        verify_iss: true,
        aud: 'web-client',
        verify_aud: true
      }
    end
  end
end
