require 'rails_helper'
require 'paginate'

describe Paginate::MetaData do
  before :all do
    create_list :asteroid_near_earth_object, 41
  end

  after :all do
    Asteroid::NearEarthObject.destroy_all
  end

  let :relation do
    Asteroid::NearEarthObject.all
  end

  let :path do
    '/asteroids/near_earth_objects'
  end

  describe 'first page' do
    let :params do
      {
        page: '0',
        size: '20'
      }
    end

    describe 'pagination data' do
      subject do
        described_class.new(relation, path, params).call[:pagination]
      end

      it { expect(subject[:page_number]).to eq 0 }
      it { expect(subject[:size]).to eq 20 }
      it { expect(subject[:total_records]).to eq 41 }
      it { expect(subject[:total_pages]).to eq 3 }
    end

    describe 'links' do
      subject do
        described_class.new(relation, path, params).call[:pagination][:links]
      end

      it 'does not have prev link' do
        expect(subject[:prev]).to be nil
      end

      it 'has a self link' do
        expect(subject[:self]).to eq "#{path}?page=0&size=20"
      end

      it 'has a next link' do
        expect(subject[:next]).to eq "#{path}?page=1&size=20"
      end
    end
  end

  describe 'second page' do
    let :params do
      {
        page: '1',
        size: '20'
      }
    end

    describe 'pagination data' do
      subject do
        described_class.new(relation, path, params).call[:pagination]
      end

      it { expect(subject[:page_number]).to eq 1 }
      it { expect(subject[:size]).to eq 20 }
      it { expect(subject[:total_records]).to eq 41 }
      it { expect(subject[:total_pages]).to eq 3 }
    end

    describe 'links' do
      subject do
        described_class.new(relation, path, params).call[:pagination][:links]
      end

      it 'has prev link' do
        expect(subject[:prev]).to eq "#{path}?page=0&size=20"
      end

      it 'has a self link' do
        expect(subject[:self]).to eq "#{path}?page=1&size=20"
      end

      it 'has a next link' do
        expect(subject[:next]).to eq "#{path}?page=2&size=20"
      end
    end
  end

  describe 'last page' do
    let :params do
      {
        page: '2',
        size: '20'
      }
    end

    describe 'pagination data' do
      subject do
        described_class.new(relation, path, params).call[:pagination]
      end

      it { expect(subject[:page_number]).to eq 2 }
      it { expect(subject[:size]).to eq 20 }
      it { expect(subject[:total_records]).to eq 41 }
      it { expect(subject[:total_pages]).to eq 3 }
    end

    describe 'links' do
      subject do
        described_class.new(relation, path, params).call[:pagination][:links]
      end

      it 'has prev link' do
        expect(subject[:prev]).to eq "#{path}?page=1&size=20"
      end

      it 'has a self link' do
        expect(subject[:self]).to eq "#{path}?page=2&size=20"
      end

      it 'does not have a next link' do
        expect(subject[:next]).to eq nil
      end
    end
  end
end
