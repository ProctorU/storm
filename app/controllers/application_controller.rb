class ApplicationController < ActionController::Base
  protect_from_forgery(with: :exception)

  layout(:by_resource)

  before_action(:configure_permitted_parameters, if: :devise_controller?)
  before_action(:configure_app)

  private

  def by_resource
    devise_controller? ? 'unauthenticated' : 'application'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
  end

  def configure_app
    return unless AppSetup.new(current_user, request.path).required?

    flash[:info] = 'Welcome to Storm! Let\'s get your app setup.'
    redirect_to(new_user_registration_path)
  end
end
