function zsh_stats() {
  echo "Top commands used:"
  history | awk '{print $2}' | sort | uniq -c | sort -rn | head
}

function uninstall_dots() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/uninstall.sh
}

function upgrade_dots() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/upgrade.sh
}

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

function take() {
  mkdir -p $1
  cd $1
}

function proc() {
  ps -A | grep $1
}
