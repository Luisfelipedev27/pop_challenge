module Api
  module V1
    class RestaurantImporterService < ApplicationService
      attr_reader :restaurant_data

      def initialize(file:)
        self.file = file
      end

      def call
        import_restaurants

        self
      end

      private

      attr_writer :restaurant_data

      attr_accessor :file

      def import_restaurants
        logs = []
        success = true

        data = JSON.parse(File.read(file.path))

        begin
          data['restaurants'].each do |restaurant_data|
            restaurant = Restaurant.find_or_create_by!(name: restaurant_data['name'])
            restaurant_data['menus'].each do |menu_data|
              menu = restaurant.menus.find_or_create_by!(name: menu_data['name'])

              items_key = menu_data['menu_items'] ? 'menu_items' : 'dishes'
              menu_data[items_key].each do |item_data|
                menu_item = MenuItem.find_or_create_by!(name: item_data['name'], price: item_data['price'], menu: menu)
                logs << "Processed item: #{menu_item.name} in menu: #{menu.name} for restaurant: #{restaurant.name}"
              end
            end
          end
        rescue => e
          success = false
          logs << "Error #{e.message}"
        end

        self.restaurant_data = {
          success: success,
          logs: logs
        }
      end
    end
  end
end
