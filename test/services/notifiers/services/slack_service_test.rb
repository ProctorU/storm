require('test_helper')

module Notifiers
  module Services
    # SlackServiceTest
    class SlackServiceTest < ActiveSupport::TestCase
      test 'bot_username' do
        instance = Notifiers::Services::SlackService.new('msg')
        assert_equal('storm', instance.send(:bot_username))

        instance = Notifiers::Services::SlackService.new('msg', 'bot')
        assert_equal('bot', instance.send(:bot_username))
      end

      test 'notify! without a Slack URL present' do
        create(:setting, slack_url: nil)
        instance = Notifiers::Services::SlackService.new('msg', 'bot')

        assert_not(instance.send(:enabled?))
      end
    end
  end
end
