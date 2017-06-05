require 'rails_helper'

describe User do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it { is_expected.to have_secure_password }

  describe 'validations' do
    subject do
      build :user
    end

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_length_of(:email).is_at_most(255) }
    it { is_expected.to validate_length_of(:password).is_at_least(8) }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to validate_presence_of(:password_confirmation) }
  end
end
