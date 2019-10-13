require "test_helper"

class NotificationMailerTest < ActionMailer::TestCase
  test "notify" do
    ENV['STORM_MAIL_FROM'] = 'sender@test.com'
    email = NotificationMailer.notify('recipient@test.com', 'subject', 'message').deliver_now

    assert_not ActionMailer::Base.deliveries.empty?

    assert_equal ['sender@test.com'], email.from
    assert_equal ['recipient@test.com'], email.to
    assert_equal 'subject', email.subject
    assert_equal 'message', email.body.to_s
  end
end
