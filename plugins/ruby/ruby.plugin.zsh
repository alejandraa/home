# TODO: Make this compatible with rvm.
#       Run sudo gem on the system ruby, not the active ruby.
alias sgem='sudo gem'

# Find ruby file
alias rfind='find . -name "*.rb" | xargs grep -n'

## @robdimarco <http://innovationontherun.com> contributed the following code: ##

# Run a single Ruby test using Rake. This will also migrate the database and
# generally prepare the environment for testing, and is useful for tests
# which require a specific database setup to function.
_rbtest_with_rake() {
  if [ -f $1 ]; then
    case `echo $1 | cut -f 2 -d '/'` in
      unit)
        task='test:units'
        ;;
      functional)
        task='test:functionals'
        ;;
      integration)
        task='test:integration'
        ;;
      *)
        task='test'
        ;;
    esac
    bundle exec rake $task TEST1
  else
    bundle exec rake test
  fi
}
eval "function rtest_rake () { _rbtest_with_rake \$@}"

# Run a single Ruby test using `ruby -Itest`. This is the built-in testing
# framework that ships with Ruby 1.9 and is useful for running quick tests
# that don't require database connectivity or awareness of the Rails app.
_rbtest_without_rake() {
  if [ -f $1 ]; then
    bundle exec ruby -Itest $@;
  else
    echo "Please specify a file(s) to test"
  fi;
}
eval "function rtest_bare () {_rbtest_without_rake \$@}"

# Disable autocorrect
alias rtest='nocorrect rtest_bare'
alias rtest_rake='nocorrect rtest_rake'

# Shorthand aliases
alias t='rtest'
alias rts='rtest_rake'
