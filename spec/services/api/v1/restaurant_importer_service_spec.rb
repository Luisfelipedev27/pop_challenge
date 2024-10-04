require 'rails_helper'

RSpec.describe Api::V1::RestaurantImporterService, type: :service do
  context 'when importing data' do
    it 'imports data from json file' do
      file = File.open(Rails.root.join('spec/fixtures/restaurant_data.json'))

      service = described_class.call(file: file)

      expect(service.restaurant_data[:success]).to be_truthy
    end

    it 'handles errors' do
      file = File.open(Rails.root.join('spec/fixtures/another_data.json'))

      service = described_class.call(file: file)

      expect(service.restaurant_data[:success]).to be_falsey
    end
  end
end
