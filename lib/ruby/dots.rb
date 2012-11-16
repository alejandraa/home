require 'rubygems'
require 'fileutils'
require 'bundler'
Bundler.require :default
require 'dots/dot_file'
require 'dots/command'
require 'dots/version'

module Dots
  # The root path of the DOTS gem.
  def self.root
    @root_dir ||= begin
      spec = Gem::Specification.find_by_name 'zsh_dots'
      spec.gem_dir
    end
  end
end

