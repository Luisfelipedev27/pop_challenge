require 'rails_helper'

RSpec.describe Api::V1::Menus::Renderer do
  describe '#call' do
    context 'when render menus' do
      it 'returns all menus' do
        menu = create(:menu)

        service = described_class.call(menu_id: menu.id)

        expect(service.menu).to eq(menu)
      end
    end

    context 'when you can not find menus' do
      it 'returns error' do
        service = described_class.call(menu_id: 1)

        expect(service.error_message).to eq('Menu not found')
      end
    end
  end
end
