require('test_helper')

module Api
  module V1
    class WebsitesControllerTest < ActionDispatch::IntegrationTest
      feature 'with a valid Token' do
        let(:token) { create(:token) }

        test 'should get index' do
          get(
            api_v1_websites_path,
            headers: { 'X-AUTHORIZATION-TOKEN' => token.value }
          )
          assert_response(200)
        end

        test 'should post create' do
          params = {
            website: {
              name: 'Testing Website',
              url: 'https://proctoru.com'
            }
          }
          post(
            api_v1_websites_path,
            params: params,
            headers: { 'X-AUTHORIZATION-TOKEN' => token.value }
          )

          assert_response(201)
        end
      end

      feature 'with an invalid Token' do
        test 'should not get index' do
          get(
            api_v1_websites_path,
            headers: { 'X-AUTHORIZATION-TOKEN' => 'invalid' }
          )
          assert_response(401)
        end

        test 'should not post create' do
          params = {
            website: {
              name: 'Testing Website',
              url: 'https://proctoru.com'
            }
          }

          post(
            api_v1_websites_path,
            params: params,
            headers: { 'X-AUTHORIZATION-TOKEN' => 'invalid' }
          )
          assert_response(401)
        end
      end

      feature 'without a Token' do
        test 'should not get index' do
          get(
            api_v1_websites_path
          )
          assert_response(401)
        end

        test 'should not post create' do
          params = {
            website: {
              name: "Testing Website",
              url: "https://proctoru.com"
            }
          }
          post(
            api_v1_websites_path,
            params: params,
          )
          assert_response(401)
        end
      end
    end
  end
end
