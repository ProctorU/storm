module Pings
  # Worker
  class Worker
    attr_reader(:website, :url)

    def initialize(website, url = nil)
      @website = website
      @url = url
    end

    def request
      uri = URI(url.nil? ? website.url : url)

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

        http.request(request)
      end
    rescue
      OpenStruct.new(code: '500') # throw 500 error
    end
  end
end
