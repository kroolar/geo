require 'test_helper'

module Ipstack
  class ExceptionsTest < ActiveSupport::TestCase
    test 'raise MissingAccessKey exception' do
      assert_exception Exceptions::MissingAccessKey, 'No API Key was specified'
    end

    test 'raise InvalidAccessKey exception' do
      assert_exception Exceptions::InvalidAccessKey, 'No API Key was specified or an invalid API Key was specified.'
    end

    test 'raise InactiveUser exception' do
      assert_exception Exceptions::InactiveUser, 'The current user account is not active. User will be prompted to get in touch with Customer Support.'
    end

    test 'raise InvalidAPIFunction exception' do
      assert_exception Exceptions::InvalidAPIFunction, 'The requested API endpoint does not exist.'
    end

    test 'raise UsageLimitReached exception' do
      assert_exception Exceptions::UsageLimitReached, 'The maximum allowed amount of monthly API requests has been reached.'
    end

    test 'raise FunctionAccessRestricted exception' do
      assert_exception Exceptions::FunctionAccessRestricted, 'The current subscription plan does not support this API endpoint.'
    end

    test 'raise HTTPSAccessRestricted exception' do
      assert_exception Exceptions::HTTPSAccessRestricted, "The user's current subscription plan does not support HTTPS Encryption."
    end

    test 'raise InvalidFields exception' do
      assert_exception Exceptions::InvalidFields, 'One or more invalid fields were specified using the fields parameter.'
    end

    test 'raise TooManyIPs exception' do
      assert_exception Exceptions::TooManyIPs, 'Too many IPs have been specified for the Bulk Lookup Endpoint. (max. 50)'
    end

    test 'raise BatchNotSupportedOnPlan exception' do
      assert_exception Exceptions::BatchNotSupportedOnPlan, 'The Bulk Lookup Endpoint is not supported on the current subscription plan.'
    end

    test 'raise NotFound exception' do
      assert_exception Exceptions::NotFound, 'The requested resource does not exist.'
    end

    private

    def assert_exception(exception_class, message)
      error = assert_raises(StandardError) { raise exception_class }

      assert_equal(exception_class, error.class)
      assert_equal(message, error.message)
    end
  end
end
