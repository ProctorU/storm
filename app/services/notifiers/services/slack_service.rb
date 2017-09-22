module Notifiers
  module Services
    # SlackService
    #
    # Send messages directly to your Slack channel.
    class SlackService
      attr_reader(:message, :bot_username)

      def initialize(message, bot_username = 'storm')
        @message = message
        @bot_username = bot_username
      end

      def notify!
        raise(I18n.t('base.missing_slack_url')) unless slack_url.present?
        notifier.ping(message, icon_url: icon_url)
      end

      private

      def slack_url
        @slack_url ||= Setting.global.slack_url
      end

      def notifier
        Slack::Notifier.new(slack_url, username: bot_username)
      end

      def icon_url
        'https://s3-us-west-2.amazonaws.com/storm-app/icon.png'
      end
    end
  end
end
