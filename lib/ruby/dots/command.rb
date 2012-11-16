require 'dots/persistence'

module Dots
  class Command < Thor
    include FileUtils
    include Thor::Actions

    include Dots::Persistence
    #include Dots::Installer

    default_task :usage

    desc :usage, "Show usage information"
    def usage
      say <<-TEXT

The DOTS Project

DOTS is a ZSH Framework for managing your dotfiles and other shell configuration.
It also gives you some nice, sensible defaults and time-saver aliases to better
work with and understand your shell environment.

The following tasks are meant to help you use the shell more efficiently...

      TEXT

      help
    end

    def install
      unless File.exists? File.expand_path("~/.dots")
        run "git clone https://github.com/tubbo/dots.git ~/.dots" unless File.exists?
      end

      invoke :link
    end

    desc :update, "Update DOTS, Antigen and all plugins to their latest version."
    def update
      run "cd ~/.dots && git pull origin master"
      run "cd ~/.dots && git submodule foreach 'git pull origin master' && git submodule update"
      run "source ~/.dots/vendor/antigen/antigen.zsh && antigen-update"
    end

    desc :version, "Show the current version of DOTS"
    def version
      say "DOTS version #{Dots::VERSION} - http://tubbo.github.com/dots"
    end
  end
end
