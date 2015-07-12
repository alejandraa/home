#!zsh

alias weblinc="chruby-exec 2.2.2 -- GEMS_PATH='~/Code' rails new $1 --template=~/Code/weblinc/docs/guides/source/app_template.rb --skip-active-record --no-rc"
alias rsd='pw restart demo'
alias ss='spring stop'

export BUNDLE_GEMS__WEBLINC__COM=$(1pass 'WebLinc: Gem Server')
