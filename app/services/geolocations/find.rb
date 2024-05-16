module Geolocations
  class Find
    attr_reader :network_address, :ipstack_lookup

    def initialize(ip_or_url, ipstack_lookup: false)
      @network_address = NetworkAddress.new(ip_or_url)
      @ipstack_lookup = ipstack_lookup
    end

    def call
      validate_address
      find_in_database
    rescue ActiveRecord::RecordNotFound
      raise StandardError, 'Geolocation not found' unless ipstack_lookup

      find_in_ipstack
    end

    private

    def validate_address
      raise StandardError, "Address can't be blank" if network_address.address.blank?
      raise StandardError, 'Invalid URL or IP' if network_address.invalid?
    end

    def find_in_database
      geolocation = Geolocation.find_by(ip: network_address.address) ||
                    Geolocation.find_by(url: network_address.address)

      return geolocation if geolocation.present?

      raise ActiveRecord::RecordNotFound
    end

    def find_in_ipstack
      response = Ipstack::Client.new.geolocation(network_address.address)
      # TODO: API call to IP Stack
    end
  end
end
