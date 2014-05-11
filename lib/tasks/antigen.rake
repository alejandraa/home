namespace :antigen do
  task :install do
    sh "git submodule sync"
    sh "git submodule foreach 'git pull origin master'"
  end

  task :update do
    sh "antigen update"
  end
end

desc "Update vendored Antigen from Git"
task :antigen => ['antigen:install', 'antigen:update']
