#!/bin/zsh
#
# A more basic version of the shell for non-interactive sessions.

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
precmd() {
    vcs_info
}

PROMPT="♬  "
PROMPT2="${vcs_info_message[0]}"

# added by travis gem
[ -f /Users/tscott/.travis/travis.sh ] && source /Users/tscott/.travis/travis.sh
