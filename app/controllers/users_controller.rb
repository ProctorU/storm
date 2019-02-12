# frozen_string_literal: true

class UsersController < ApplicationController
  before_action(:set_user, only: %w(destroy))

  def index
    @users = User.decorate
  end

  def destroy
    @user.destroy

    flash[:success] = t('.success', email: @user.email)
    redirect_back(fallback_location: users_path)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
