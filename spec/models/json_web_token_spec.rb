require 'rails_helper'

describe JsonWebToken do
  describe '#initialize' do
    it 'does not raise an exception' do
      expect do
        described_class.new(payload: { user_id: 1 })
      end.to_not raise_exception
    end
  end

  describe '#auth_token' do
    context 'default exp' do
      subject do
        described_class.new(payload: { user_id: 1 })
      end

      it 'returns a JWT' do
        expect(subject.auth_token).to match(/\Aey/)
      end
    end

    context 'with optional exp argument' do
      subject do
        described_class.new(payload: { user_id: 1 }, exp: 7.days.from_now)
      end

      it 'returns and JWT' do
        expect(subject.auth_token).to match(/\Aey/)
      end
    end
  end
end
