module Geolocations
  class Find
    attr_reader :address, :ipstack_lookup

    def initialize(address, ipstack_lookup: false)
      @address = address
      @ipstack_lookup = ipstack_lookup
    end

    def call
      validate_address
      find_in_database
    rescue ActiveRecord::RecordNotFound
      raise StandardError, 'Geoocation not found' unless ipstack_lookup

      find_in_ipstack
    end

    private

    def validate_address
      raise StandardError, "Address can't be blank" if address.blank?
      raise StandardError, 'Invalid URL or IP' if invalid_url? && invalid_ip?
    end

    def invalid_url?
      (address !~ URI::DEFAULT_PARSER.make_regexp(%w[http https]))
    end

    def invalid_ip?
      (address !~ Resolv::IPv4::Regex)
    end

    def find_in_database
      geolocation = Geolocation.find_by(ip: address) ||
                    Geolocation.find_by(url: address)

      return geolocation if geolocation.present?

      raise ActiveRecord::RecordNotFound
    end

    def find_in_ipstack
      # TODO: API call to IP Stack
    end
  end
end
