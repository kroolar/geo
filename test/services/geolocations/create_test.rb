require 'test_helper'

module Geolocations
  class CreateTest < ActiveSupport::TestCase
    test 'raise an error on address validation' do
      # Given: Service with invalid IP address
      service = Geolocations::Create.new('10.10.10.10.10')

      # When: Service is called
      # Then: It should raise an error
      error = assert_raises(StandardError) { service.call }

      # Then: Error should say that address is invalid
      assert_equal('Network address: 10.10.10.10.10 is invalid!', error.message)
    end

    test 'raise an error when service failed' do
      VCR.use_cassette('geolocations/create-fail') do
        # Given: Service with valid URL address
        service = Geolocations::Create.new('https://sofomo.com')

        # When: Service is called
        # Then: It should raise an error
        assert_raises(StandardError) { service.call }
      end
    end

    test 'create new geolocation' do
      VCR.use_cassette('geolocations/create-success') do
        # Given: Service with valid URL address
        service = Geolocations::Create.new('https://sofomo.com')

        # When: Service is called
        # Then: It should create new Geolocation
        assert_difference('Geolocation.count') { service.call }

        geolocation = Geolocation.find_by(url: 'https://sofomo.com')
        assert(geolocation.persisted?)
        assert_equal('https://sofomo.com', geolocation.url)
        assert_equal('104.26.6.84', geolocation.ip)
        assert_equal('NA', geolocation.continent_code)
        assert_equal('US', geolocation.country_code)
        assert_equal(37.330528259277344, geolocation.latitude)
        assert_equal(-121.83822631835938, geolocation.longitude)
      end
    end
  end
end
