require('test_helper')

module Notifiers
  # PingNotifierTest
  class PingNotifierTest < ActiveSupport::TestCase
    setup do
      @website = create(:website)

      create(:setting)
    end

    describe 'can_notify?' do
      it 'returns true if first ping' do
        notifier = Notifiers::PingNotifier.new(
          create(:ping, :success, website: @website)
        )

        assert(notifier.send(:can_notify?))
      end

      it 'returns true if ping status is different than previous ping' do
        create(:ping, :success, website: @website)
        notifier = Notifiers::PingNotifier.new(
          create(:ping, :fail, website: @website)
        )

        assert(notifier.send(:can_notify?))
      end

      it 'returns false if ping status is same as previous ping' do
        create(:ping, :success, website: @website)
        notifier = Notifiers::PingNotifier.new(
          create(:ping, :success, website: @website)
        )

        assert_not(notifier.send(:can_notify?))
      end
    end

    describe 'first_ping' do
      it 'returns true' do
        notifier = Notifiers::PingNotifier.new(
          create(:ping, :success, website: @website)
        )

        assert(notifier.send(:first_ping))
      end

      it 'returns false' do
        create(:ping, :success, website: @website)
        notifier = Notifiers::PingNotifier.new(
          create(:ping, :success, website: @website)
        )

        assert_not(notifier.send(:first_ping))
      end
    end

    describe 'message' do
      it 'returns the welcome message' do
        notifier = Notifiers::PingNotifier.new(
          create(:ping, :success, website: @website)
        )

        assert_equal(
          notifier.send(:welcome_message),
          notifier.send(:message)
        )
      end

      it 'returns the up_after_reboot message' do
        @website.update(rebooting: true)
        create(:ping, :fail, website: @website)
        notifier = Notifiers::PingNotifier.new(
          create(:ping, :success, website: @website)
        )

        assert_equal(
          notifier.send(:up_after_reboot_message),
          notifier.send(:message)
        )
      end

      it 'returns the down_after_reboot message' do
        @website.update(rebooting: true)
        create(:ping, :success, website: @website)
        notifier = Notifiers::PingNotifier.new(
          create(:ping, :fail, website: @website)
        )

        assert_equal(
          notifier.send(:down_after_reboot_message),
          notifier.send(:message)
        )
      end

      it 'returns a sample of up_messages' do
        create(:ping, :fail, website: @website)
        notifier = Notifiers::PingNotifier.new(
          create(:ping, :success, website: @website)
        )

        assert(
          notifier.send(:up_messages).include?(notifier.send(:message))
        )
      end

      it 'returns a sample of down_messages' do
        create(:ping, :success, website: @website)
        notifier = Notifiers::PingNotifier.new(
          create(:ping, :fail, website: @website)
        )

        assert(
          notifier.send(:down_messages).include?(notifier.send(:message))
        )
      end

      it 'sets rebooting to false' do
        create(:ping, :fail, website: @website)
        @website.update(rebooting: true)

        notifier = Notifiers::PingNotifier.new(
          create(:ping, :success, website: @website)
        )
        notifier.send(:message)

        assert_not(@website.reload.rebooting?)
      end
    end
  end
end
