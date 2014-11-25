# Change package-installed Ruby on demand
source /usr/local/opt/chruby/share/chruby/chruby.sh
RUBIES=(
  $HOME/.rubies/*
)

# Enable auto-switching of Ruby on `cd`.
source /usr/local/opt/chruby/share/chruby/auto.sh

# So we can actually compile Ruby 1.8
export CPPFLAGS=-I/opt/X11/include

# Make Ruby even faster
#RUBY_HEAP_MIN_SLOTS=1000000
#RUBY_HEAP_SLOTS_INCREMENT=1000000
#RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
#RUBY_GC_MALLOC_LIMIT=1000000000
#RUBY_HEAP_FREE_MIN=500000

alias bn='bundle install'
alias bu='bundle update'
alias be='bundle exec'
alias bs='bundle show'
alias ct='ctags -R .'
alias bi='bn && ct'
