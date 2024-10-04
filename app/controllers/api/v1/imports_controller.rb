module Api
  module V1
    class ImportsController < ApplicationController
      def create
        service = Api::V1::RestaurantImporterService.call(file: params[:file])

        render json: service.restaurant_data
      end
    end
  end
end
