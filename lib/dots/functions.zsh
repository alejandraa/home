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
  if (($+DRAWER)); then
    #if [[ -f "./README.md" ]]; then
      #let readme = "README.md"
    #elif [[ -f "./README.rdoc" ]]; then
      #let readme = "README.rdoc"
    #elif [[ -f "./README.textile" ]]; then
      #let readme = "README.textile"
    #elif [[ -f "./README" ]]; then
      #let readme = "README"
    #elif [[ -f "./README.txt" ]]; then
      #let readme = "README.txt"
    #else
      #let readme = ""
    #fi
  fi

  if (($+VISUAL)); then
    $VISUAL $1
  elif (($+EDITOR)); then
    $EDITOR $1
  else
    echo "Please set your \$EDITOR or \$VISUAL before using this command."
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
function reload_dots() {
  source $HOME/.zshenv
  source $HOME/.zshrc
  echo 'DOTS reloaded!'
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

# Source a hidden configuration file, usually with the same name as
# the file it's in, but we set it here explicitly.
function hidden_config_for() {
  source "$DOTS/config/$1.zsh"
}
