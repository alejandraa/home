namespace :install do
  namespace :vim do
    namespace :plugins do
      task :manager do
        path = File.expand_path '~/.vim/bundle/vundle'

        unless File.exists? "#{path}/autoload/vundle.vim"
          repo = "https://github.com/gmarik/vundle.git"
          sh "mkdir -p ~/.vim/bundle && git clone #{repo} #{path}"
        end
      end

      task :bundle do
        sh 'vim +BundleInstall +qall'
      end
    end

    task :plugins => %w(vim:plugins:manager vim:plugins:bundle)

    task :wiki do
      sh 'mkdir -p ~/Documents/Wiki'
    end
  end

  task :vim => %w(
    vim:plugins
    vim:wiki
  )
end
