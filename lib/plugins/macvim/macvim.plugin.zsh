# Quick alias to edit a directory with MacVim. Requires macvim-drawer.
e() {
  if [[ -f "$PWD/README.md" ]] ; then
    mvim README.md
  elif [[ -f "$PWD/README.rdoc" ]] ; then
    mvim README.rdoc
  fi
}
