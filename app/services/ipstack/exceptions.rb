module Ipstack
  module Exceptions
    class MissingAccessKey < StandardError
      def message = 'No API Key was specified'
    end

    class InvalidAccessKey < StandardError
      def message = 'No API Key was specified or an invalid API Key was
        specified.'
    end

    class InactiveUser < StandardError
      def message = 'The current user account is not active. User will be
        prompted to get in touch with Customer Support.'
    end

    class InvalidAPIFunction < StandardError
      def message = 'The requested API endpoint does not exist.'
    end

    class UsageLimitReached < StandardError
      def message = 'The maximum allowed amount of monthly API requests has been
        reached.'
    end

    class FunctionAccessRestricted < StandardError
      def message = 'The current subscription plan does not support this API
        endpoint.'
    end

    class HTTPSAccessRestricted < StandardError
      def message = "The user's current subscription plan does not support HTTPS
        Encryption."
    end

    class InvalidFields < StandardError
      def message = 'One or more invalid fields were specified using the fields
        parameter.'
    end

    class TooManyIPs < StandardError
      def message = 'Too many IPs have been specified for the Bulk Lookup
        Endpoint. (max. 50)'
    end

    class BatchNotSupportedOnPlan < StandardError
      def message = 'The Bulk Lookup Endpoint is not supported on the current
        subscription plan.'
    end

    class NotFound < StandardError
      def message = 'The requested resource does not exist.'
    end

    class UndefinedError < StandardError; end
  end
end
