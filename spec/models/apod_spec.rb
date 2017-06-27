require 'rails_helper'

describe Apod do
  it 'has a valid factory' do
    expect(build(:apod)).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :date }
    it { is_expected.to validate_presence_of :explanation }
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :url }
  end
end
