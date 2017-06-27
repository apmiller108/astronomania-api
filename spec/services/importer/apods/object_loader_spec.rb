require 'rails_helper'
include MockResponses

describe Importer::Apods::ObjectLoader do
  let :apod_with_valid_attributes do
    JSON.parse(valid_apod)
  end

  let :apod_with_invalid_attributes do
    JSON.parse(invalid_apod)
  end

  subject do
    described_class.new
  end

  context 'with valid attributes' do
    context 'when apod is new' do
      it 'creates a new apod' do
        subject.create_or_update(apod_with_valid_attributes)

        expect(Apod.count).to eq 1
      end
    end

    context 'when apod already exists' do
      let! :existing_apod do
        create :apod, date: Date.current, title: 'old title'
      end

      it 'updates the apod' do
        apod_with_valid_attributes['date'] = Date.current.to_s

        subject.create_or_update(apod_with_valid_attributes)

        expect(existing_apod.reload.title).to(
          eq apod_with_valid_attributes['title']
        )
      end
    end
  end

  context 'with invalid attributes' do
    it 'raises RecordInvalid exception' do
      expect do
        subject.create_or_update(apod_with_invalid_attributes)
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
