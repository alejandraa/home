require 'yaml'

module Dots
  # Represents the config/packages.yml file.
  class Packages
    def initialize
      @config = YAML::load_file from_yaml_file_path
    end

    def for language
      @config[language]
    end

  private
    def from_yaml_file_path
      File.expand_path("~/.dots/config/packages.yml")
    end
  end
end
