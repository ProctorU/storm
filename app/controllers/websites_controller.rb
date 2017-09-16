# WebsitesController
class WebsitesController < ApplicationController
  include PaginatableConcern

  def index
    @websites = Website.includes(:pings).active.paginate(params).decorate

    respond_to do |format|
      format.html
      format.json { return_paginated_resource }
    end
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

  def show
    @website = Website.includes(:pings).find(params[:id])
    @pings = @website.pings.paginate(params).decorate
  end

  private

  def website_params
    params.require(:website).permit(
      :name, :url, :basic_auth_username, :basic_auth_password
    )
  end
end
