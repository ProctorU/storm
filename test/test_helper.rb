require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails/capybara'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  Delayed::Worker.delay_jobs = false
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end
