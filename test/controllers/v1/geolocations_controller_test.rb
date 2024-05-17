require 'test_helper'

module V1
  class GeolocationsControllerTest < ActionDispatch::IntegrationTest
    INVALID_ADDRESSES = [
      'sofomo',
      '104',
      '104.26',
      '104.26.6',
      '104.26.6.84.0'
    ].freeze

    VALID_ADDRESSES = [
      'google.com',
      'http://google.com',
      'https://google.com',
      '104.26.6.84'
    ].freeze

    ###############
    ### DESTROY ###
    ###############
    test 'should raise 500 when address is invalid' do
      INVALID_ADDRESSES.each do |address|
        delete "/v1/geolocations/#{address}"

        assert_response :internal_server_error
        assert_response_message("Geolocation #{address} not found!")
      end
    end

    test 'should raise 500 when corresponding record not found in database' do
      delete '/v1/geolocations/sofomo.com'

      assert_response :internal_server_error
      assert_response_message('Geolocation sofomo.com not found!')
    end

    test 'should return 200 with message about action' do
      VALID_ADDRESSES.each do |address|
        create_geolocation

        assert_difference('Geolocation.count', -1) do
          delete "/v1/geolocations/#{address}"

          assert_response :success
          assert_response_message('Geolocation destroyed!')
        end
      end
    end

    private

    def create_geolocation
      Geolocation.new(ip: '104.26.6.84', url: 'google.com')
                 .save(validate: false)
    end

    def assert_response_message(message)
      assert_equal(JSON.parse(response.body)['message'], message)
    end
  end
end
