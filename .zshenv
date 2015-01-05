#!zsh
#
# Set up configuration variables. These are useful even in
# non-interactive shells, so they should be placed in this file.

# The default Ruby version of this environment.
export DEFAULT_RUBY_VERSION='2.1.5'

# This will remain the promptstring if nothing overrides it.
export PROMPT='♬  '

# Editor settings
export EDITOR='vim'
export PAGER='less -r'

# Force 256 color terminals
TERM=screen-256color

# Text editing and paging
EDITOR='vim'
PAGER='less -R'

# Don't set iTerm/Terminal's title automatically.
DISABLE_AUTO_TITLE="true"

# Display red dots when ZSH is hanging.
COMPLETION_WAITING_DOTS="true"

# Colorize Grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
