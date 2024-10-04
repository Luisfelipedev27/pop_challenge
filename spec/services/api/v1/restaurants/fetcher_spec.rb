require 'rails_helper'

RSpec.describe Api::V1::Restaurants::Fetcher do
  describe '#call' do
    context 'when fetch restaurants' do
      it 'returns all restaurants' do
        restaurant = create(:restaurant)

        service = described_class.call

        expect(service.restaurants).to eq([restaurant])
      end
    end

    context 'when you can not find restaurants' do
      it 'returns an empty array' do
        service = described_class.call

        expect(service.restaurants).to eq([])
      end
    end
  end
end
