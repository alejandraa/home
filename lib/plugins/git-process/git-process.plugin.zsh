#!zsh
#
# git-process plugin
# -------------------
#
# Shortcuts and other useful sugar that goes well with git-process.


# Create a new feature branch based on the integration branch.
alias gf='git new-fb'

# Gets the latest changes that have happened on the integration branch, then pushes your changes to a "private" branch on the server.
alias gy='git sync --rebase'

# Creates a Pull Request for the current branch.
alias gq='git pull-request'

# Rebase against the integration branch, then push to it.
alias gu='git to-master'
