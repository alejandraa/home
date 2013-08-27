class Dir
  def self.exists? dir_path
    File.exists? File.expand_path(dir_path)
  end
end

namespace :install do
  task :links do
    sh 'ln -s ~/.dots/bin ~/bin' unless Dir.exists? "~/bin"
    sh "ln -s ~/.dots/etc ~/etc" unless Dir.exists? "~/etc"
  end

  task :configuration do
    HOME = ENV['HOME'] || File.expand_path('~')

    sh "#{HOME}/.dots/bin/dots update"
    sh "#{HOME}/.dots/bin/dots reload"
  end

  task :submodules do
    sh 'cd ~/.dots && git submodule init && git submodule update'
  end

  task :applications do
    application_config_path = File.expand_path "~/.dots/applications"
    applications = File.read(application_config_path).split("\n").join(' ')
    install_command = if `cat /proc/version` =~ /Linux/
      "apt-get install -y #{applications}"
    else
      sh %{ ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)" } \
        unless `which brew` =~ /brew/

      "brew install #{applications}"
    end

    sh install_command
  end
end

desc "Install DOTS to this user's home directory"
task :install => %w(
  install:links
  install:configuration
  install:submodules
  install:applications
)
