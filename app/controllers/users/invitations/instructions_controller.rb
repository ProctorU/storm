module Users
  module Invitations
    # InstructionsController
    class InstructionsController < ApplicationController
      before_action(:authenticate_user!)

      def index
        @user = User.find(params[:id])
      end
    end
  end
end
