# frozen_string_literal: true

module Users
  module Invitations
    # InstructionsController
    class InstructionsController < ApplicationController
      def index
        @user = User.find(params[:id])
      end
    end
  end
end
