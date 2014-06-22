# System administration
alias _='sudo'
alias history='fc -l 1'
alias afind='ack-grep -il'

# Reload the DOTS framework and clear the screen.
alias refresh="reload && clear"
alias rmbs="rhombus"
alias ed='ed -p "ed> "'

# Dotfiles persistence
alias persist='dots persist'
alias pst='persist'
alias forget='dots forget'
alias fgt='forget'

# File viewing and editing
alias v=$PAGER
alias e='editor'
alias se='sudo vim' # for now..

# Terminal support
alias c='clear'
alias ti='set_title'
alias o='open_file_or_directory'
alias p='echo'

# iOS development
alias ripple='canary'

# Application deployment
alias dp='bundle exec rain on production'
alias ds='bundle exec rain on stage'

# Language REPLs
alias rb='ruby'
alias py='python'
alias js='node'
alias json='jsonlint'

# Kill the first Ruby process.
alias kill_first_ruby_process="kill -9 `ps -A | grep ruby | awk '{ print $1 }' | head -n 1`"
alias krp='kill_first_ruby_process'

alias fs='foreman start'
alias reload='dots update'

# Kill it with fire
alias k9='kill -9'

# Sane defaults for the `patch` command, reverts a given diff.
alias revert='patch -R -p1'

# Set up Autoenv for this directory.
alias cfg='source .env'

# IRC
alias irc=weechat

# Use tmux with iTerm2 integration
alias tm='tmux -CC'

# Generate CTags for all dependencies and code in the $PWD
alias ct='ctags -R . 2> /dev/null &'

# Use `hub` as a wrapper over Git
alias git='hub'

rk() {
  cat $HOME/.ssh/known_hosts | sed "$1 d" > $HOME/.ssh/known_hosts
}

alias repo="ssh git@git.teve.inc 'git init --bare $1.git'"

# Run a single test.
alias rtest="rake test:units TEST=$1"

# Make autoenv work
alias sha1sum=shasum
