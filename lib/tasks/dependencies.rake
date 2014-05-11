def linux?
  @using_linux ||= `cat /proc/version` =~ /Linux/
end

def homebrew_installed?
  @installed ||= `which brew` and $?.success?
end

def package_manager
  @package_manager ||= if linux?
    'apt-get'
  else
    'brew'
  end
end

def applications
  @applications ||= begin
    file_path = File.expand_path "~/.dots/applications"
    File.read(file_path).split("\n").join ' '
  end
end

namespace :install do
  namespace :dependencies do
    task :submodules do
      sh %(
        cd ~/.dots;
        git submodule init;
        git submodule update;
      )
    end

    task :install_homebrew do
      unless linux? && homebrew_installed?
        sh 'ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"'
      end
    end

    task :packages => :install_homebrew do
      sh "#{package_manager} install #{applications}"
    end
  end

  task :dependencies => %w(
    install:dependencies:submodules
    install:dependencies:packages
  )
end

