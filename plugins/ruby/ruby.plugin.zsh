# TODO: Make this compatible with rvm.
#       Run sudo gem on the system ruby, not the active ruby.
alias sgem='sudo gem'

# Find ruby file
alias rfind='find . -name "*.rb" | xargs grep -n'

# Run a ruby script
alias rb='ruby'

# Run a ruby test
alias rb_test="bundle exec ruby -Itest $1 -n $2"
