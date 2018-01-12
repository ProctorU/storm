module Api
  module V1
    class WebsitesController < BaseController
      def index
        render(json: Website.active)
      end
    end
  end
end
