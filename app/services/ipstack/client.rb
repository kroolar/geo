module Ipstack
  class Client
    attr_reader :request

    def initialize
      @request = Request.new
    end

    def geolocation(address)
      request.get address
    end
  end
end
