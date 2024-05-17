module Geolocations
  class FindInIpstack
    attr_reader :network_address, :geolocation, :response, :attributes

    def initialize(address)
      @network_address = NetworkAddress.new(address)
      @geolocation = Geolocation.new
    end

    def call
      fetch_geolocation
      build_attributes
      assign_url_address
      assign_attributes
      geolocation
    end

    def fetch_geolocation
      @response = Ipstack::Client.new.geolocation(network_address.ipstack_query)
    end

    def build_attributes
      @attributes = response.with_indifferent_access.slice(
        :ip,
        :continent_code,
        :country_code,
        :latitude,
        :longitude
      )
    end

    def assign_url_address
      return if network_address.ip?

      @attributes[:url] = network_address.address
    end

    def assign_attributes
      geolocation.assign_attributes(attributes)
    end
  end
end
