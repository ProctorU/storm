require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    sign_in @user
  end

  test "should get edit" do
    get edit_settings_path
    assert_response :success
  end
end
