# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman-bitballoon/version'

Gem::Specification.new do |spec|
  spec.name          = "middleman-bitballoon"
  spec.version       = Middleman::BitBalloon::VERSION
  spec.authors       = ["Mathias Biilmann Christensen"]
  spec.email         = ["mathias@bitballoon.com"]
  spec.summary       = %q{Deploy MiddleMan built sites to BitBalloon}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bitballoon"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
