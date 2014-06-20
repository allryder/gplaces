# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gplaces/version'

Gem::Specification.new do |gem|
  gem.name          = "gplaces"
  gem.version       = Gplaces::VERSION
  gem.authors       = ["Thiago Bueno"]
  gem.email         = ["tbueno@tbueno.com"]
  gem.description   = %q{Google Places API gem}
  gem.summary       = %q{This gem provides a Ruby interface for the Google Places API}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'virtus'
  gem.add_dependency 'httparty'
end
