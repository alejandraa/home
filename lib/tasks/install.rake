namespace :install do
  desc "Install certain config files and binaries to bootstrap DOTS"
  task :configuration => ['install:binaries'] do
    %w(zshrc zshenv vimrc).each do |filename|
      sh "ln -s ~/.dots/config/#{filename} ~/.#{filename}"
    end
  end

  task :binaries do
    sh 'ln -s ~/.dots/bin ~/bin'
  end

  desc "Install vendored code in the DOTS folder"
  task :submodules do
    sh 'cd ~/.dots && git submodule init && git submodule update'
  end
end

desc "Install DOTS to this user's home directory"
task :install => %w(
  install:configuration
  install:binaries
  install:submodules
  install:applications
)
