# TODO: Make this compatible with rvm.
#       Run sudo gem on the system ruby, not the active ruby.
alias sgem='sudo gem'

# Find ruby file
alias rfind='find . -name "*.rb" | xargs grep -n'

# Run a ruby script
alias rb='ruby $1'

# Run a ruby test
# function rb_test() {
#   if ($1 == '') then
#     echo "fail: you must specify a script to test"
#   else
#     if ($2 == '') then
#       echo "yus"
#       exec "bundle exec ruby -Itest $1"
#     else
#       exec "bundle exec ruby -Itest $1 -n $2"
#     fi
#   fi
# }
alias rb_test="bundle exec ruby -Itest $1"
alias rbt=rb_test
