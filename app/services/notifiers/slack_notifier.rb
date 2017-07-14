module Notifiers
  class SlackNotifier
    attr_reader :message, :bot, :notifier, :bot_name

    def initialize(message, bot = nil)
      @message = message
      @bot = bot
      @notifier = Slack::Notifier.new(Setting.global.slack_url) do
        defaults username: @bot_name
      end
    end

    def notify!
      notifier.ping(message, icon_url: icon_url)
    end

    private

    def bot_name
      bot.present? ? bot : 'storm'
    end

    def icon_url
      'https://s3-us-west-2.amazonaws.com/dev-team-resources/storm-icon.png'
    end
  end
end
