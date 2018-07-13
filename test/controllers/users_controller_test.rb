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

    test 'should delete destroy' do
      other_user = create(:user)

      assert_difference('User.count', -1) do
        delete(user_url(other_user))
      end

      assert_not_empty(flash[:success])
      assert_response(:redirect)
    end
  end

  feature 'as as an unauthenticated user' do
    test 'should get redirected to sign-in' do
      get(users_url)
      assert_redirected_to(new_user_session_path)
    end

    test 'not destroy and should get redirected to sign-in' do
      delete(user_url(create(:user)))
      assert_redirected_to(new_user_session_path)
    end
  end
end
