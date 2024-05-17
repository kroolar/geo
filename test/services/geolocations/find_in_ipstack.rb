require 'test_helper'

module Geolocations
  class FindInIpstackTest < ActiveSupport::TestCase
    test 'raise an error on address validation' do
      VCR.use_cassette('find-in-ipstack') do
        # Given: Service with valid URL
        service = Geolocations::FindInIpstack.new('https://sofomo.com')

        # When: Service is called
        geolocation = service.call

        # Then; it should return geolocation
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
