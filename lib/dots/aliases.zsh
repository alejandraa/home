# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Basic directory operations
alias ...='cd ../..'
alias -- -='cd -'

# Super user
alias _='sudo'

#alias g='grep -in'

# Show history
alias history='fc -l 1'

# List direcory contents
alias lsa='ls -lah'
alias l='ls -la'
alias ll='ls -l'
alias sl=ls # often screw this up

alias afind='ack-grep -il'

# Reload Oh My ZSH! after a change
alias reload="source $HOME/.zshrc"
alias refresh="reload && clear"

# General purpose time savers
alias redis="redis-server /usr/local/etc/redis.conf"
alias tmbundle="osascript -e 'tell app \"TextMate\" to reload bundles'"
alias c="clear"
alias rmbs="find . -type f -name '._*' -exec rm {} + && echo \"Removed all ._ files\""
alias reload='reload_dots'
alias configure='configure_dots'
alias e=$EDITOR
alias ed='ed -p "ed> "'
