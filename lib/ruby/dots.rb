require 'bundler'
Bundler.require :default

require 'dots/command'

module Dots
  VERSION = '0.5.0'
  DOTS_HOME = File.expand_path "~/.dots"
  USER_HOME = File.expand_path "~/"
end
