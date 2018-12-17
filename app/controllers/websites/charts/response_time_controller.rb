module Websites
  module Charts
    # ResponseTimeController
    class ResponseTimeController < Websites::BaseController
      def index
        respond_to do |format|
          format.html
          format.json do
            @data = ::Charts::ResponseTime.new(
              @website.daily_pings.without_outliers
            ).aggregate
            render json: @data
          end
        end
      end
    end
  end
end
