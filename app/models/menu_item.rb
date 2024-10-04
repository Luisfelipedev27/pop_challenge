class MenuItem < ApplicationRecord
  belongs_to :menu

  validates :name, :price, presence: true
end
