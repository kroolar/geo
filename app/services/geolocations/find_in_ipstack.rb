module Geolocations
  class FindInIpstack
    attr_reader :address, :geolocation, :response, :attributes

    def initialize(address)
      @address = address
      @geolocation = Geolocation.new
    end

    def call
      fetch_geolocation
      build_attributes
      assign_url_address
      assign_attributes
      geolocation
    end

    private

    def fetch_geolocation
      @response = Ipstack::Client.new.geolocation(address)
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
      return if address_ip?

      attributes[:url] = address
    end

    def assign_attributes
      geolocation.assign_attributes(attributes)
    end

    def address_ip?
      address.match?(Resolv::AddressRegex)
    end
  end
end
