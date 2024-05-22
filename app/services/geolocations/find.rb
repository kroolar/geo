module Geolocations
  class Find
    attr_reader :address, :ipstack_lookup

    def initialize(address, ipstack_lookup: false)
      @address = address
      @ipstack_lookup = ipstack_lookup
    end

    def call
      find_in_database
    rescue ActiveRecord::RecordNotFound
      find_in_ipstack
    end

    def find_in_database
      geolocation = Geolocation.find_by(ip: address) ||
                    Geolocation.find_by(url: address)

      return geolocation if geolocation.present?

      raise ActiveRecord::RecordNotFound
    end

    def find_in_ipstack
      raise StandardError, "Geolocation #{address} not found!" unless ipstack_lookup

      Geolocations::FindInIpstack.new(address).call
    end
  end
end
