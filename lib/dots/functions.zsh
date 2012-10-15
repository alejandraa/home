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

# Load the README.md file into mvim as well as the current 
# directory, as defined by the functionality of the 
# macvim_drawer plugin. Requires macvim_drawer to be installed, 
# regular MacVim will break with this function.
function editor() {
  if [[ -f "./README.md" ]]; then
    mvim README.md
  elif [[ -f "./README.rdoc" ]]; then
    mvim README.rdoc
  elif [[ -f "./README.textile" ]]; then
    mvim README.textile
  elif [[ -f "./README" ]]; then
    mvim README
  elif [[ -f "./README.txt" ]]; then
    mvim README.txt
  else
    mvim
  fi
}

# Open the given file, or a directory if no input is given.
function open_file_or_directory() {
  if [[ $1 != "" ]]; then
    open $1
  else
    open .
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

# Run a line of AppleScript to reload the bundles in TextMate.
function tmbundle() {
  osascript -e 'tell app \"TextMate\" to reload bundles'
}

# Reload DOTS after a change.
function reload() {
  reload_dots && reload_rvm
}

function reload_dots() {
  dots update > /dev/null
  source $HOME/.zshenv
  source $HOME/.zshrc
  echo 'DOTS reloaded!'
}

function reload_rvm() {
  rvm reload
  if [[ -f ".rvmrc" ]]; then 
    source .rvmrc
  fi
}

# Open Google Chrome Canary and disable web
# security. For iOS developers using Ripple.
function canary() {
  open /Applications/Google\ Chrome\ Canary.app --args -disable-web-security
}

# Remove TextMate junk from the directory.
function rhombus() {
  find . -type f -name '._*' -exec rm {} +
  echo "Removed all ._ files"
}
