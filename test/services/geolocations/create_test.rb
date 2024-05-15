require 'test_helper'

module Geolocations
  class CreateTest < ActiveSupport::TestCase
    test 'create new geolocation when param are correct' do
      # Given: Create service with correct params
      service = Create.new(params)

      # When: Service is called
      # Then: It should create new Geolocation
      assert_difference('Geolocation.count') { service.call }
    end

    test 'raise an error when params are incorrect' do
      # Given: Create service with incorrect params
      params[:ip] = nil
      service = Create.new(params)

      # When: Service is called
      # Then: It should raise an error
      error = assert_raises(StandardError) { service.call }

      # Then: Error should say that Ip is invalid
      assert_equal('Ip is invalid', error.message)
    end

    private

    def params
      @params ||= {
        url: 'https://www.sofomo.com',
        ip: '172.67.70.227',
        continent_code: 'NA',
        country_code: 'US',
        latitude: 37.76784896850586,
        longitude: -122.39286041259766
      }
    end
  end
end
