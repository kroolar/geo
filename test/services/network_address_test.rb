require 'test_helper'

class NetworkAddressTest < ActiveSupport::TestCase
  test 'return true if provided address is valid IP address' do
    # Given: Serivce with valid IP address
    address = NetworkAddress.new('10.10.10.10')

    # When: Use .ip? method
    # Then: Should return true
    assert address.ip?
  end

  test 'return false if provided address is invalid IP address' do
    # Given: Serivce with invalid IP address
    address = NetworkAddress.new('10.10.10.10.10')

    # When: Use .ip? method
    # Then: Should return false
    refute address.ip?
  end

  test 'return true if provided address is valid URL address' do
    # Given: Serivce with valid URL address
    address = NetworkAddress.new('https://sofomo.com')

    # When: Use .url? method
    # Then: Should return true
    assert address.url?
  end

  test 'return false if provided address is invalid URL address' do
    # Given: Serivce with invalid URL address
    address = NetworkAddress.new('sofomo.com')

    # When: Use .url? method
    # Then: Should return false
    refute address.url?
  end

  test 'return true if provided address is valid' do
    # Given: Serivce with valid URL address
    address = NetworkAddress.new('https://sofomo.com')

    # When: Use .valid? method
    # Then: Should return true
    assert address.valid?
  end

  test 'return true if provided address is invalid' do
    # Given: Serivce with valid URL address
    address = NetworkAddress.new('sofomo.com')

    # When: Use .invalid? method
    # Then: Should return true
    assert address.invalid?
  end

  test 'return :ip if provided address type is IP' do
    # Given: Serivce with valid IP address
    address = NetworkAddress.new('10.10.10.10')

    # When: Use .type method
    # Then: Should return :ip
    assert_equal :ip, address.type
  end

  test 'return :url if provided address type is URL' do
    # Given: Serivce with valid URL address
    address = NetworkAddress.new('https://sofomo.com')

    # When: Use .type method
    # Then: Should return :url
    assert_equal :url, address.type
  end
end
