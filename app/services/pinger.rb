require 'net/http'

class Pinger
  attr_reader :website

  def initialize(website)
    @website = website
  end

  def ping
    puts "************"
    create_ping
  end

  private

  def create_ping
    #website.pings.create(status: execute)
    website.pings.create(status: website_running?)
  end

  def website_running?
    # try to ping, on failure retry n times at n interval
    #return 1
    request_success?(website.url) ? 1 : 0
  rescue
    retries = 3
    delay = 5
    retries.times do
      if request_success?(website.url)
        return 1
      else
        puts "************** sleeping"
        sleep delay
      end
    end
  end
  end

  def request_success?(url)
    puts "******** making request"
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

      response = http.request(request)

      if response.kind_of?(Net::HTTPRedirection)
        request_success?(response['location'])
      else
        return ! %W(4 5).include?(response.code[0])
      end
    end
  end

  def retry_ping
  end

  def enqueue_next_ping
  end
end
