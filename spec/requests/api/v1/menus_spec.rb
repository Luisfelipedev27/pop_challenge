require 'rails_helper'

RSpec.describe Api::V1::MenusController, type: :request do
  describe 'GET /menus' do
    context 'when requisition is a success' do
      it 'returns all menus' do
        menu = create(:menu)

        service = double(Api::V1::Menus::Fetcher, success?: true, menus: [menu])
        allow(Api::V1::Menus::Fetcher).to receive(:call).and_return(service)

        get(api_v1_menus_path)

        expect(response).to have_http_status(:success)
        expect(response.body).to eq([menu].to_json)
      end

      it 'returns an empty array' do
        service = double(Api::V1::Menus::Fetcher, success?: true, menus: [])
        allow(Api::V1::Menus::Fetcher).to receive(:call).and_return(service)

        get(api_v1_menus_path)

        expect(response).to have_http_status(:success)
        expect(response.body).to eq([].to_json)
      end
    end
  end

  describe 'GET /menus/:id' do
    context 'when requisition is a success' do
      it 'returns a menu' do
        menu = create(:menu)

        service = double(Api::V1::Menus::Fetcher, success?: true, menus: [menu])
        allow(Api::V1::Menus::Fetcher).to receive(:call).with(menu_id: menu.id).and_return(service)

        get(api_v1_menu_path(menu.id))

        expect(response).to have_http_status(:success)
        expect(response.body).to eq(menu.to_json)
      end
    end

    context 'when requisition is a failure' do
      it 'returns error' do
        service = double(Api::V1::Menus::Fetcher, success?: false, error_message: 'Menu not found')
        allow(Api::V1::Menus::Fetcher).to receive(:call).with(menu_id: 1).and_return(service)

        get(api_v1_menu_path(1))

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq({ error: 'Menu not found' }.to_json)
      end
    end
  end
end
