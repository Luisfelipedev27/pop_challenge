require 'rails_helper'

RSpec.describe Api::V1::RestaurantsController, type: :request do
  describe 'GET /restaurants' do
    context 'when requisition is a success' do
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

        service = double(Api::V1::Restaurants::Fetcher, success?: true, restaurants: [restaurant_response])
        allow(Api::V1::Restaurants::Fetcher).to receive(:call).and_return(service)

        get(api_v1_restaurants_path)

        expect(response).to have_http_status(:success)
        expect(response.body).to eq([restaurant_response].to_json)
      end

      it 'returns an empty array' do
        get(api_v1_restaurants_path)

        service = double(Api::V1::Restaurants::Fetcher, success?: true, restaurants: [])
        allow(Api::V1::Restaurants::Fetcher).to receive(:call).and_return(service)

        expect(response).to have_http_status(:success)
        expect(response.body).to eq([].to_json)
      end
    end
  end

  describe 'GET /restaurants/:id' do
    context 'when requisition is a success' do
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

        service = double(Api::V1::Restaurants::Fetcher, success?: true, restaurants: [restaurant_response])
        allow(Api::V1::Restaurants::Fetcher).to receive(:call).with(restaurant_id: restaurant.id).and_return(service)

        get(api_v1_restaurant_path(restaurant.id))

        expect(response).to have_http_status(:success)
        expect(response.body).to eq(restaurant_response.to_json)
      end
    end

    context 'when requisition is a failure' do
      it 'returns error' do
        service = double(Api::V1::Restaurants::Fetcher, success?: false, error_message: 'Restaurant not found')
        allow(Api::V1::Restaurants::Fetcher).to receive(:call).with(restaurant_id: 1).and_return(service)

        get(api_v1_restaurant_path(1))

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq({ error: 'Restaurant not found' }.to_json)
      end
    end
  end
end
