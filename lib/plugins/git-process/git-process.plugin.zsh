#!zsh
#
# git-process plugin
# -------------------
#
# Shortcuts and other useful sugar that goes well with git-process.


# Create a new feature branch based on the integration branch.
alias gf='git new-fb'

# Gets the latest changes that have happened on the integration branch, then pushes your changes to a "private" branch on the server.
alias gsy='git sync'

# Creates a Pull Request for the current branch.
alias gpr='git pull-request'

# Rebase against the integration branch, then push to it.
alias gpm='git to-master'
