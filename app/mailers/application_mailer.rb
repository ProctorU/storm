# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV['STORM_MAIL_FROM']
  layout 'mailer'
end
