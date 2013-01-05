# = Dots::Sanity
#
# This module helps me pair program with others who may not enjoy the
# quirky nature of my personal setup. It restores the shell,
# destructively, to some saner defaults.
module Dots
  module Sanity
    include Thor::Actions

    # Restore the shell to some more sensible defaults, and familiar
    # aliases.
    def stop_being_insane!
      restore_to_sensible_defaults and say_farewell
    end

    # Open the current folder in TextMate.
    def open_textmate
      if textmate_installed?
        system 'mate .'
      else
        say "Please install TextMate to open this folder sensibly."
        exit 1
      end
    end

  private
    def say_farewell
      if $? == 0
        true
      else
        say "There were errors robifying the shell.."
        false
      end
    end

    def restore_to_sensible_defaults
      commands = [
        "bindkey -e",
        "alias rbtest='nocorrect rtest_rake'",
        "alias rbtest_exec='rtest_bare'"
      ]
      restore_sensible_defaults = "zsh -c '#{commands.join(" && ")}'"
      system restore_sensible_defaults
    end

    def textmate_installed?
      `which mate` != ""
    end
  end
end
