# = Aliases
#
# General purpose, time-saving aliases for everyday use.

# Access the superuser for a single command.
alias _='sudo'

# Show command history.
alias history='fc -l 1'

# Use grep with ack.
alias afind='ack-grep -il'

# Reload DOTS after a change.
alias reload="source $HOME/.zshenv; source $HOME/.zshrc"
alias refresh="reload && clear"

# Reload TextMate bundles.
alias tmbundle="osascript -e 'tell app \"TextMate\" to reload bundles'"

# Find all ._* files in the directory and remove them.
alias rmbs="find . -type f -name '._*' -exec rm {} + && echo \"Removed all ._ files\""

# Make `ed` easier to use.
alias ed='ed -p "ed> "'

# Dotfiles persistence
alias persist='dots persist'
alias forget='dots forget'

# File viewing and editing
alias v=$PAGER

# Terminal support
alias c='clear'
alias ti='set_title'
alias o='open .'

# Fix Knife
alias k='nocorrect bundle exec knife'

# Deployment shorthand
alias d='nocorrect deploy'
alias ds='d to_stage'
alias dp='d to_production'

# Ripple
alias canary='open /Applications/Google\ Chrome\ Canary.app --args -disable-web-security'
