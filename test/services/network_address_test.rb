require 'test_helper'

class NetworkAddressTest < ActiveSupport::TestCase
  test 'return nil when address is an IP address' do
    # Given: Serivce with valid IP address
    network_address = NetworkAddress.new('10.10.10.10')

    # When: Use domain_name method
    # Then: Should return nil
    assert_nil network_address.domain_name
  end

  test 'return domain name when address is a URL' do
    # Given: Serivce with valid URL address
    network_address = NetworkAddress.new('https://sofomo.com')

    # When: Use domain_name method
    # Then: Should return domain name
    assert_equal 'sofomo.com', network_address.domain_name
  end

  test 'return true if provided address is valid IP address' do
    # Given: Serivce with valid IP address
    network_address = NetworkAddress.new('10.10.10.10')

    # When: Use .ip? method
    # Then: Should return true
    assert network_address.ip?
  end

  test 'return false if provided address is invalid IP address' do
    # Given: Serivce with invalid IP address
    network_address = NetworkAddress.new('10.10.10.10.10')

    # When: Use .ip? method
    # Then: Should return false
    refute network_address.ip?
  end

  test 'return true if provided address is valid URL address' do
    # Given: Serivce with valid URL address
    network_address = NetworkAddress.new('https://sofomo.com')

    # When: Use .url? method
    # Then: Should return true
    assert network_address.url?
  end

  test 'return false if provided address is invalid URL address' do
    # Given: Serivce with invalid URL address
    network_address = NetworkAddress.new('sofomo.com')

    # When: Use .url? method
    # Then: Should return false
    refute network_address.url?
  end

  test 'return true if provided address is valid' do
    # Given: Serivce with valid URL address
    network_address = NetworkAddress.new('https://sofomo.com')

    # When: Use .valid? method
    # Then: Should return true
    assert network_address.valid?
  end

  test 'return true if provided address is invalid' do
    # Given: Serivce with valid URL address
    network_address = NetworkAddress.new('sofomo.com')

    # When: Use .invalid? method
    # Then: Should return true
    assert network_address.invalid?
  end

  test 'return :ip if provided address type is IP' do
    # Given: Serivce with valid IP address
    network_address = NetworkAddress.new('10.10.10.10')

    # When: Use .type method
    # Then: Should return :ip
    assert_equal :ip, network_address.type
  end

  test 'return :url if provided address type is URL' do
    # Given: Serivce with valid URL address
    network_address = NetworkAddress.new('https://sofomo.com')

    # When: Use .type method
    # Then: Should return :url
    assert_equal :url, network_address.type
  end
end
