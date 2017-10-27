require('test_helper')

module Users
  class PasswordsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = create(:user)
      @params = params
    end

    feature 'as an authenticated user' do
      before(:each) do
        sign_in(@user)
      end

      test 'should create password reset token successfully' do
        token = @user.reset_password_token
        post('/users/password', params: params)
        assert_not_equal(token, @user.reload.reset_password_token)
      end

      test 'should raise RecordNotFound' do
        assert_raise do
          post('/users/password', params: bad_params)
        end
      end
    end

    feature 'as an unauthenticated user' do
      test 'should not create password reset token' do
        post('/users/password', params: params)
        assert_nil(@user.reload.reset_password_token)
      end
    end

    private

    def params
      {
        user: {
          email: @user.email
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
