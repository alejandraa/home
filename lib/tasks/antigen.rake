namespace :antigen do
  desc "Install/upgrade the Antigen submodule from Git"
  task :install do
    sh "git submodule sync"
    sh "git submodule foreach 'git pull origin master'"
  end

  desc "Update all installed plugins"
  task :update do
    sh "antigen update"
  end
end

desc "Update vendored Antigen from Git"
task :antigen => ['antigen:install', 'antigen:update']
