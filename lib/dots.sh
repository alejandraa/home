# add a function path
fpath=($ZSH/lib/dots/functions $ZSH/lib/dots/completion $fpath)

# static binary path
export DOTS_PATH=$HOME/.dots/bin

# Load and run compinit
autoload -U compinit
compinit -i

# Load DOTS source code
source "$ZSH/lib/dots/functions.zsh"
source "$ZSH/lib/dots/aliases.zsh"
source "$ZSH/lib/dots/plugins.zsh"

# Add DOTS binaries to the $PATH
PATH=$DOTS_PATH:$PATH
