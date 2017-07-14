require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    sign_in @user
  end

  test "should get index" do
    get users_url
    assert_response :success
  end
end
