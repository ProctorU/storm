module Websites
  # BaseController
  class BaseController < ApplicationController
    before_action(:set_website)

    private

    def set_website
      @website = Website.find(params[:website_id])
    end
  end
end
