module Api
  module V1
    module Menus
      class Renderer < ApplicationService
        attr_reader :menu

        def initialize(menu_id:)
          self.menu_id = menu_id
        end

        def call
          fetch_menu

          self
        end

        private

        attr_writer :menu

        attr_accessor :menu_id

        def fetch_menu
          self.menu = Menu.find(menu_id)

          true
        rescue ActiveRecord::RecordNotFound
          self.error_message = 'Menu not found'

          false
        end
      end
    end
  end
end
