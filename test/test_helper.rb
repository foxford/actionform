ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

if ActiveSupport::TestCase.method_defined?(:fixture_paths=)
  ActiveSupport::TestCase.fixture_paths = [File.expand_path("../fixtures", __FILE__)]
end
