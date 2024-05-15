module Ipstack
  class Client
    def geolocation(ip_or_url)
      request.get ip_or_url
    end

    private

    def request
      @request ||= Request.new
    end
  end
end
