module Users
  # RegistrationsController
  class RegistrationsController < Devise::RegistrationsController
    before_action(:disable_registration, if: :account_setup?)

    def new
      super
    end

    private

    def account_setup?
      User.any?
    end

    def disable_registration
      flash[:warning] = t('.disable_registration')
      redirect_to(new_user_session_path)
    end
  end
end
