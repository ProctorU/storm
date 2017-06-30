require('test_helper')

# WelcomeControllerTest
class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get(root_path)
    assert_response :success
  end

  feature 'as an authenticated user' do
    before(:each) { sign_in(create(:user)) }

    test 'should not get index' do
    end
  end
end
