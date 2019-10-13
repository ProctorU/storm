# frozen_string_literal: true

module Notifiers
  # PingNotifier
  class PingNotifier
    attr_reader(:ping, :website)

    def initialize(ping)
      @ping = ping
      @website = ping.website
    end

    def notify!
      return unless can_notify?
      Notifiers::Services::SlackService.new(message).notify!
      Notifiers::Services::MailerService.new(message).notify!
    end

    private

    # Private: Check if we should send a notification.
    #
    # Reasons to send notifications:
    # 1. It's the first ping. (welcome ping)
    # 2. It has a different status than the previous ping.
    #
    # Reasons to not send notifications:
    # - We don't want to send a notification every minute if the site is down.
    # - We don't want to send a notification for every successful ping.
    #
    # We essentially only want to notify once if the site is down, and once
    #   when the site comes back online.
    def can_notify?
      return true if first_ping
      ping.status != previous_ping.status
    end

    def first_ping
      @first_ping ||= previous_ping.nil?
    end

    def previous_ping
      website.pings.second
    end

    def message
      return welcome_message if first_ping

      if website.rebooting? && up?
        website.update_attributes(rebooting: false)
        up_after_reboot_message
      elsif website.rebooting? && down?
        down_after_reboot_message
      else
        up? ? up_messages.sample : down_messages.sample
      end
    end

    def welcome_message
      I18n.t(
        'pings.notifiers.welcome_message',
        name: website.name,
        status: status_text
      )
    end

    def up_after_reboot_message
      I18n.t('pings.notifiers.up_after_reboot', name: website.name)
    end

    def down_after_reboot_message
      I18n.t('pings.notifiers.down_after_reboot', name: website.name)
    end

    def status_text
      up? ? I18n.t('pings.notifiers.up') : I18n.t('pings.notifiers.down')
    end

    def up?
      ping.status.eql?(1)
    end

    def down?
      ping.status.eql?(0)
    end

    def up_messages
      [
        I18n.t('websites.up.first', name: website.name)
      ]
    end

    def down_messages
      [
        I18n.t('websites.down.first', name: website.name, url: website.url)
      ]
    end
  end
end
