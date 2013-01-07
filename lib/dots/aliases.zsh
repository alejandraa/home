# System administration
alias _='sudo'
alias history='fc -l 1'
alias afind='ack-grep -il'

# Reload the DOTS framework and clear the screen.
alias refresh="reload && clear"
alias rmbs="rhombus"
alias ed='ed -p "ed> "'

# Dotfiles persistence
alias persist='dots persist'
alias pst='persist'
alias forget='dots forget'
alias fgt='forget'

# File viewing and editing
alias v=$PAGER
alias e='editor'

# Terminal support
alias c='clear'
alias ti='set_title'
alias o='open_file_or_directory'
alias p='echo'

# iOS development
alias ripple='canary'

# Application deployment
alias dp='bundle exec rain on production'
alias ds='bundle exec rain on stage'

# Language REPLs
alias rb='ruby'
alias py='python'
alias js='node'
alias json='jsonlint'

# Running Ruby tests
alias t='run_single_test'
alias rts='rtest_rake'

# Kill the first Ruby process.
alias kill_first_ruby_process="kill -9 `ps -A | grep ruby | awk '{ print $1 }' | head -n 1`"
alias krp='kill_first_ruby_process'

alias fs='foreman start'
alias reload='dots update'

#alias guard='nocorrect guard --no-bundler-warning'
alias rspec='nocorrect rspec'
alias rain='nocorrect rain'

# Kill it with fire
alias k9='kill -9'

# Sane defaults for the `patch` command, reverts a given diff.
alias revert='patch -R -p1'

# Set up Autoenv for this directory.
alias cfg='source .env'

# Globalize some necessary RubyGems
global_gems=(dots pv)
for cmd in $global_gems; do
  eval "function local_$cmd () { bundle exec $cmd \$@ }"
  eval "function global_$cmd () { globalize $cmd \$@}"
  alias $cmd=global_$cmd
  alias _$cmd=local_$cmd

  if which _$cmd > /dev/null 2>&1; then
    compdef _$cmd global_$cmd=$cmd
  fi
done
