module Dots
  module Bootstrap
    include Thor::Actions

    # These are the programs we are going to download from Homebrew.
    PROGRAMS = %w(git ruby python vim pip hub)
    PACKAGES = %w(httpie aws)

    # Install C binaries, Python programs, and other useful tools
    # from Homebrew.
    def install_programs
      if installed? "brew"
        programs_to_install = PROGRAMS.reduce([]) { |programs, program|
          programs << program unless installed? program
        }.join " "

        system "brew install #{programs_to_install}" \
          unless programs_to_install.empty?
      else
        install_homebrew
      end
    end

    # Install the latest version of all gems to the global gemset. These
    # gems are configured in +~/.Gemfile+.
    def install_bundle
      system "cd #{Dots::HOME} && #{bundle_install}"
    end

    # Install Python packages from pip. Pip!
    def install_packages
      system "pip install #{PACKAGES.join(' ')}"
    end

  private
    def installed? command
      `which #{command}` != ""
    end

    def bundle_install
      return install_global_gemset if installed? 'bundle'
      "#{install_bundler} #{install_global_gemset}"
    end

    def install_global_gemset
      "bundle install --gemfile=#{global_gemset}"
    end

    def install_bundler
      "gem install bundler"
    end

    # Install the latest version of the Homebrew package manager.
    def install_homebrew
      %x[ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"]
    end

    def global_gemset
      "#{Dots.root}/config/Gemfile"
    end
  end
end
