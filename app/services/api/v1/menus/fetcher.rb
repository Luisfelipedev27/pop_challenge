module Api
  module V1
    module Menus
      class Fetcher < ApplicationService
        attr_reader :menus

        def call
          fetch_menus

          self
        end

        private

        attr_writer :menus

        def fetch_menus
          self.menus = Menu.all

          true
        end
      end
    end
  end
end
