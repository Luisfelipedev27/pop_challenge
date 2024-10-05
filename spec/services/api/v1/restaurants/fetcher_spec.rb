require 'rails_helper'

RSpec.describe Api::V1::Restaurants::Fetcher do
  describe '#call' do
    context 'when fetch restaurants' do
      it 'returns all restaurants' do
        restaurant = create(:restaurant)

        restaurant_response = {
          name: restaurant.name,
          menus: restaurant.menus.map do |menu|
            {
              name: menu.name,
              menu_items: menu.menu_items.map do |menu_item|
                {
                  name: menu_item.name,
                  price: menu_item.price
                }
              end
            }
          end
        }

        service = described_class.call

        expect(service).to be_success
        expect(service.restaurants).to eq([restaurant_response])
      end
    end

    context 'when you can not find restaurants' do
      it 'returns an empty array' do

        service = described_class.call

        expect(service).to be_success
        expect(service.restaurants).to eq([])
      end
    end
  end
end
