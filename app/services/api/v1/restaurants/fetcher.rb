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
          self.restaurants = Restaurant.all

          true
        end
      end
    end
  end
end
