#!zsh
#
# Helpful Rails aliases

alias rg='bin/rails generate'
alias rdb='bin/rails db'
alias rc='bin/rails console'
alias rt='bin/rake test'
alias ts='bin/rspec'
alias rdm='bin/rake db:migrate'

# pow
alias pw='chruby-exec system -- powify'
alias powder=pw
alias rs='powify restart'
alias rl='powify logs'

# Generate a new Rails app with a pre-configured version of Ruby
alias rn='chruby-exec 2.2.0 -- rails new'
