module Api
  module V1
    class MenusController < ApplicationController
      def index
        service = Api::V1::Menus::Fetcher.call

        if service.success?
          render json: service.menus
        else
          render json: { error: service.error_message }, status: :not_found
        end
      end

      def show
        service = Api::V1::Menus::Renderer.call(menu_id: params[:id])

        if service.success?
          render json: service.menu
        else
          render json: { error: service.error_message }, status: :not_found
        end
      end
    end
  end
end
