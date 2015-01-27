#!/bin/zsh
#
# Load the Homer framework whenever we enter an interactive shell.

source "/usr/local/share/homer.zsh"

# added by travis gem
[ -f /Users/necromancer/.travis/travis.sh ] && source /Users/necromancer/.travis/travis.sh
