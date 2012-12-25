module Dots
  module Bootstrap
    include Thor::Actions

    # These are the programs we are going to download from Homebrew.
    PROGRAMS = %w(httpie git ruby)

    # Install the latest version of all gems to the global gemset.
    def install_bundle
      system "cd #{Dots::HOME} && #{bundle_install}"
    end

    # Install C binaries, Python programs, and other useful tools
    # from Homebrew.
    def install_programs
      if installed? "brew"
        programs_to_install = PROGRAMS.reduce([]) { |programs, program|
          programs << program unless installed? program
        }.join " "

        system "brew install #{programs_to_install}"
      else
        install_homebrew
      end
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
      "bundler install --gemfile=~/.Gemfile"
    end

    def install_bundler
      "gem install bundler"
    end

    # Install the latest version of the Homebrew package manager.
    def install_homebrew
      %x[ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"]
    end
  end
end
