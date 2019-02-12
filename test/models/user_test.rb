# frozen_string_literal: true

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

  test 'reset_password_token!' do
    @user.save
    assert_nil(@user.reset_password_sent_at)
    assert_not_nil(@user.reset_password_token!)
    assert_not_nil(@user.reload.reset_password_sent_at)
  end
end
