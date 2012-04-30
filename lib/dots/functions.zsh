# Main gateway to the rest of the DOTS functionality
function dots() {
  DOTS_CMD=$1
  exec "${DOTS_CMD}_dots"
}

function remove_dots() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/uninstall.sh
}

# Blindly upgrade the framework from the
function upgrade_dots() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/upgrade.sh
}

# Reload the framework after a change to the config file (or one of the plugins)
function reload_dots() {
  source $HOME/.zshrc

  if [[ -f .rvmrc ]]; then
    source .rvmrc
  fi
}

# Navigate to the directory the framework is stored in, and open it up in your text editor.
function configure_dots() {
  cd $DOTS
  $EDITOR $DOTS
}

# Upgrade and compile the entire ZSH project.
function upgrade_zsh() {
  version="4.3.10" &&
  mkdir -p ~/.src &&
  cd ~/.src &&
  curl -O -L --create-dirs -C - http://downloads.sourceforge.net/project/zsh/zsh-dev/$version/zsh-$version.tar.bz2?use_mirror=vo &&
  tar jxf zsh-$version.tar.bz2* &&
  cd zsh-$version &&
  ./configure --prefix=/ &&
  make &&
  sudo make install
}

function configure_dots() {
  cd $ZSH
  subl .
}

function osx_for_hackers() {
  source $DOTS/tools/osx.zsh
}

# Create a new directory and `cd` into it in one go.
function take() {
  mkdir -p $1
  cd $1
}

# Search the process list for a specific expression using grep.
function proc() {
  ps -A | grep $1
}

# Shows the top commands used by you in the total ZSH history.
function zsh_stats() {
  echo "Top commands used:"
  history | awk '{print $2}' | sort | uniq -c | sort -rn | head
}
