require('test_helper')

module Websites
  module Charts
    # ResponseTimeControllerTest
    class ResponseTimeControllerTest < ActionDispatch::IntegrationTest
      setup do
        @website = create(:website)
      end

      feature 'as as authenticated user' do
        before(:each) do
          @user = create(:user)
          sign_in(@user)
        end

        test 'should get index' do
          get(website_charts_response_time_index_path(@website))
          assert_response(:success)
        end
      end

      feature 'as an unauthenticated user' do
        test 'should not get index' do
          get(website_charts_response_time_index_path(@website))
          assert_redirected_to(:new_user_registration)
        end
      end
    end
  end
end
