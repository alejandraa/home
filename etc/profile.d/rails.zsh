#!zsh
#
# Helpful Rails aliases

_rails() {
  if [[ -e $PWD/script/rails ]]; then
    ./script/rails $*
  else
    rails $*
  fi
}

_test() {
  if [[ -e $PWD/spec ]]; then
    rspec $*
  else
    rake test $*
  fi
}

alias rg='_rails generate'
alias rs='_rails server'
alias rdb='_rails db'
alias rc='_rails console'
alias rt='_test'
alias rdm='rake db:migrate'
alias rtu='_test test:units'
alias rtf='_test test:functionals'
alias rti='_test test:integration'
