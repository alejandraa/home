require 'dots/persistence'

module Dots
  class Command < Thor
    include Thor::Actions
    include Dots::Persistence
    include Dots::Installation

    default_task :usage

    desc :usage, "Show usage information"
    def usage
      say Dots::USAGE_INFORMATION and help
    end

    desc :install, "Copies DOTS to your home directory."
    def install
      copy_to_home_directory! and link_dot_files!
    end

    desc :update, "Update DOTS, Antigen and all plugins to their latest version."
    def update
      pull_from_origin! and run 'reload'
    end

    desc :version, "Show the current version of DOTS"
    def version
      say "DOTS version #{Dots::VERSION} - http://tubbo.github.com/dots"
    end

    desc :link, "Symlink your ~/.dots/config into dotfiles"
    def link
      link_dot_files!
    end

    desc :persist, "Copy a dotfile to .dots/config and symlink the original location"
    def persist file_name
      persist_dot_file! file_name
    end

    desc :forget, "Remove the symlink and restore a dotfile back to its original location"
    def forget file_name
      forget_dot_file! file_name
    end
  end
end
