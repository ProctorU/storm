require('test_helper')

module Notifiers
  # SlackNotifierTest
  class SlackNotifierTest < ActiveSupport::TestCase
    test 'bot_username' do
      instance = Notifiers::SlackNotifier.new('msg')
      assert_equal('storm', instance.send(:bot_username))

      instance = Notifiers::SlackNotifier.new('msg', 'bot')
      assert_equal('bot', instance.send(:bot_username))
    end

    test 'notify! without a Slack URL present' do
      create(:setting, slack_url: nil)

      assert_raise do
        Notifiers::SlackNotifier.new('msg').notify!
      end
    end
  end
end
