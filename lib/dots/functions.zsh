# = Functions
#
# New commands that were a bit complicated for simple aliases, or otherwise didn't
# work in the alias world. All kinds of functionality here.

# Upgrade and compile the entire ZSH project. This will recompile the shell.
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

# Upgrade and reload the DOTS framework from our Git repository.
function upgrade_dots() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/upgrade.sh
}

# Reload the framework after a change to the config file (or one of the plugins).
function reload_dots() {
  source $HOME/.zshrc
  rvm reload
  if [[ -f .rvmrc ]]; then
    source .rvmrc
  fi
  echo "DOTS reloaded!"
}

# Navigate to the directory the framework is stored in, and open it up in your text editor of choice.
function configure_dots() {
  cd $DOTS
  $EDITOR $DOTS
}

# Installs the "OSX For Hackers" shellscript, which plays with some of the OS X defaults to give you
# a faster and more enjoyable experience, albeit with a little less minimalism going on.
#
# WARNING: THIS WILL AFFECT YOUR OSX ENVIRONMENT. PLEASE READ THE FOLLOWING URL BEFORE CONTINUING:
# => https://github.com/mathiasbynens/dotfiles/blob/master/.osx
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
