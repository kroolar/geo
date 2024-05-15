module Ipstack
  class Request
    BASE_URL = 'https://api.ipstack.com'.freeze

    attr_reader :access_key

    def initialize
      # TODO: Generate access key and add it to credentials
      @access_key = nil
    end

    def get(endpoint)
      request :get, endpoint
    end

    private

    def request(method, endpoint)
      response = HTTParty.send(
        method,
        "#{BASE_URL}/#{endpoint}?access_key=#{access_key}"
      )

      is_successfull = response.fetch('status', false)

      is_successfull ? response : raise_exception(response)
    end

    def raise_exception(response)
      code = response.dig('error', 'code')
      type = response.dig('error', 'type')
      info = response.dig('error', 'info')

      raise case [code, type]
            when [101, 'missing_access_key']          then Exceptions::MissingAccessKey
            when [101, 'invalid_access_key']          then Exceptions::InvalidAccessKey
            when [102, 'inactive_user']               then Exceptions::InactiveUser
            when [103, 'invalid_api_function']        then Exceptions::InvalidAPIFunction
            when [104, 'usage_limit_reached']         then Exceptions::UsageLimitReached
            when [105, 'function_access_restricted']  then Exceptions::FunctionAccessRestricted
            when [105, 'https_access_restricted']     then Exceptions::HTTPSAccessRestricted
            when [301, 'invalid_fields']              then Exceptions::InvalidFields
            when [302, 'too_many_ips']                then Exceptions::TooManyIPs
            when [303, 'batch_not_supported_on_plan'] then Exceptions::BatchNotSupportedOnPlan
            when [404, '404_not_found']               then Exceptions::NotFound
            else Exceptions::UndefinedError.new("Undefined Error: (Code #{code}) #{info}")
            end
    end
  end
end
