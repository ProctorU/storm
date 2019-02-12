# frozen_string_literal: true

require('test_helper')

# WelcomeControllerTest
class WelcomeControllerTest < ActionDispatch::IntegrationTest
  feature 'as the initial user (unauthenticated)' do
    test 'should get index' do
      get(root_path)
      assert_response(:success)
    end
  end

  feature 'as a follow-up user (unauthenticated)' do
    before(:each) { create(:user) }

    test 'should get index' do
      get(root_path)
      assert_response(:success)
    end
  end

  feature 'as an authenticated user' do
    before(:each) { sign_in(create(:user)) }

    test 'should not get index' do
      # TODO: implement
    end
  end
end
