# WebsitesController
class WebsitesController < ApplicationController
  include PaginatableConcern

  def index
    @websites = Website.active.paginate(params).decorate

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
    @website = Website.find(params[:id])
    @pings = @website.monthly_pings.paginate(params).decorate
  end

  def edit
    @website = Website.find(params[:id])
  end

  def update
    @website = Website.find(params[:id])

    if @website.update(website_params)
      flash[:success] = t('.success', name: @website.name)
      redirect_to(root_path)
    else
      render(:edit)
    end
  end

  private

  def website_params
    params.require(:website).permit(
      :name, :url, :basic_auth_username, :basic_auth_password,
      :aws_instance_id, :aws_region
    )
  end
end
