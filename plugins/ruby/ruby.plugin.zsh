# TODO: Make this compatible with rvm.
#       Run sudo gem on the system ruby, not the active ruby.
alias sgem='sudo gem'

# Find ruby file
alias rfind='find . -name "*.rb" | xargs grep -n'

# Run a ruby test with bare ruby or `bundle exec ruby`
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
eval "function rbtest () { _rbtest_with_rake \$@}"

_rbtest_without_rake() {
  if [ -f $1 ]; then
    bundle exec ruby -Itest $@;
  else
    echo "Please specify a file(s) to test"
  fi;
}
eval "function rbtest_exec(){_rbtest_without_rake \$@}"
