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

  describe 'scopes' do
    describe '.latest' do
      it 'returns the most recent Apod' do
        create :apod, date: Date.today
        create :apod, date: Date.yesterday

        expect(described_class.latest.date).to eq Date.today
      end
    end
  end
end
