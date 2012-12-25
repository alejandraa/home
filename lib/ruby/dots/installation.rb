# = Dots::Installation
#
# These are various tasks that DOTS uses to install itself onto each
# machine. While most RubyGems are served from its directory in
# GEM_HOME, DOTS is primarily run from the user's home directory,
# since a user typically makes all kinds of shell configuration
# enhancements after installing.
module Dots
  module Installation
    include Thor::Actions

    # The Git remote we'll be pulling from. Set this in your +~/.zshenv+
    # to use a different fork of the project.
    REMOTE = ENV['DOTS_REMOTE']

    # Attempts to update DOTS, but fails if changes are detected
    # in the repo beforehand.
    #
    # The +git ls-files -m+ command will return no results when there
    # are no modified files in the repo. This method blocks DOTS from
    # installing itself overtop of your committed changes, as well as
    # saves the user from an ugly Git error...
    def update_the_framework
      if repo_is_clean?
        pull_from_origin and run 'reload'
      else
        say "You have uncommitted changes in ~/.dots. Please resolve them before updating."
      end
    end

    def copy_to_home_directory
      system "mkdir -p #{Dots.home} cp -R #{Dots.root} #{Dots.home}"
    end

    # Fetches and rebases the same code stored in +Dots.root+ to
    # +~/.dots+. This essentially replays your own local changes on
    # top of the official updates to the framework. If you're using
    # a fork, you can set +DOTS_REMOTE+ to the remote's name in
    # origin (this will default to your Github username, by the way).
    def pull_latest_changes
      system "cd #{Dots.home} && #{git_pull}"
    end

  private
    def repo_is_clean?
      `cd #{Dots.home} && git ls-files -m` == ""
    end

    def git_pull
      "git pull --rebase #{REMOTE} #{Dots::VERSION}"
    end
  end
end
