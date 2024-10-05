require 'rails_helper'

RSpec.describe Api::V1::ImportsController, type: :request do
  describe 'POST /imports' do
    context 'when requisition is a success' do
      it 'returns list of logs' do
        file = fixture_file_upload(Rails.root.join('spec/fixtures/restaurant_data.json'), 'application/json')

        restaurant_data = {
          success: true,
          logs: [
            "Processed item: Burger in menu: lunch for restaurant: Poppo's Cafe",
            "Processed item: Small Salad in menu: lunch for restaurant: Poppo's Cafe",
            "Processed item: Burger in menu: dinner for restaurant: Poppo's Cafe",
            "Processed item: Large Salad in menu: dinner for restaurant: Poppo's Cafe",
            "Processed item: Chicken Wings in menu: lunch for restaurant: Casa del Poppo",
            "Processed item: Burger in menu: lunch for restaurant: Casa del Poppo",
            "Processed item: Chicken Wings in menu: lunch for restaurant: Casa del Poppo",
            "Processed item: Mega \"Burger\" in menu: dinner for restaurant: Casa del Poppo",
            "Processed item: Lobster Mac & Cheese in menu: dinner for restaurant: Casa del Poppo"
          ]
        }

        service = double(Api::V1::RestaurantImporterService, success?: true, restaurant_data: restaurant_data)
        allow(Api::V1::RestaurantImporterService).to receive(:call).with(file: an_instance_of(ActionDispatch::Http::UploadedFile)).and_return(service)

        post(api_v1_imports_path, params: { file: file })

        expect(response).to have_http_status(:success)
        expect(response.body).to eq(restaurant_data.to_json)
      end
    end

    context 'when requisition is a failure' do
      it 'returns error' do
        file = fixture_file_upload(Rails.root.join('spec/fixtures/another_data.json'), 'application/json')

        restaurant_data = {
          success: false,
          logs: ["Error 1", "Error 2"]
        }

        service = double(Api::V1::RestaurantImporterService, success?: false, restaurant_data: restaurant_data)
        allow(Api::V1::RestaurantImporterService).to receive(:call).with(file: an_instance_of(ActionDispatch::Http::UploadedFile)).and_return(service)

        post(api_v1_imports_path, params: { file: file })

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq({ error: ['Error 1', 'Error 2'] }.to_json)
      end
    end
  end
end
