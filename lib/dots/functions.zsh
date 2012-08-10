# = Functions
#
# New commands that were a bit complicated for simple aliases, or otherwise didn't
# work in the alias world. All kinds of functionality here.

# Installs the "OSX For Hackers" shellscript, which plays with some of the OS X defaults to give you
# a faster and more enjoyable experience, albeit with a little less minimalism going on.
#
# WARNING: THIS WILL AFFECT YOUR OSX ENVIRONMENT. PLEASE READ THE FOLLOWING URL BEFORE CONTINUING:
# => https://github.com/mathiasbynens/dotfiles/blob/master/.osx
function osx_for_hackers() {
  source $DOTS/tools/osx.zsh
}

# Search the process list for a specific expression using grep.
function proc() {
  ps -A | grep $1
}

# Loads the README.md file into mvim as well as the current directory, as defined by the
# functionality of the macvim_drawer plugin. Requires macvim_drawer to be installed, regular MacVim
# will break with this function.
function e() {
  if [[ -f "./README.md" ]]; then
    mvim README.md
  elif [[ -f "./README.rdoc" ]]; then
    mvim README.rdoc
  else
    mvim
  fi
}

# Set the title of the iTerm window.
function set_title() {
  print -Pn "\033];$1\007";
}

# Find out what an exit code means.
function exit_code() {
  cat /usr/include/sysexits.h | grep "$1"
}
