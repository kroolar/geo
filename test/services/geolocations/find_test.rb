require 'test_helper'

module Geolocations
  class FindTest < ActiveSupport::TestCase
    test 'should find a geolocation in database by URL address' do
      # Given: Create service with valid URL address
      service = Find.new('sofomo.com')

      # When: Service is called
      geolocation = service.call

      # Then: Service should return geolocation from database
      assert geolocation.persisted?
    end

    test 'should find a geolocation in database by IP address' do
      # Given: Create service with valid IP address
      service = Find.new('104.26.7.84')

      # When: Service is called
      geolocation = service.call

      # Then: Service shoud return geolocation from database
      assert geolocation.persisted?
    end

    test 'should raise an error if geolocation not found in the database' do
      # Given: Create service with valid URL address
      service = Find.new('google.com')

      # When: Service is called
      # Then: It should raise an error
      error = assert_raises(StandardError) { service.call }

      # Then: Error should say that Geoocation not found
      assert_equal('Geolocation google.com not found!', error.message)
    end

    test 'should find a geolocation in ipstack when there is not in database' do
      VCR.use_cassette('find-test-success') do
        # Given: Create service with valid URL address
        service = Find.new('amazon.com', ipstack_lookup: true)

        # When: Service is called
        geolocation = service.call

        # Then: Service shoud return geolocation from ipstack
        assert geolocation.new_record?
        assert_equal '205.251.242.103', geolocation.ip
      end
    end

    test 'should raise an error if not found a geolocation in ipstack' do
      VCR.use_cassette('find-test-fail') do
        # Given: Create service with valid URL address
        service = Find.new('amazon.amazon', ipstack_lookup: true)

        # When: Service is called
        # Then: It should raise an error
        error = assert_raises(StandardError) { service.call }

        # Then: Error should say that Geoocation not found
        assert_equal('Undefined Error: (Code 106) The IP Address supplied is invalid.', error.message)
      end
    end
  end
end
