namespace :dots do
  desc "Symlink all configuration files from ~/.dots/config into Dotfiles"
  task :config do
  end

  desc "Update DOTS, Antigen and all installed plugins"
  task :update do
    sh "cd ~/.dots && git pull origin master"
    sh "cd ~/.dots && git submodule sync"
    sh "antigen-update"
  end
end
