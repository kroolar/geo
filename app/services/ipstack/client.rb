module Ipstack
  class Client
    attr_reader :request

    def initialize
      @request = Request.new
    end

    def geolocation(address)
      network_address = NetworkAddress.new(address)
      endpoint = network_address.ip? ? address : network_address.domain_name

      request.get endpoint
    end
  end
end
