require 'test_helper'

class NetworkAddressTest < ActiveSupport::TestCase
  VALID_ADDRESSES = [
    'sofomo.com',
    'www.sofomo.com',
    'http://sofomo.com',
    'https://sofomo.com',
    'http://www.sofomo.com',
    'https://www.sofomo.com',
    'so-fo-mo.com',
    'www.so-fo-mo.com',
    'http://so-fo-mo.com',
    'https://so-fo-mo.com',
    'http://www.so-fo-mo.com',
    'https://www.so-fo-mo.com',
    '104.26.7.84'
  ].freeze

  INVALID_ADDRESSES = [
    'http://',
    'http://www',
    'http://www.',
    'http://www.sofomo',
    'http://www.sofomo.sofomo',
    'https://',
    'https://www',
    'https://www.',
    'https://www.sofomo',
    'https://www.sofomo.sofomo',
    'www',
    'www.',
    'www.sofomo',
    'www.sofomo.sofomo',
    'sofomo',
    '.com',
    'com',
    '104',
    '104.26',
    '104.26.7',
    '104.26.7.84.0'
  ].freeze

  test 'should return sanitized addresses' do
    VALID_ADDRESSES[0..5].map do |address|
      assert_equal('sofomo.com', NetworkAddress.new(address).sanitize!)
    end

    VALID_ADDRESSES[6..11].map do |address|
      assert_equal('so-fo-mo.com', NetworkAddress.new(address).sanitize!)
    end

    assert_equal('104.26.7.84', NetworkAddress.new(VALID_ADDRESSES.last).sanitize!)
  end

  test 'should raise an error' do
    INVALID_ADDRESSES.each do |address|
      assert_raises { NetworkAddress.new(address).sanitize! }
    end

    error = assert_raises { NetworkAddress.new('').sanitize! }

    assert_equal("Address can't be blank", error.message)
  end
end
