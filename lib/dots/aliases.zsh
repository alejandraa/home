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
alias reload="source $HOME/.zshrc"
alias refresh="reload && clear"

# Launch Redis.
alias redis="redis-server /usr/local/etc/redis.conf"

# Reload TextMate bundles.
alias tmbundle="osascript -e 'tell app \"TextMate\" to reload bundles'"

# Move all text out of view.
alias c="clear"

# Find all ._* files in the directory and remove them.
alias rmbs="find . -type f -name '._*' -exec rm {} + && echo \"Removed all ._ files\""

# Open ~/.dots in your text editor.
alias configure='configure_dots'

# Edit a file or directory with the text editor.
alias e=$EDITOR

# Use `ed` in a much more helpful manner.
alias ed='ed -p "ed> "'

# Dotfiles persistence
alias persist='dots persist'
alias forget='dots forget'

# Find out what an exit code means.
alias exit_code='cat /usr/include/sysexits.h | grep $1'
