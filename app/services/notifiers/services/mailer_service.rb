# frozen_string_literal: true

module Notifiers
  module Services
    # MailerService
    #
    # Send messages via Rails mailers.
    class MailerService
      attr_reader(:message)

      def initialize(message)
        @message = message
      end

      def notify!
        return unless enabled?
        NotificationMailer.notify(email_address, subject, message).deliver_later
      end

      private

      def enabled?
        email_address.present?
      end

      def email_address
        @email_address ||= Setting.global.email_address
      end

      def subject
        @subject ||= I18n.t('notifiers.mailer_service.subject')
      end
    end
  end
end
