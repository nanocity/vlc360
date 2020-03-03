require 'simplecov'

module SimpleCov::Configuration
  def clean_filters
    @filters = []
  end
end

SimpleCov.configure do
  clean_filters
  load_adapter 'test_frameworks'
end

ENV["COVERAGE"] && SimpleCov.start do
  add_filter "/.rvm/"
end
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'webmock/rspec'
require 'hashie'
require 'experiences_spain'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

# Disable API requests
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.include StubbedResponses
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before :suite do
    ExperiencesSpain.auth_token = 'SomeAuthToken'
  end
end
