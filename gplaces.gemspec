# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gplaces/version"

Gem::Specification.new do |gem|
  gem.name          = "gplaces"
  gem.version       = Gplaces::VERSION
  gem.authors       = ["Thiago Bueno"]
  gem.email         = ["tbueno@tbueno.com"]
  gem.description   = "Google Places API gem"
  gem.summary       = "This gem provides a Ruby interface for the Google Places API"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "curb"

  gem.add_development_dependency "rake", "~> 10.4"
  gem.add_development_dependency "rspec", "~> 3.0"
  gem.add_development_dependency "webmock", "~> 1.18"
  gem.add_development_dependency "rubocop", "~> 0.32"
end
