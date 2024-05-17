class NetworkAddress
  attr_reader :address

  def initialize(address)
    @address = address
  end

  def sanitize
    address.gsub('http://', '')
           .gsub('http:/', '')
           .gsub('https://', '')
           .gsub('https:/', '')
  end

  def ip? = address.match?(Resolv::AddressRegex)

  def url? = "https://#{address}".match?(URI::DEFAULT_PARSER.make_regexp(%w[http https]))

  def valid? = ip? || url?

  def invalid? = !valid?

  def type
    if    ip?  then :ip
    elsif url? then :url
    end
  end

  def validate!
    raise StandardError, "Address can't be blank" if address.blank?
    raise StandardError, 'Invalid URL or IP' if invalid?
  end
end
