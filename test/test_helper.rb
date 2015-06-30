ENV['RAILS_ENV'] ||= 'test'
require "codeclimate-test-reporter"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

CodeClimate::TestReporter.start

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # Add more helper methods to be used by all tests here...
end
