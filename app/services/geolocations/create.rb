module Geolocations
  class Create
    attr_reader :geolocation, :params

    def initialize(params)
      @geolocation = Geolocation.new
      @params = params
    end

    def call
      assign_attributes
      save!
    end

    private

    def assign_attributes
      geolocation.assign_attributes(params)
    end

    def save!
      geolocation.valid? ? geolocation.save! : raise_exception
    end

    def raise_exception
      error_message = geolocation.errors.full_messages.join(', ')

      raise StandardError.new(error_message)
    end
  end
end
