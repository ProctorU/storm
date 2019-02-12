# frozen_string_literal: true

require('test_helper')

module Users
  class InvitationsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @params = params
    end

    feature 'as an authenticated user' do
      before(:each) do
        sign_in(create(:user))
      end

      test 'should invite user successfully' do
        assert_difference('User.unscoped.size') do
          post(user_invitation_path, params: params)
        end
      end

      test 'should not invite user with bad email' do
        assert_no_difference('User.unscoped.size') do
          post(user_invitation_path, params: bad_params)
        end
      end
    end

    feature 'as an unauthenticated user' do
      test 'should not invite user successfully' do
        assert_no_difference('User.unscoped.size') do
          post(user_invitation_path, params: params)
        end
      end
    end

    private

    def params
      {
        user: {
          email: 'invited_user@test.com'
        }
      }
    end

    def bad_params
      {
        user: {
          email: 'bad'
        }
      }
    end
  end
end
