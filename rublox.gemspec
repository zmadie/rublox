# frozen_string_literal: true

Gem::Specification.new do |spec|
	spec.name = "rublox"
	spec.version = "0.3.0"
	spec.authors = %w[zmλdie keef]
	spec.email = "rorg.devv@gmail.com"
	spec.summary = "A Roblox web API wrapper written in Ruby"
	spec.description = "This gem allows easy interaction with the Roblox web API via modules and classes."
	spec.homepage = "https://github.com/roblox-api-wrappers/rublox"
	spec.metadata = {
		"Documentation" => "https://rubydoc.info/gems/rublox",
		"rubygems_mfa_required" => "true"
	}
	spec.license = "MIT"
	spec.required_ruby_version = ">= 2.7.0"
	spec.files = Dir[
		"README.md",
		"LICENSE",
		"lib/**/*.rb",
		"rublox.gemspec"
	]

	spec.add_dependency "http", "~> 5.1.1"

	spec.add_development_dependency "rubocop", "~> 1.44.1"
	spec.add_development_dependency "rubocop-performance", "~> 1.15.2"
	spec.add_development_dependency "rubocop-rake", "~> 0.6.0"
	spec.add_development_dependency "yard", "~> 0.9.28"
end
