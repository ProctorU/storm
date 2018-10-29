require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/rails/capybara'
require 'mocha/minitest'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  Delayed::Worker.delay_jobs = false

  def response_json
    JSON.parse(response.body, symbolize_names: true)
  end
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end
