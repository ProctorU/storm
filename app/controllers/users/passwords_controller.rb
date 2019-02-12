# frozen_string_literal: true

module Users
  # PasswordsController
  class PasswordsController < Devise::PasswordsController
    skip_before_action(:require_no_authentication, only: %w(create))
    before_action(:authenticate_user!, only: %w(create))
    before_action(:set_user, only: %w(create))

    layout('unauthenticated', only: %w(edit update))

    def create
      if @token = @user.reset_password_token!
        redirect_to(after_sending_reset_password_instructions_path_for(@user))
      else
        flash[:danger] = t('.create.fail')
        redirect_back(fallback_location: users_path)
      end
    end

    def edit
      super
    end

    private

    def authenticate_user!
      warden.authenticate!
    end

    def set_user
      @user = User.find_by!(email: params[:user][:email])
    end

    def after_sending_reset_password_instructions_path_for(user)
      users_passwords_instructions_path(
        id: user.id,
        token: @token
      )
    end

    def after_resetting_password_path_for(_resource)
      root_path
    end
  end
end
