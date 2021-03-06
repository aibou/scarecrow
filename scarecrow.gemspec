# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scarecrow/version'

Gem::Specification.new do |spec|
  spec.name          = "scarecrow"
  spec.version       = Scarecrow::VERSION
  spec.authors       = ["aibou"]
  spec.email         = ["aibou7251@gmail.com"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "codeclimate-test-reporter" if RUBY_VERSION >= '1.9'
  

  spec.add_runtime_dependency "sinatra"
  spec.add_runtime_dependency "hashie"
end
