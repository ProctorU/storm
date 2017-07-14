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

    test 'should post update' do
      # Create a setting so that one exists in the DB to update
      Setting.create(aws_key: 'testing')

      assert_no_difference('Setting.count') do
        patch(settings_url, params: { setting: { aws_key: 'test' } })
        assert_redirected_to(root_url)
      end
    end
  end

  feature 'as as an unauthenticated user' do
    test 'should get redirected to sign-in' do
      get(users_url)
      assert_redirected_to(new_user_session_path)
    end
  end
end
