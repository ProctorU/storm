# frozen_string_literal: true

require('test_helper')

module Notifiers
  module Services
    # MailerServiceTest
    class MailerServiceTest < ActiveSupport::TestCase
      test 'notify! without an email address present' do
        create(:setting, email_address: nil)
        instance = Notifiers::Services::MailerService.new('msg')

        assert_not(instance.send(:enabled?))
      end
    end
  end
end
