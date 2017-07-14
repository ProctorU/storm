require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  feature 'as as authenticated user' do
    before(:each) do
      @user = create(:user)
      sign_in(@user)
    end

    test 'should get edit settings' do
      get(edit_settings_url)
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
