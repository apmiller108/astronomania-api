require 'rails_helper'
require 'tokenizer'

describe Tokenizer::Encode do
  context 'payload without exp' do
    let :payload do
      {
        user_id: 1
      }
    end

    it 'returns a JWT' do
      expect(described_class.call(payload)).to match(/\Aey/)
    end
  end

  context 'payload with exp' do
    let :payload do
      {
        user_id: 1,
        exp: 7.days.from_now
      }
    end

    it 'returns a JWT' do
      expect(described_class.call(payload)).to match(/\Aey/)
    end
  end
end
