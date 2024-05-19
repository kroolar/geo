module Geolocations
  class Create
    attr_reader :address, :geolocation

    def initialize(address)
      @address = address
    end

    def call
      fetch_geolocation
      save!
    end

    private

    def fetch_geolocation
      @geolocation = Geolocations::FindInIpstack.new(address).call
    end

    def save!
      geolocation.valid? ? geolocation.save! : raise_exception
    end

    def raise_exception
      error_message = geolocation.errors.full_messages.join(', ')

      raise StandardError, error_message
    end
  end
end
