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
end
