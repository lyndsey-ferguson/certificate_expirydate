# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/certificate_expirydate/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-certificate_expirydate'
  spec.version       = Fastlane::CertificateExpirydate::VERSION
  spec.author        = 'Lyndsey Ferguson'
  spec.email         = 'lyndsey.ferguson@gmail.com'

  spec.summary       = 'Retrieves the expiry date of the given p12 certificate file'
  spec.homepage      = "https://github.com/lyndsey-ferguson/certificate_expirydate"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w[README.md LICENSE]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  # spec.add_dependency 'your-dependency', '~> 1.0.0'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'fastlane', '>= 1.103.0'
end
