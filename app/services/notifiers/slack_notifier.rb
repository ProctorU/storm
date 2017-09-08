module Notifiers
  # SlackNotifier
  #
  # Send messages directly to your Slack channel.
  class SlackNotifier
    attr_reader(:message, :bot)

    def initialize(message, bot = nil)
      @message = message
      @bot = bot
    end

    def notify!
      notifier.ping(message, icon_url: icon_url)
    end

    private

    def notifier
      Slack::Notifier.new(Setting.global.slack_url, username: bot_username)
    end

    def bot_username
      bot.present? ? bot : 'storm'
    end

    def icon_url
      'https://s3-us-west-2.amazonaws.com/storm-app/icon.png'
    end
  end
end
