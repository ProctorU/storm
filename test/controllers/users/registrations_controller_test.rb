require('test_helper')

module Users
  # RegistrationsControllerTest
  class RegistrationsControllerTest < ActionDispatch::IntegrationTest
    feature 'before the initial account has been setup' do
      test 'should get new' do
        get(new_user_registration_path)
        assert_nil(flash[:warning])
        assert_response(:success)
      end
    end

    feature 'after the initial account has been setup' do
      before(:each) { create(:user) }

      test 'should not get new' do
        get(new_user_registration_path)
        assert_not_nil(flash[:warning])
        assert_response(:redirect)
      end
    end
  end
end
