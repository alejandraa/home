function zsh_stats() {
  history | awk '{print $2}' | sort | uniq -c | sort -rn | head
}

function uninstall_oh_my_zsh() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/uninstall.sh
}

function upgrade_oh_my_zsh() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/upgrade.sh
}

function configure_oh_my_zsh() {
  /usr/bin/env ZSH=$ZSH /bin/sh subl $ZSH
  /usr/bin/env ZSH=$ZSH /bin/sh cd $ZSH
}

function take() {
  mkdir -p $1
  cd $1
}

