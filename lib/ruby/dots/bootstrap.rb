module Dots
  module Bootstrap
    include Thor::Actions

    # These are the programs we are going to download from Homebrew.
    PROGRAMS = %w(git ruby python vim pip hub mutt procmail)
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
        install_packages
      else
        install_homebrew and install_programs
      end
    end

    # Install the latest version of all gems to the global gemset. These
    # gems are configured in +~/.Gemfile+.
    def install_bundle
      system "cd && #{install_bundler} && #{install_global_gemset}"
    end

    # Install Python packages from pip. Pip!
    def install_packages
      system "pip install #{PACKAGES.join(' ')}"
    end

  private
    def installed? command
      `which #{command}` != ""
    end

    def install_bundler
      "gem install bundler"
    end

    def install_global_gemset
      "gem install #{Dots.gems}"
    end

    # Install the latest version of the Homebrew package manager.
    def install_homebrew
      %x[ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"]
    end
  end
end
