require 'test_helper'

module Geolocations
  class FindInIpstackTest < ActiveSupport::TestCase
    test 'find geolocation in ipstack' do
      VCR.use_cassette('find-in-ipstack-success') do
        # Given: Service with valid URL
        service = Geolocations::FindInIpstack.new('sofomo.com')

        # When: Service is called
        geolocation = service.call

        # Then: It should return geolocation
        assert_equal('sofomo.com', geolocation.url)
        assert_equal('104.26.7.84', geolocation.ip)
        assert_equal('NA', geolocation.continent_code)
        assert_equal('US', geolocation.country_code)
        assert_equal(39.043701171875, geolocation.latitude)
        assert_equal(-77.47419738769531, geolocation.longitude)
      end
    end

    test 'raise an error when address is invalid' do
      VCR.use_cassette('find-in-ipstack-fail') do
        # Given: Service with invalid URL
        service = Geolocations::FindInIpstack.new('sofomo.sofomo')

        # When: Service is called
        # Then; It should raise an error
        error = assert_raises { service.call }

        # Then: Error should say that address is invalid
        assert_equal('Undefined Error: (Code 106) The IP Address supplied is invalid.', error.message)
      end
    end
  end
end
