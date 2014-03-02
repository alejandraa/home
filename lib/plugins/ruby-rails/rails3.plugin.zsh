# Rails 3 aliases, backwards-compatible with Rails 2.

function _rails_command () {
  if [ -e 'vendor/gems/bin/zeus' ]; then
    zeus $@
  else
    # Rails 2.x
    if [ -e "script/server" ]; then
      ruby script/$@
    else
      # Rails 4.x
      if [ -e 'bin/rails' ]; then
        bin/rails $@
      # Rails 3.x
      else
        ruby script/rails $@
      fi
    fi
  fi
}

function _rake_task () {
  if [ -e 'vendor/gems/bin/zeus' ]; then
    zeus rake $@
  else
    if [ -e "bin/rake" ]; then
      rake $@
    else
      bundle exec rake $@
    fi
  fi
}


# View the Rails logger
RAILS_PAGER='less'
rl() {
  if [[ $RAILS_PAGER == "less" ]] ; then
    MODES="-R"
  else
    MODES="-f"
  fi

  if [[ $RAILS_ENV != "" ]] ; then
    $RAILS_PAGER $MODES log/$RAILS_ENV.log;
  elif [[ $1 != "" ]] ; then
    $RAILS_PAGER $MODES log/$1.log;
  else
    $RAILS_PAGER $MODES log/development.log;
  fi
}

# Rails commands
alias rc='_rails_command console'
alias rd='_rails_command destroy'
alias rdb='_rails_command dbconsole'
alias rg='_rails_command generate'
alias rp='_rails_command plugin'
alias ru='_rails_command runner'
alias rs='_rails_command server'
alias rsd='_rails_command server --debugger'
alias rsp='bundle exec foreman start' # Rails Server and Processes
alias rg='_rails_command generate'

# Rake tasks
alias rdm='rake db:migrate'
alias rdr='rake db:rollback'
alias rdbm='rake db:migrate db:test:prepare'
alias rt='rake test'
alias rtu='rake test:units'
alias rtf='rake test:functionals'
alias rti='rake test:integration'
alias rtj='rake test:javascripts'
alias rts='rtest' # defined in ruby.plugin.zsh
alias rr="rake routes | grep $1"
alias rra="rake routes"
alias rks="rake server" # for storing server command configuration inside Rake

# 3rd-party processes related to Rails
alias redis="redis-server /usr/local/etc/redis.conf"

# Run a singleton test
t() {
  bundle exec ruby -Itest $@
}
