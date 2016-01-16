# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'traycheckout/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-traycheckout"
  spec.version       = Omniauth::Traycheckout::VERSION
  spec.authors       = ["Gabriel Pereira"]
  spec.email         = ["gabrielpedepera@gmail.com"]

  spec.summary       = %q{OmniAuth strategy for TrayCheckout.}
  spec.description   = %q{OmniAuth strategy for TrayCheckout.}
  spec.homepage      = "https://portal.traycheckout.com.br"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "omniauth"
  spec.add_dependency "omniauth-oauth2"
  spec.add_development_dependency "activesupport", "~> 4.2"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
