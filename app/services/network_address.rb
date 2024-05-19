class NetworkAddress
  attr_reader :address

  TLD_WHITELIST = %w[com org pl io dev net ai info].freeze

  def initialize(address)
    @address = address
  end

  def sanitize!
    raise StandardError, "Address can't be blank" if address.blank?

    ip? ? address : sanitize_url!
  end

  private

  def sanitize_url!
    new_address =
      if    address.start_with?('www.')         then address.gsub('www.', '')
      elsif address.start_with?('https://www.') then address.gsub('https://www.', '')
      elsif address.start_with?('https:/www.')  then address.gsub('https:/www.', '')
      elsif address.start_with?('https://')     then address.gsub('https://', '')
      elsif address.start_with?('https:/')      then address.gsub('https:/', '')
      elsif address.start_with?('http://www.')  then address.gsub('http://www.', '')
      elsif address.start_with?('http:/www.')   then address.gsub('http:/www.', '')
      elsif address.start_with?('http://')      then address.gsub('http://', '')
      elsif address.start_with?('http:/')       then address.gsub('http:/', '')
      else  address
      end

    validate_address_length(new_address)

    domain, tld = new_address.split('.')

    validate_domain(domain)
    validate_tld(tld)

    new_address
  end

  def ip? = address.match?(Resolv::AddressRegex)

  def validate_address_length(address)
    return if address.split('.').size == 2

    raise StandardError, "Address #{address} is not valid!"
  end

  def validate_domain(domain)
    return if domain.match?('^[A-Za-z0-9-]+$')

    raise StandardError, "Domain #{domain} is not valid!"
  end

  def validate_tld(tld)
    return if tld.in?(TLD_WHITELIST)

    raise StandardError, "Top Level Domain #{tld} is not valid!"
  end
end
