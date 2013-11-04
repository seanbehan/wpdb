# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wpdb/version'

Gem::Specification.new do |spec|
  spec.name          = "wpdb"
  spec.version       = Wpdb::VERSION
  spec.authors       = ["Sean Behan"]
  spec.email         = ["inbox@seanbehan.com"]
  spec.description   = %q{Wrapper for Wordpress DB}
  spec.summary       = %q{Active Record for the Wordpress DB}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "activerecord", "~> 4.0"
end
