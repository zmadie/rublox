# frozen_string_literal: true

require "dotenv"
require "rublox"
require "test/unit"

Dotenv.load

ROBLOSECURITY = ENV["ROBLOSECURITY"]
INVALID_ID = 9e10.to_i

Dir.glob("*.rb", base: "tests") do |file_name|
  next if file_name == "run_tests.rb"

  require_relative file_name
end
