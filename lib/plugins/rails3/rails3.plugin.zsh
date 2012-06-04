# Rails 3 aliases, backwards-compatible with Rails 2.

function _rails_command () {
  if [ -e "script/server" ]; then
    ruby script/$@
  else
    ruby script/rails $@
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

# Control Thin, our Rails application server
thinctl() {
  local cmd=$2
  local port=$3

  if [[ $cmd == "start" ]] ; then
    if [[ $port != "" ]] ; then
      local port='3000'
      echo "No port passed, starting Thin on port 3000..."
    fi
    thin -p $port -d $cmd
    echo "Rails app is up on http://localhost:${port}."
  elif [[ $cmd == 'stop' ]] ; then
    thin $cmd
    echo "Rails app server has stopped."
  else
    thin $cmd
    echo "Rails server has been ${cmd}ed."
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

# Rake tasks
alias rdm='rake db:migrate'
alias rdr='rake db:rollback'
alias rdbm='rake db:migrate db:test:clone'
alias rt='rake test'
alias rtu='rake test:units'
alias rtf='rake test:functionals'
alias rti='rake test:integrations'
alias rts='rtest' # defined in ruby.plugin.zsh
alias rr="rake routes | grep $1"
alias rra="rake routes"

# 3rd-party processes related to Rails
alias redis="redis-server /usr/local/etc/redis.conf"
