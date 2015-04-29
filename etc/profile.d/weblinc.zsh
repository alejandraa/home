#!zsh

alias weblinc="chruby-exec 2.2.0 -- GEMS_PATH='~/Code' /usr/bin/rails new $1 --template=~/Code/weblinc/docs/guides/source/app_template.rb --skip-active-record --no-rc"
