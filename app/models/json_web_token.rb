require 'tokenizer'

class JsonWebToken
  include ActiveModel::Serialization

  def self.model_name
    @_model_name ||= :json_web_token
  end

  def initialize(payload:, exp: 1.day.from_now)
    @payload = payload
    @exp = exp
  end

  def auth_token
    @auth_token ||= Tokenizer.encode(payload: @payload.merge(claims))
  end

  private

  def claims
    {
      exp: @exp.to_i
    }
  end
end
