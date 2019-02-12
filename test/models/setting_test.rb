# frozen_string_literal: true

require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  test 'aws_key is encrypted' do
    setting = Setting.new(aws_key: 'foo')
    assert(setting.save)
    assert_not_nil(setting.encrypted_aws_key)
  end

  test 'aws_secret is encrypted' do
    setting = Setting.new(aws_secret: 'foo')
    assert(setting.save)
    assert_not_nil(setting.encrypted_aws_secret)
  end

  test 'global' do
    assert_nil(Setting.global)
    setting = create(:setting)
    assert_equal(setting, Setting.global)
  end
end
