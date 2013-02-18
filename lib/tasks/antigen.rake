desc "Update vendored Antigen from Git"
task :antigen do
  sh "git submodule sync"
  sh "git submodule foreach 'git pull origin master'"
end
