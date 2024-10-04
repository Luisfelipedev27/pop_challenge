require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:restaurant) }
    it { is_expected.to have_many(:menu_items) }
  end
end
