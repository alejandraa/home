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

# Fix ssh-agent in Tmux
source $HOME/.dots/vendor/ssh-find-agent/ssh-find-agent.zsh