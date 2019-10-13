# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  def notify(email_address, subject, message)
    @subject = subject
    @message = message
    mail(to: email_address, subject: subject) do |format|
      format.text { render plain: message }
    end
  end
end
