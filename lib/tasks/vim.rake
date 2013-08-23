namespace :vim do
  task :configuration do
    vim_config_path = File.expand_path '~/.vimrc'
    sh "ln -s ~/.dots/config/vimrc #{vim_config_path}" \
      unless File.exists? vim_config_path
  end

  namespace :plugins do
    task :manager do
      path = File.expand_path '~/.vim/bundle/vundle'

      unless File.exists? "#{path}/autoload/vundle.vim"
        repo = "https://github.com/gmarik/vundle.git"
        sh 'mkdir -p ~/.vim/bundle'
        sh "git clone #{repo} #{path}" 
      end
    end

    task :bundle do
      sh 'vim +BundleInstall +qall'
    end
  end

  desc "Install Vim plugins"
  task :plugins => %w(vim:plugins:manager vim:plugins:bundle)
end

desc "Install Vim and related plugins"
task :vim => %w(vim:configuration vim:plugins)
