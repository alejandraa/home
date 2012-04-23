## Aliases

alias be="bundle exec"
alias bi="bundle install"
alias bl="bundle list"
alias bp="bundle package"
alias bu="bundle update"

# # Original commands in the OMZ version. Adding what we need, as we need it.
# #
# # annotate cap capify cucumber ey foreman guard heroku middleman
# # nanoc rackup rainbows rails rake rspec ruby shotgun spec spork
# # thin thor unicorn unicorn_rails
# #
# # based on https://github.com/gma/bundler-exec and OMZ's Bundler.plugin
# bundled_commands=(guard rake leader rails rake rspec thor)

# ## Functions

# _bundler-installed() {
#   which bundle > /dev/null 2>&1
# }

# _within-bundled-project() {
#   local check_dir=$PWD
#   while [ $check_dir != "/" ]; do
#     [ -f "$check_dir/Gemfile" ] && return
#     check_dir="$(dirname $check_dir)"
#   done
#   false
# }

# _run-with-bundler() {
#   if _bundler-installed && _within-bundled-project; then
#     bundle exec $@
#   else
#     $@
#   fi
# }

# ## Main program

# for cmd in $bundled_commands; do
#   eval "function bundled_$cmd () { _run-with-bundler $cmd \$@}"
#   alias $cmd=bundled_$cmd

#   if which _$cmd > /dev/null 2>&1; then
#         compdef _$cmd bundled_$cmd=$cmd
#   fi
# done
