require 'rubygems'
require 'fileutils'
require 'thor'
require 'active_model'
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

  # The home directory of DOTS.
  def self.home
    @home_dir ||= File.expand_path "~/.dots"
  end

  # Usage information for the DOTS command line tool.
  USAGE_INFORMATION = <<-TEXT

  The DOTS Project

  DOTS is a ZSH Framework for managing your dotfiles and other shell configuration.
  It also gives you some nice, sensible defaults and time-saver aliases to better
  work with and understand your shell environment.

  The following tasks are meant to help you use the shell more efficiently...

  TEXT

end

