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
end
