require('test_helper')

module Api
  module V1
    class BaseControllerTest < ActionDispatch::IntegrationTest
      feature 'with a valid Token' do
        let(:token) { create(:token) }

        test 'should set `last_used_at` timestamp' do
          assert_nil(token.last_used_at)
          get(
            api_v1_websites_path,
            headers: { 'X-AUTHORIZATION-TOKEN' => token.value }
          )
          assert_not_nil(token.reload.last_used_at)
        end
      end
    end
  end
end
