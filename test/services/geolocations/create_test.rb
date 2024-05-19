require 'test_helper'

module Geolocations
  class CreateTest < ActiveSupport::TestCase
    test 'raise an error when service failed' do
      VCR.use_cassette('find-in-ipstack-fail') do
        # Given: Service with valid URL address
        service = Geolocations::Create.new('sofomo.sofomo')

        # When: Service is called
        # Then: It should raise an error
        error = assert_raises(StandardError) { service.call }

        assert_equal(error.message, 'Undefined Error: (Code 106) The IP Address supplied is invalid.')
      end
    end

    test 'create new geolocation' do
      VCR.use_cassette('find-in-ipstack-success') do
        # Given: Service with valid URL address
        service = Geolocations::Create.new('sofomo.com')

        # When: Service is called
        # Then: It should create new Geolocation
        assert_difference('Geolocation.count') { service.call }

        geolocation = Geolocation.find_by(url: 'sofomo.com')
        assert(geolocation.persisted?)
        assert_equal('sofomo.com', geolocation.url)
        assert_equal('104.26.7.84', geolocation.ip)
        assert_equal('NA', geolocation.continent_code)
        assert_equal('US', geolocation.country_code)
        assert_equal(39.043701171875, geolocation.latitude)
        assert_equal(-77.47419738769531, geolocation.longitude)
      end
    end
  end
end
