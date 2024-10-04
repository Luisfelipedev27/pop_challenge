require 'rails_helper'

RSpec.describe Api::V1::Menus::Fetcher do
  describe '#call' do
    context 'when fetch menus' do
      it 'returns all menus' do
        menu = create(:menu)

        service = described_class.call

        expect(service.menus).to eq([menu])
      end
    end

    context 'when you can not find menus' do
      it 'returns an empty array' do
        service = described_class.call

        expect(service.menus).to eq([])
      end
    end
  end
end
