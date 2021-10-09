# frozen_string_literal: true

require_relative "lib/rublox/version"

Gem::Specification.new do |spec|
  spec.name = "rublox"
  spec.version = Rublox::VERSION
  spec.authors = %w[Zamdie Keef]
  spec.email = "rorg.devv@gmail.com"
  spec.summary = "A Roblox web API wrapper written in Ruby"
  spec.description = "This gem allows easy interaction with the Roblox web API via class models."
  spec.homepage = "https://github.com/roblox-api-wrappers/rublox"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0"
  spec.files = Dir[
    "LICENSE",
    "CHANGELOG.MD",
    "lib/**/*.rb",
    "rublox.gemspec",
    "Gemfile",
    "Rakefile"
  ]
  spec.extra_rdoc_files = ["README.MD"]

  spec.add_dependency "http", "~> 5.0.2"

  spec.add_development_dependency "dotenv", "~> 2.7"
  spec.add_development_dependency "rake", "~> 13.0.6"
  spec.add_development_dependency "rubocop", "~> 1.21.0"
  spec.add_development_dependency "rubocop-performance", "~> 1.11.5"
  spec.add_development_dependency "yard", "~> 0.9.26"
end
