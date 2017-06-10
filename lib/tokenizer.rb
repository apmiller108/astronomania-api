require_relative 'tokenizer/encode'
require_relative 'tokenizer/decode'

module Tokenizer
  def self.encode(payload)
    Encode.call(payload)
  end

  def self.decode(token)
    Decode.call(token)
  end
end
