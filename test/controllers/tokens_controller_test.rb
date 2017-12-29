require 'test_helper'

class TokensControllerTest < ActionDispatch::IntegrationTest
  feature 'as an authenticated user' do
    before(:each) do
      @token = create(:token)
      @user = @token.created_by

      sign_in(@user)
    end

    test 'should get index' do
      get(tokens_url)
      assert_response(:success)
    end

    test 'should get new' do
      get(new_token_url)
      assert_response(:success)
    end

    test 'should post create' do
      assert_difference('Token.count') do
        post(tokens_url, params: { token: { name: Faker::App.name } })
      end
    end

    test 'should not post create' do
      assert_no_difference('Token.count') do
        post(tokens_url, params: { token: { name: '' } })
      end
    end

    test 'should delete destroy' do
      assert_difference('Token.count', -1) do
        delete(token_url(@token.id))
        assert_response(:redirect)
      end
    end
  end

  feature 'as an unauthenticated user' do
    before(:each) { create(:user) }

    test 'should not get index' do
      get(tokens_url)
      assert_redirected_to(new_user_session_path)
    end

    test 'should not get new' do
      get(new_token_url)
      assert_redirected_to(new_user_session_path)
    end

    test 'should not post create' do
      post(tokens_url)
      assert_redirected_to(new_user_session_path)
    end

    test 'should not delete destroy' do
      delete(token_url(create(:token).id))
      assert_redirected_to(new_user_session_path)
    end
  end
end
