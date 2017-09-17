require('net/http')

module Pings
  # Manager
  class Manager
    attr_reader(:website, :retry_attempt)
    alias_method(:retry_attempt?, :retry_attempt)

    def initialize(website, retry_attempt = false)
      @website = website
      @retry_attempt = retry_attempt
    end

    def ping
      retry_attempt? ? retry_ping : create_ping
    end

    private

    def create_ping
      ping = website.pings.create(ping_attributes(website.url))
      return enqueue_next_ping(ping) if successful?(ping)

      ping.update_column(:retry_count, 1)
      PingerJob.set(wait: 5.seconds).perform_later(website, true)
      ping
    end

    def retry_ping
      ping = website.pings.last
      return enqueue_next_ping(ping) if ping.retry_count == 3

      ping.update_columns(ping_attributes(website.url))
      return enqueue_next_ping(ping) if successful?(ping.reload)

      ping.update_column(:retry_count, ping.retry_count + 1)
      PingerJob.set(wait: 10.seconds).perform_later(website, true)
      ping
    end

    def ping_attributes(url)
      start_time = Time.current
      response = Pings::Worker.new(website, url).request
      response_time = (Time.current - start_time).in_milliseconds.to_i

      if response.is_a?(Net::HTTPRedirection)
        ping_attributes(response['location'])
      else
        status = %w(4 5).include?(response.code[0]) ? 0 : 1
        map_attributes(status, response_time)
      end
    end

    def map_attributes(status, response_time = nil)
      {
        status: status,
        response_time: response_time
      }
    end

    def enqueue_next_ping(ping)
      PingerJob.set(wait: 1.minute).perform_later(ping.website)
      ping
    end

    def successful?(ping)
      ping.status.eql?(1)
    end
  end
end
