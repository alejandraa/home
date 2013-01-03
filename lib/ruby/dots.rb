require 'rubygems'
require 'fileutils'
require 'thor'
require 'active_model'
require 'dots/dot_file'
require 'dots/command'
require 'dots/version'
require 'dots/persistence'
require 'dots/installation'

module Dots
  # All gems installed by DOTS
  GEMS = %w(dots pv git_tracker rails)

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

  def self.usage_information
    path = "#{Dots.root}/lib/ruby/templates/usage.txt.erb"
    template = ERB.new File.read(path)

    template.result(binding)
  end

  # Shows a String with the current version of the framework.
  def self.dots_version
    "DOTS version #{Dots::VERSION} - http://github.com/tubbo/dots"
  end

  def dots_version
    self.dots_version
  end

  # The home directory for the current user.
  HOME = ENV['HOME']

  # Accessor for all gems installed by DOTS, formatted for a `gem install`.
  def self.gems
    GEMS.join " "
  end
end

