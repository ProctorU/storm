# PingerJob
class PingerJob < ApplicationJob
  queue_as :default

  def perform(website, retry_attempt)
    Pinger.new(website, retry_attempt).ping
  end
end
