# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jsonp/version'

Gem::Specification.new do |gem|
  gem.name          = "jsonp"
  gem.version       = Jsonp::VERSION
  gem.authors       = ["崔峥"]
  gem.email         = ["zheng.cuizh@gmail.com"]
  gem.description   = %q{Very simple and fast jsonp server}
  gem.summary       = %q{Very simple and fast jsonp server}
  gem.homepage      = "https://github.com/charlescui/jsonp"

  gem.add_development_dependency 'ansi'
  gem.add_development_dependency 'daemons'
  gem.add_development_dependency 'em-http-server'
  gem.add_development_dependency 'em-http-request'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "jsonp"
  gem.require_paths = ["lib"]
end
