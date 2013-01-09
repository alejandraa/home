require 'dots/packages'

module Dots
  module Bootstrap
    include Thor::Actions

    # Install C binaries, Python programs, and other useful tools
    # from Homebrew. Install Homebrew if it isn't already installed,
    # then recursively call this method to install packages.
    def install_programs
      if installed? "brew"
        install_packages and install_configuration
      elsif @homebrew.present? # make sure we're not in an infinite loop
        puts "WARNING: Homebrew can not install. Exiting.." and exit(1)
      else
        @homebrew = true # used when the if statement fails twice
        install_homebrew and install_programs
      end
    end

    # When Homebrew is installed, use it to install Python and Ruby, then
    # install necessary packages for Python and Ruby.
    def install_packages
      %w(system python ruby).each { |l| send "install_#{l}_packages" }
    end

    # Install configuration file templates that for one reason or another
    # we can't include in the repo directly. Usually due to exposed passwords
    # or API keys.
    def install_configuration
      system "mkdir -p ~/.irssi && cp -R ~/.dots/etc/irssi/** ~/.irssi"
    end

  private
    def installed? command
      `which #{command}` != ""
    end

    def installed_and_not_ruby? command
      installed?(command) && command != 'ruby'
    end

    def install_homebrew
      %x[ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"]
    end

    def install_system_packages
      programs_to_install = system_packages.reduce([]) { |programs, program|
        programs << program unless installed_and_not_ruby? program
      }.join " "

      system "brew install #{programs_to_install}" \
        unless programs_to_install.empty?
    end

    def install_ruby_packages
      "gem install #{ruby_packages}"
    end

    def install_python_packages
      system "pip install #{python_packages}"
    end

    %w(system python ruby).each do |language|
      define_method "#{language}_packages" do
        packages.for language
      end
    end

    def packages
      @packages ||= Packages.new
    end
  end
end
