# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_hash/like/version'

Gem::Specification.new do |spec|
  spec.name          = "active_hash-like"
  spec.version       = ActiveHash::Like::VERSION
  spec.authors       = ["monochromegane"]
  spec.email         = ["dev.kuro.obi@gmail.com"]

  spec.summary       = %q{Custom matcher for ActiveHash. It provides `like` operator.}
  spec.description   = %q{Custom matcher for ActiveHash. It provides `like` operator.}
  spec.homepage      = "https://github.com/monochromegane/active_hash-like"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "active_hash"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"
end
