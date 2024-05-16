class NetworkAddress
  attr_reader :address

  def initialize(address)
    @address = address
  end

  def ip? = address.match?(Resolv::AddressRegex)

  def url? = address.match?(URI::DEFAULT_PARSER.make_regexp(%w[http https]))

  def valid? = ip? || url?

  def invalid? = !valid?

  def type
    if    ip?  then :ip
    elsif url? then :url
    end
  end
end
