EDITOR='vim'
PAGER='less'

editor() {
  $EDITOR $*
}
alias e=editor

pager() {
  $PAGER $*
}
alias v=pager

alias p=echo

alias c=clear
