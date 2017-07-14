# WebsitesController
class WebsitesController < ApplicationController
  before_action(:authenticate_user!, unless: :devise_controller?)

  def index
    @websites = Website.active
  end

  def new
    @website = Website.new
  end

  def create
    @website = Website.new(website_params)

    if @website.save
      flash[:success] = t('.success', name: @website.name)
      redirect_to(root_path)
    else
      render(:new)
    end
  end

  private

  def website_params
    params.require(:website).permit(
      :name, :url, :basic_auth_username, :basic_auth_password
    )
  end
end
