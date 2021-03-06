#!zsh
#
# Set up configuration variables. These are useful even in
# non-interactive shells, so they should be placed in this file.

# The default Ruby version of this environment.
export DEFAULT_RUBY_VERSION='2.1.5'

# This will remain the promptstring if nothing overrides it.
export PROMPT='♬  '

# Text editing and paging
export EDITOR='vim'
export PAGER='less'

# Force 256 color terminals
export TERM=screen-256color

# Don't set iTerm/Terminal's title automatically.
export DISABLE_AUTO_TITLE="true"

# Display red dots when ZSH is hanging.
export COMPLETION_WAITING_DOTS="true"

# Colorize Grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

# Use 1password to manage secret keys
export ONEPASSWORD_KEYCHAIN=$HOME/Documents/1password.agilekeychain

if [[ -f $HOME/.zshsecret ]]; then
  source $HOME/.zshsecret
fi
