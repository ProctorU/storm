require('test_helper')

# WebsitesControllerTest
class WebsitesControllerTest < ActionDispatch::IntegrationTest
  feature 'as as authenticated user' do
    before(:each) do
      @user = create(:user)
      sign_in(@user)
    end

    test 'should get index' do
      get(root_path)
      assert_response(:success)
    end

    test 'should get new' do
      get(new_website_path)
      assert_response(:success)
    end

    test 'should post create' do
      assert_difference('Website.count') do
        post(websites_path, params: params)
        assert_not_nil(flash[:success])
        assert_redirected_to(root_path)
      end
    end

    test 'should not post create' do
      assert_no_difference('Website.count') do
        post(websites_path, params: { website: { name: 'test' } })
        assert_nil(flash[:success])
        assert_response(:success)
      end
    end
  end

  feature 'as an unauthenticated user' do
    test 'should not get index' do
      assert_raise do
        get('/websites')
      end
    end

    test 'should not get new' do
      get(new_website_path)
      assert_redirected_to(:new_user_registration)
    end
  end

  private

  def params
    {
      website: {
        name: 'test website',
        url: 'http://test.website.com',
        ssl: false
      }
    }
  end
end
