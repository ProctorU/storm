class UsersController < ApplicationController
  def index
    @users = User.decorate
  end
end
