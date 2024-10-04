module Api
  module V1
    class RestaurantsController < ApplicationController
      def index
        service = Api::V1::Restaurants::Fetcher.call

        render json: service.restaurants
      end

      def show
        service = Api::V1::Restaurants::Renderer.call(restaurant_id: params[:id])

        if service.success?
          render json: service.restaurant
        else
          render json: { error: service.error_message }, status: :not_found
        end
      end
    end
  end
end
