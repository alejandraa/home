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

    desc :version, "Show the current version of DOTS"
    def version
      say "DOTS version #{Dots::VERSION} - http://tubbo.github.com/dots"
    end

    desc :persist, "Copy a dotfile to .dots/config and symlink the original location"
    def persist dot_file
      dot_file_without_dot = dot_file.gsub(/^\./, '')
      home = `echo $HOME`
      home.gsub!(/\n/, '')

      if mv "#{home}/#{dot_file}", "#{home}/.dots/config/#{dot_file_without_dot}"
        if `ln -s ~/.dots/config/#{dot_file_without_dot} ~/#{dot_file}`
          say "#{dot_file} saved to DOTS!"
          exit 0
        else
          say "Error: #{dot_file} could not be symlinked."
          exit 1
        end
      else
        say "Error: #{dot_file} could not be moved."
        exit 1
      end
    end

    desc :forget, "Remove the symlink and restore a dotfile back to its original location"
    def forget dot_file
      dot_file_without_dot = dot_file.gsub(/^\./, '')
      home = `echo $HOME`
      home.gsub!(/\n/, '')

      if rm "#{home}/#{dot_file}"
        if mv "#{home}/.dots/config/#{dot_file_without_dot}", "#{home}/#{dot_file}"
          say "#{dot_file} has been removed from your DOTS and restored to its original location."
          exit 0
        else
          say "Error: #{dot_file_without_dot} could not be moved."
          exit 1
        end
      else
        say "Error: #{dot_file} symlink could not be removed."
        exit 1
      end
    end
  end
end
