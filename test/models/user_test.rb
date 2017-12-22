require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = build(:user)
  end

  test 'valid' do
    assert(@user.valid?)
  end

  test 'invalid without required attributes' do
    %w(email password).each do |attrs|
      @user.send("#{attrs}=", '')
      assert_not(@user.valid?)
    end
  end

  test 'successfully removed tokens after deletion' do
    @user.save
    create(:token, created_by: @user)
    assert_equal(1, @user.tokens.size)

    assert_difference('Token.count', -1) do
      @user.destroy
    end
  end
end
