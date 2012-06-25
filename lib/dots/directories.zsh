# = Directories
#
# Aliases and options for dealing with the various directories we have on our system.

# Changing/making/removing directory settings
setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups

# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Basic directory operations
alias ...='cd ../..'
alias -- -='cd -'

# Traverse up the tree easily
alias ..='cd ..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd/='cd /'

# What is this for exactly? Leftover from OMZ.
alias 1='cd -'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'

# List direcory contents
alias lsa='ls -lah'
alias l='ls -la'
alias ll='ls -l'
alias sl=ls # often screw this up

# Oh noez we hijackin cd!!1
cd () {
  if   [[ "x$*" == "x..." ]]; then
    cd ../..
  elif [[ "x$*" == "x...." ]]; then
    cd ../../..
  elif [[ "x$*" == "x....." ]]; then
    cd ../../..
  elif [[ "x$*" == "x......" ]]; then
    cd ../../../..
  else
    builtin cd "$@"
  fi
}

# Create, remove and view directories with these fine aliases
alias md='mkdir -p'
alias rd=rmdir
alias d='dirs -v'

# Create a directory and `cd` to it
function mcd() { 
  mkdir -p "$1" && cd "$1"; 
}

# eLocal web application
elocal=$HOME/Code/elocal
alias elocal='nocorrect elocal'

# eLocal Chef server(s) configuration
kitchen=$HOME/Code/elocal/chef_scripts
alias kitchen='nocorrect kitchen'
alias chef_scripts='nocorrect kitchen'

# eLocal Affiliates API
affiliates=$HOME/Code/affiliates
alias affiliates='nocorrect affiliates'

# psychedeli.ca
blog=$HOME/Code/blog
alias blog='nocorrect blog'

# Diaspora
diaspora=$HOME/Code/diaspora
alias diaspora='nocorrect diaspora'

# Personal Chef configuration
skynet=$HOME/Code/skynet
alias skynet='nocorrect skynet'
