# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ruby/dots/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tom Scott"]
  gem.email         = ["tubbo@psychedeli.ca"]
  gem.description   = %q{DOTS is an advanced ZSH framework.}
  gem.summary       = <<-TEXT
  DOTS is an advanced ZSH framework. It abstracts a lot of hard-to-remember commands away from you
  and leaves you with fully-documented, easy-to-remember, plain-english aliases for common tasks.
  Supporting the Antigen framework for plugins, it's meant to be easy to install and light-weight in
  code, but able to support and replicate an entire home directory worth of dotfiles, essentially
  enabling you to take your shell environment "on the road" in a Github repository.
  TEXT
  gem.homepage      = "http://tubbo.github.com/dots"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.name          = "dots"
  gem.require_paths = ["lib/ruby"]
  gem.version       = Dots::VERSION

  gem.add_runtime_dependency 'thor'
  gem.add_runtime_dependency 'activemodel'

  gem.add_development_dependency 'rake'
end
