module Api
  module V1
    class MenusController < ApplicationController
      def index
        service = Api::V1::Menus::Fetcher.call

        render json: service.menus
      end
    end
  end
end
