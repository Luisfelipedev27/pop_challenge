module Api
  module V1
    module Restaurants
      class Renderer < ApplicationService
        attr_reader :restaurant

        def initialize(restaurant_id:)
          self.restaurant_id = restaurant_id
        end

        def call
          fetch_restaurant

          self
        end

        private

        attr_writer :restaurant

        attr_accessor :restaurant_id

        def fetch_restaurant
          self.restaurant = Restaurant.find(restaurant_id)

          true
        rescue ActiveRecord::RecordNotFound
          self.error_message = "Restaurant not found"

          false
        end
      end
    end
  end
end
