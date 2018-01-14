module Api
  module V1
    class WebsitesController < BaseController
      def index
        render(
          json: Website.active.decorate,
          each_serializer: WebsiteSerializer
        )
      end
    end
  end
end
