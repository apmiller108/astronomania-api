require 'rails_helper'
require 'tokenizer'

describe Tokenizer::Decode do
  let :valid_payload do
    {
      iss: 'astronomania-api',
      aud: 'web-client',
      exp: 1.day.from_now.to_i,
      user_id: 1
    }
  end

  context 'valid token' do
    let :encoded_jwt do
      JWT.encode(valid_payload,
                 Rails.application.secrets.secret_key_base,
                 'HS256')
    end

    subject do
      described_class.call(encoded_jwt)
    end

    it 'returns the decoded token' do
      expect(subject[0]['user_id']).to eq 1
    end
  end

  context 'expired token' do
    let :payload do
      valid_payload.merge exp: 1.day.ago
    end

    let :encoded_jwt do
      JWT.encode(payload,
                 Rails.application.secrets.secret_key_base,
                 'HS256')
    end

    subject do
      described_class.call(encoded_jwt)
    end

    it 'returns the decoded token' do
      expect(subject).to be false
    end
  end

  context 'incorrect issuer claim' do
    let :payload do
      valid_payload.merge iss: 'some other api'
    end

    let :encoded_jwt do
      JWT.encode(payload,
                 Rails.application.secrets.secret_key_base,
                 'HS256')
    end

    subject do
      described_class.call(encoded_jwt)
    end

    it 'returns the decoded token' do
      expect(subject).to be false
    end
  end

  context 'incorrect audience claim' do
    let :payload do
      valid_payload.merge aud: 'some other audience'
    end

    let :encoded_jwt do
      JWT.encode(payload,
                 Rails.application.secrets.secret_key_base,
                 'HS256')
    end

    subject do
      described_class.call(encoded_jwt)
    end

    it 'returns the decoded token' do
      expect(subject).to be false
    end
  end
end
