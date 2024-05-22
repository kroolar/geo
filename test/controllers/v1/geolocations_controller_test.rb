require 'test_helper'

module V1
  class GeolocationsControllerTest < ActionDispatch::IntegrationTest
    ##############
    ### BEFORE ###
    ##############
    test 'should raise 500 when address is invalid' do
      get '/v1/geolocations/sofomo'

      assert_response :internal_server_error
      assert_response_message('Address sofomo is not valid!')
    end

    ##############
    ### CREATE ###
    ##############
    test 'should return geolocation when URL is valid' do
      VCR.use_cassette('find-in-ipstack-success') do
        post '/v1/geolocations/sofomo.com'

        assert_response :success
        assert_response_message('Geolocation successfully created!')
      end
    end

    ############
    ### SHOW ###
    ############
    test 'should return geolocation from database' do
      get '/v1/geolocations/facebook.com'

      assert_equal(1, response_body['id'])
      assert_equal('31.13.66.35', response_body['ip'])
      assert_equal('facebook.com', response_body['url'])
      assert_equal('NA', response_body['continent_code'])
      assert_equal('US', response_body['country_code'])
    end

    test 'should return geolocation from ipsatack' do
      VCR.use_cassette('geolocations-show-amazon') do
        get '/v1/geolocations/amazon.com'

        assert_response :success
        assert_nil(response_body['id'])
        assert_equal('205.251.242.103', response_body['ip'])
        assert_equal('amazon.com', response_body['url'])
        assert_equal('NA', response_body['continent_code'])
        assert_equal('US', response_body['country_code'])
        assert_equal(39.043701171875, response_body['latitude'])
        assert_equal(-77.47419738769531, response_body['longitude'])
      end
    end

    test 'should return 500 when address is invalid' do
      get '/v1/geolocations/sofomo'

      assert_response :internal_server_error
      assert_response_message('Address sofomo is not valid!')
    end

    ###############
    ### DESTROY ###
    ###############

    test 'should raise 500 when corresponding record not found in database' do
      delete '/v1/geolocations/amazon.com'

      assert_response :internal_server_error
      assert_response_message('Geolocation amazon.com not found!')
    end

    test 'should return 200 with message about destroying geolocation' do
      assert_difference('Geolocation.count', -1) do
        delete '/v1/geolocations/facebook.com'

        assert_response :success
        assert_response_message('Geolocation destroyed!')
      end
    end

    private

    def assert_response_message(message)
      assert_equal(response_body['message'], message)
    end

    def response_body
      JSON.parse(response.body)
    end
  end
end
