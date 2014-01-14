# -*- encoding: utf-8 -*-
require File.expand_path('../lib/noaa-alerts/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Cameron Cundiff", "Matt Cowley"]
  gem.email         = ["ckundo@gmail.com", "madcowley@gmail.com"]
  gem.description   = %q{A Ruby library for consuming NOAA National Weather Service severe weather alerts.}
  gem.summary       = %q{Fetch and format feeds from the NOAA.}
  gem.homepage      = "https://github.com/ckundo/noaa-alerts"

  gem.add_dependency("httparty", "~> 0.8.2")

  gem.add_development_dependency("rake") 
  gem.add_development_dependency("rspec", "~> 2.9.0")
  gem.add_development_dependency("webmock", "~> 1.8.7")
  gem.add_development_dependency("vcr", "~> 2.2.2")

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "noaa-alerts"
  gem.require_paths = ["lib"]
  gem.version       = Noaa::VERSION
end
