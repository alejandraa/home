namespace :vim do
  task :configuration do
    sh 'ln -s ~/.dots/config/vimrc ~/.vimrc'
    sh 'mkdir -p ~/.vim/bundle'
  end

  task :package_manager do
    sh 'git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle'
    sh 'vim +BundleInstall +qall'
  end
end

desc "Install Vim and related plugins"
task :vim => %w(vim:configuration vim:package_manager)
