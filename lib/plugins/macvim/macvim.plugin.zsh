# Quick alias to edit a directory with MacVim. Requires macvim_drawer
# from Homebrew: https://gist.github.com/3076384
e() {
  if [[ -f "$PWD/README.md" ]] ; then
    mvim README.md
  elif [[ -f "$PWD/README.rdoc" ]] ; then
    mvim README.rdoc
  elif [[ -f "$PWD/README.textile" ]] ; then
    mvim README.textile
  else
    mvim .
  fi
}
