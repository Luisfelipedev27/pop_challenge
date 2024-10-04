module Api
  module V1
    module Restaurants
      class Fetcher < ApplicationService
        attr_reader :restaurants

        def call
          fetch_restaurants

          self
        end

        private

        attr_writer :restaurants

        def fetch_restaurants
          self.restaurants = Restaurant.all.map do |restaurant|
            {
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
          end
        end
      end
    end
  end
end
