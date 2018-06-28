# PingerJob
class PingerJob < ApplicationJob
  queue_as(:default)

  def perform(website, retry_attempt = false)
    return enqueue_next_job(website) unless website.active?
    Pings::Manager.new(website, retry_attempt).ping
  end

  private

  def enqueue_next_job(website)
    PingerJob.set(wait: 1.minute).perform_later(website)
  end
end
