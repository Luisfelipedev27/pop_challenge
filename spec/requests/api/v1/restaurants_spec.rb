require 'rails_helper'

RSpec.describe Api::V1::RestaurantsController, type: :request do
  describe 'GET /restaurants' do
    context 'when requisition is a success' do
      it 'returns all restaurants' do
        restaurant = create(:restaurant)

        get(api_v1_restaurants_path)

        expect(response).to have_http_status(:success)
        expect(response.body).to eq([restaurant].to_json)
      end

      it 'returns an empty array' do
        get(api_v1_restaurants_path)

        expect(response).to have_http_status(:success)
        expect(response.body).to eq([].to_json)
      end
    end
  end

  describe 'GET /restaurants/:id' do
    context 'when requisition is a success' do
      it 'returns a restaurant' do
        restaurant = create(:restaurant)

        get(api_v1_restaurant_path(restaurant.id))

        expect(response).to have_http_status(:success)
        expect(response.body).to eq(restaurant.to_json)
      end
    end

    context 'when requisition is a failure' do
      it 'returns error' do
        get(api_v1_restaurant_path(1))

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq({ error: 'Restaurant not found' }.to_json)
      end
    end
  end
end
