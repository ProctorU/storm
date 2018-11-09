# WebsitesController
class WebsitesController < ApplicationController
  include PaginatableConcern

  before_action(:set_website, only: %w(show edit update destroy))

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
    @pings = @website.paginatable_pings.paginate(params).decorate
  end

  def edit; end

  def update
    if @website.update(website_params)
      flash[:success] = t('.success', name: @website.name)
      redirect_to(root_path)
    else
      render(:edit)
    end
  end

  def destroy
    WebsiteDestroyerJob.perform_later(@website)
    flash[:success] = t('.success', name: @website.name)
    redirect_to(root_path)
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
