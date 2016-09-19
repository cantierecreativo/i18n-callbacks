# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "i18n/callbacks/version"

Gem::Specification.new do |spec|
  spec.name          = "i18n-callbacks"
  spec.version       = I18n::Callbacks::VERSION
  spec.authors       = ["Joe Yates"]
  spec.email         = ["joe.g.yates@gmail.com"]

  spec.summary       = %q{Pre- and post-process you calls to I18n.t()}
  spec.homepage      = "https://github.com/cantierecreativo/i18n-callbacks"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.lines.map(&:chomp!)
  spec.test_files    = `git ls-files spec`.lines.map(&:chomp!)
  spec.require_paths = ["lib"]

  spec.add_dependency "i18n"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
