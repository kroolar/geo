require 'test_helper'

class GeolocationTest < ActiveSupport::TestCase
  should validate_inclusion_of(:continent_code).in_array(Geolocation::CONTINENT_CODES)
  should validate_inclusion_of(:country_code).in_array(ISO3166::Country.all.map(&:alpha2))

  test 'should validate fomrat of ip' do
    should_assert_attribute :ip, '10.10.10.10'
    should_assert_attribute :ip, '192.168.0.1'
    should_refute_attribute :ip, 'WRONG.IP.ADDRESS'
    should_refute_attribute :ip, ''
  end

  test 'should validate inclusion of latitude' do
    should_assert_attribute :latitude, '-90'
    should_assert_attribute :latitude, '-78.123'
    should_assert_attribute :latitude, '0'
    should_assert_attribute :latitude, '78.321'
    should_assert_attribute :latitude, '90.0'
    should_refute_attribute :latitude, '90.1'
    should_refute_attribute :latitude, '-90.000000001'
  end

  test 'should validate inclusion of longitude' do
    should_assert_attribute :longitude, '-180'
    should_assert_attribute :longitude, '0'
    should_assert_attribute :longitude, '100.0'
    should_refute_attribute :longitude, '999.1'
    should_refute_attribute :longitude, '-180.000000001'
  end

  test 'should validate format of url' do
    should_assert_attribute :url, 'https://www.sofomo.com/'
    should_assert_attribute :url, 'http://www.sofomo.com/'
    should_refute_attribute :url, 'sofomo'
  end

  private

  def should_assert_attribute(attribute, value)
    assert Geolocation.create(attribute => value).errors[attribute].empty?
  end

  def should_refute_attribute(attribute, value)
    refute Geolocation.create(attribute => value).errors[attribute].empty?
  end
end
