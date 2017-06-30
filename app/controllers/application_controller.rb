class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :by_resource

  private

  def by_resource
    devise_controller? ? 'unauthenticated' : 'application'
  end
end
