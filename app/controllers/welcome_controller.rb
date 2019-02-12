# frozen_string_literal: true

# WelcomeController
class WelcomeController < ApplicationController
  skip_before_action(:authenticate_user!)
  layout('unauthenticated')

  def index; end
end
