module Dots
  class Command < Thor
    include FileUtils
    include Thor::Actions

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

    #curl -L https://get.rvm.io | bash -s stable --ruby=rbx --gems=rails,puma

    desc :link, "Symlink your ~/.dots/config into dotfiles"
    def link
      Dir["config/*"].each do |config_file|
        unless File.directory? config_file or config_file =~ /\.zsh$/
          config_file.gsub! /config\/|.example/, ""
          config_file_path = File.expand_path "~/.dots/config/#{config_file}"
          dot_file_path = File.expand_path "~/.#{config_file}"

          if File.exists? dot_file_path
            say "Did not symlink #{config_file} since one already exists"
          else
            File.symlink config_file_path, dot_file_path
            say "Symlinked ~/.#{config_file}"
          end
        end
      end

      update
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
