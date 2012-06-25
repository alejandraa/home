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

# Dotfiles persistence
alias persist='dots persist'
alias forget='dots forget'

# Reference
alias exit_code='cat /usr/include/sysexits.h | grep $1'

# Locations
elocal=$HOME/Code/elocal
alias elocal='nocorrect elocal'

kitchen=$HOME/Code/elocal/chef_scripts
alias kitchen='nocorrect kitchen'
alias chef_scripts='nocorrect kitchen'

blog=$HOME/Code/blog
alias blog='nocorrect blog'

diaspora=$HOME/Code/diaspora
alias diaspora='nocorrect diaspora'

affiliates=$HOME/Code/affiliates
alias affiliates='nocorrect affiliates'
