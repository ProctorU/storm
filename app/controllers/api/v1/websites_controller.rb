# frozen_string_literal: true

module Api
  module V1
    class WebsitesController < BaseController
      def index
        render(
          json: Website.active.decorate,
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

      private

      def website_params
        params.require(:website).permit(
          :name, :url, :basic_auth_username, :basic_auth_password,
          :active, :aws_instance_id, :aws_region
        )
      end
    end
  end
end
