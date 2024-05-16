require 'test_helper'

module Geolocations
  class FindTest < ActiveSupport::TestCase
    test 'raise an error when address if empty' do
      # Given: Create service with empty address
      service = Find.new('')

      # When: Service is called
      # Then: It should raise an error
      error = assert_raises(StandardError) { service.call }

      # Then: Error should say that address can't be blank
      assert_equal("Address can't be blank", error.message)
    end

    test 'raise an error when IP address is invalid' do
      # Given: Create service with invalid IP address
      service = Find.new('1.1.1.1.1')

      # When: Service is called
      # Then: It should raise an error
      error = assert_raises(StandardError) { service.call }

      # Then: Error should say that URL or IP are invalid
      assert_equal('Invalid URL or IP', error.message)
    end

    test 'raise an error when URL address is invalid' do
      # Given: Create service with invalid URL address
      service = Find.new('sofomo.com')

      # When: Service is called
      # Then: It should raise an error
      error = assert_raises(StandardError) { service.call }

      # Then: Error should say that URL or IP are invalid
      assert_equal('Invalid URL or IP', error.message)
    end

    test 'should find a geolocation in database by IP' do
      # Given: Create service with valid IP address
      service = Find.new('10.10.10.10')

      # When: Service is called
      geolocation = service.call

      # Then: Service shoud return geolocation from database
      assert geolocation.persisted?
    end

    test 'should find a geolocation in database by URL' do
      # Given: Create service with valid URL address
      service = Find.new('https://sofomo.com')

      # When: Service is called
      geolocation = service.call

      # Then: Service shoud return geolocation from database
      assert geolocation.persisted?
    end

    test 'should raise an error if geolocation not found in the database' do
      # Given: Create service with valid URL address
      service = Find.new('https://google.com')

      # When: Service is called
      # Then: It should raise an error
      error = assert_raises(StandardError) { service.call }

      # Then: Error should say that Geoocation not found
      assert_equal('Geolocation not found', error.message)
    end
  end
end
