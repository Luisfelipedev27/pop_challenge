require 'rails_helper'

RSpec.describe Api::V1::MenusController, type: :request do
  describe 'GET /menus' do
    context 'when requisition is a success' do
      it 'returns all menus' do
        menu = create(:menu)

        get(api_v1_menus_path)

        expect(response).to have_http_status(:success)
        expect(response.body).to eq([menu].to_json)
      end
    end

    context 'when requisition is a failure' do
      it 'returns an empty array' do
        get(api_v1_menus_path)

        expect(response).to have_http_status(:success)
        expect(response.body).to eq([].to_json)
      end
    end
  end
end
