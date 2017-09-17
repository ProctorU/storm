require 'test_helper'

# UserDecoratorTest
class UserDecoratorTest < Draper::TestCase
  setup do
    @user = create(:user)
  end

  describe 'member_status_text' do
    test 'is pending' do
      @user.stubs(:pending?).returns(true)
      assert_equal('pending', @user.decorate.member_status_text)
    end

    test 'is member' do
      @user.stubs(:pending?).returns(false)
      assert_equal('member', @user.decorate.member_status_text)
    end
  end
end
