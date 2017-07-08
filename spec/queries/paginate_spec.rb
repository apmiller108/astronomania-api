require 'rails_helper'

describe Paginate do
  before :all do
    create_list :asteroid_near_earth_object, 41
  end

  after :all do
    Asteroid::NearEarthObject.destroy_all
  end

  let :relation do
    Asteroid::NearEarthObject.all
  end

  let :first_twenty_ids do
    Asteroid::NearEarthObject.offset(0).limit(20).ids
  end

  context 'without options' do
    subject do
      described_class.new(relation).perform
    end

    it 'returns the first twenty records' do
      expect(subject.ids).to contain_exactly(*first_twenty_ids)
    end
  end

  context 'when options are nil' do
    subject do
      described_class.new(relation, per: nil, page: nil).perform
    end

    it 'returns the first twenty records' do
      expect(subject.ids).to contain_exactly(*first_twenty_ids)
    end
  end

  context 'when options are empty strings' do
    subject do
      described_class.new(relation, per: '', page: '').perform
    end

    it 'returns the first twenty records' do
      expect(subject.ids).to contain_exactly(*first_twenty_ids)
    end
  end

  context 'when per option is greater than 20' do
    subject do
      described_class.new(relation, per: 100, page: 2).perform
    end

    let :ids do
      Asteroid::NearEarthObject.offset(20).limit(20).ids
    end

    it 'respects the requested page number but defaults to 20 records' do
      expect(subject.ids).to contain_exactly(*ids)
    end
  end

  context 'when page option exceeds the actual number of pages' do
    subject do
      described_class.new(relation, per: 20, page: 4).perform
    end

    it 'is empty' do
      expect(subject).to be_empty
    end
  end

  context 'when options are 5 per page starting at page 2' do
    subject do
      described_class.new(relation, per: 5, page: 2).perform
    end

    let :ids do
      Asteroid::NearEarthObject.offset(5).limit(5).ids
    end

    it 'returns the 2nd set of 5 records' do
      expect(subject.ids).to contain_exactly(*ids)
    end
  end
end
