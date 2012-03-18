# Rails 3 aliases, backwards-compatible with Rails 2.

function _rails_command () {
  if [ -e "script/server" ]; then
    ruby script/$@
  else
    ruby script/rails $@
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

# Rake tasks
alias rdm='rake db:migrate'
alias rdr='rake db:rollback'
alias rdbm='rake db:migrate db:test:clone'
alias rt='rake test'
alias rtu='rake test:units'
alias rtf='rake test:functionals'
alias rti='rake test:integrations'
alias rts='rtest' # defined in ruby.plugin.zsh

# Common 3rd-party processes
alias redis="redis-server /usr/local/etc/redis.conf"

# Logging
alias rld='tail -f log/development.log'
alias rlt='tail -f log/test.log'
alias rls='tail -f log/stage.log'
alias rlu='tail -f log/uat.log'
alias rlp='tail -f log/production.log'

# Server stuff
alias u='unicorn -p 3000'
