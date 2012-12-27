require 'dots/persistence'
require 'dots/installation'
require 'dots/bootstrap'

module Dots
  class Command < Thor
    include Thor::Actions, Dots::Persistence, Dots::Installation, Dots::Bootstrap
    default_task :usage

    desc :usage, "Show usage information"
    def usage
      say Dots.usage_information and help
    end

    desc :install, "Copies DOTS to your home directory."
    def install
      copy_to_home_directory and link_dot_files
    end

    desc :update, "Update DOTS, Antigen and all plugins to their latest version."
    def update
      update_the_framework
    end

    desc :version, "Show the current version of DOTS"
    def version
      say dots_version
    end

    desc :link, "Symlink your ~/.dots/config into dotfiles"
    def link
      link_dot_files
    end

    desc :persist, "Copy a dotfile to .dots/config and symlink the original location"
    def persist name
      persist_dot_file name
    end

    desc :forget, "Remove the symlink and restore a dotfile back to its original location"
    def forget name
      forget_dot_file name
    end

    desc :bootstrap, "Install the whole shebang: gems, C programs, Python stuff, DOTS."
    def bootstrap
      install_programs and install_bundle and install
    end

    desc :bundle, "Install and update the global gem bundle"
    def bundle
      install_bundle
    end
  end
end
