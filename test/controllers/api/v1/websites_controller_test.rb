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
              url: 'https://proctoru.com',
              active: true
            }
          }
          post(
            api_v1_websites_path,
            params: params,
            headers: { 'X-AUTHORIZATION-TOKEN' => token.value }
          )

          assert_response(201)
          assert response_json[:id].present?
          assert response_json[:name].present?
          assert response_json[:url].present?
          assert response_json[:active]
        end

        test 'should post create and create inactive' do
          params = {
            website: {
              name: 'Testing Website',
              url: 'https://proctoru.com',
              active: false
            }
          }
          post(
            api_v1_websites_path,
            params: params,
            headers: { 'X-AUTHORIZATION-TOKEN' => token.value }
          )

          assert_response(201)
          assert response_json[:id].present?
          assert response_json[:name].present?
          assert response_json[:url].present?
          assert_not response_json[:active]
        end

        test 'should post create and return errors when invalid' do
          params = {
            website: {
              name: '',
              url: 'https://proctoru.com'
            }
          }
          post(
            api_v1_websites_path,
            params: params,
            headers: { 'X-AUTHORIZATION-TOKEN' => token.value }
          )

          assert_response(400)
          assert response_json[:status].present?
          assert response_json[:message].present?
          assert response_json[:errors].present?
          assert_includes response_json[:message], 'Invalid Attribute'
          assert_equal 1, response_json[:errors].size
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
