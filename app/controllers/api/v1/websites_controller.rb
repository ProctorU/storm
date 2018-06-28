module Api
  module V1
    class WebsitesController < BaseController
      before_action :set_website, only: %w(update destroy)

      def index
        render(
          json: Website.decorate,
          each_serializer: WebsiteSerializer
        )
      end

      def create
        @website = Website.new(website_params)

        if @website.save
          respond_with @website, status: 201
        else
          respond_with @website, status: 400
        end
      end

      def update
        if @website.update(website_params)
          respond_with @website, status: 200
        else
          respond_with @website, status: 400
        end
      end

      def destroy
        @website.destroy
        head :ok
      end

      private

      def set_website
        @website = Website.find(params[:id])
      end

      def website_params
        params.require(:website).permit(
          :name, :url, :basic_auth_username, :basic_auth_password,
          :aws_instance_id, :aws_region
        )
      end
    end
  end
end
