require 'rails_helper'

RSpec.describe Api::V1::Restaurants::Renderer do
  describe '#call' do
    context 'when find restaurant' do
      it 'returns a restaurant' do
        restaurant = create(:restaurant)

        service = described_class.call(restaurant_id: restaurant.id)

        expect(service.restaurant).to eq(restaurant)
      end
    end

    context 'when you can not find restaurants' do
      it 'returns error' do
        service = described_class.call(restaurant_id: 1)

        expect(service.error_message).to eq('Restaurant not found')
      end
    end
  end
end
