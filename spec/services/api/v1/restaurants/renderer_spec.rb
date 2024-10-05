require 'rails_helper'

RSpec.describe Api::V1::Restaurants::Renderer do
  describe '#call' do
    context 'when find restaurant' do
      it 'returns a restaurant' do
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

        service = described_class.call(restaurant_id: restaurant.id)

        expect(service).to be_success
        expect(service.restaurant).to eq(restaurant_response)
      end
    end

    context 'when you can not find restaurants' do
      it 'returns error' do
        service = described_class.call(restaurant_id: 1)

        expect(service).not_to be_success
        expect(service.error_message).to eq('Restaurant not found')
      end
    end
  end
end
