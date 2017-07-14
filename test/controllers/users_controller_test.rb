require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  feature 'as as authenticated user' do
    before(:each) do
      @user = create(:user)
      sign_in(@user)
    end

    test 'should get index' do
      get(users_url)
      assert_response(:success)
    end
  end

  feature 'as as an unauthenticated user' do
    test 'should get redirected to sign-in' do
      get(users_url)
      assert_redirected_to(new_user_session_path)
    end
  end
end
