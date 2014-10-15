# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'moysklad/version'

Gem::Specification.new do |spec|
  spec.name          = "moysklad"
  spec.version       = Moysklad::VERSION
  spec.authors       = ["uno4ki"]
  spec.email         = ["i.have@no.mail"]
  spec.description   = %q{MoySklad API}
  spec.summary       = %q{MoySklad API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "rspec", "~> 3.1"

  spec.add_dependency "activesupport", "~> 4.1"
  spec.add_dependency "activeresource", "~> 4.0"
  spec.add_dependency "nokogiri", "~> 1.6"
end
