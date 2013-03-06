# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'test_bisect/version'

Gem::Specification.new do |spec|
  spec.name          = "test_bisect"
  spec.version       = TestBisect::VERSION
  spec.authors       = ["Jon Guymon"]
  spec.email         = ["jon@newrelic.com"]
  spec.description   = %q{toot}
  spec.summary       = %q{toot}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
