class Dir
  def self.exists? dir_path
    File.exists? File.expand_path(dir_path)
  end
end

namespace :install do
  task :folders do
    sh 'ln -s ~/.dots/bin ~/bin' unless Dir.exists? "~/bin"
    sh "ln -s ~/.dots/etc ~/etc" unless Dir.exists? "~/etc"
  end

  task :configuration => :configure do
    %w(zshenv zshrc).each do |config_file|
      `source ~/.#{config_file}`
    end
  end
end

desc "Install DOTS to this user's home directory"
task :install => %w(
  install:folders
  install:dependencies
  install:configuration
  install:vim
)
