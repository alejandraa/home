module Dots
  class Command < Thor
    include FileUtils

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

    desc :update, "Update DOTS to the latest version"
    def update
      %x(cd ~/.dots && git pull origin master)
    end

    desc :install, "Installs DOTS to ~/.dots and links all of your dotfiles"
    def install
      %x(ln -s #{installation_path} ~/.dots)

      Dir[File.expand_path("~/.dots/config")].each do |config_file|
        file_name = File.basename config_file
        dot_file = File.expand_path "~/.#{file_name}"

        if File.exists? dot_file
          say "Skipping #{dot_file} as it already exists. Manually merge and symlink later with `dots persist`."
        else
          %x(ln -s #{config_file} #{dot_file})
        end
      end
    end

    desc :version, "Show the current version of DOTS"
    def version
      say "DOTS version #{Dots::VERSION} - http://tubbo.github.com/dots"
    end

    desc :persist, "Copy a dotfile to .dots/config and symlink the original location"
    def persist file_name
      dot_file = Dots::DotFile.new file_name

      if dot_file.save
        say "#{dot_file} saved to DOTS!"
      else
        say "Error: #{dot_file} could not be symlinked:"
        dot_file.errors.full_messages.each { |msg| say "- #{msg}" }
      end
    end

    desc :forget, "Remove the symlink and restore a dotfile back to its original location"
    def forget file_name
      dot_file = Dots::DotFile.find file_name

      if dot_file.destroy
        say "#{dot_file} is no longer being persisted."
      else
        say "Error: #{dot_file} could not be forgotten:"
        dot_file.errors.full_messages.each { |msg| say "- #{msg}" }
      end
    end
  end
end
