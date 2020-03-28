require "bundler/setup"
require "lost_ship"
require "json"

module LostShip
  module SpecSupport
    def load_fixture(filename:)
      content = File.read(File.expand_path("../fixtures/#{filename}", __FILE__))
      JSON.parse(content)
    end
  end
end
RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.include(LostShip::SpecSupport)
end
