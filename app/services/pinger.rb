require 'net/http'

class Pinger
  attr_reader :website
  attr_reader :retry_attempt
  alias_method :retry_attempt?, :retry_attempt

  def initialize(website, retry_attempt = false)
    @website = website
    @retry_attempt = retry_attempt
  end

  def ping
    retry_attempt? ? retry_ping : create_ping
  end

  private

  def create_ping
    ping = website.pings.create(get_response(website.url))
    return if ping.status == 1

    ping.update_columns(retry_count: 1)
    PingerJob.set(wait: 5.seconds).perform_later(website, true)
  end

  def retry_ping
    ping = website.pings.last
    return if ping.retry_count == 2

    ping.update_columns(get_response(website.url))
    return if ping.status == 1

    ping.update_columns(retry_count: 2)
    PingerJob.set(wait: 10.seconds).perform_later(website, true)
  end

  def get_response(url)
    uri = URI(url)

    Net::HTTP.start(
      uri.host,
      uri.port,
      use_ssl: website.ssl,
      verify_mode: OpenSSL::SSL::VERIFY_NONE
    ) do |http|
      request = Net::HTTP::Get.new(uri.request_uri)

      if website.basic_auth?
        request.basic_auth(
          website.basic_auth_username,
          website.basic_auth_password
        )
      end

      start_time = Time.current
      response = http.request(request)
      response_time = (Time.current - start_time).in_milliseconds.to_i

      if response.kind_of?(Net::HTTPRedirection)
        get_response(response['location'])
      else
        success = ! %W(4 5).include?(response.code[0])
        return {response_time: response_time, status: success ? 1 : 0}
      end
    end
  rescue
    {status: 0}
  end
end
