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
alias forget='dots forget'

# File viewing and editing
alias v=$PAGER
alias e='editor'

# Terminal support
alias c='clear'
alias ti='set_title'
alias o='open_file_or_directory'

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

# Kill the first Ruby process.
alias kill_first_ruby_process="kill -9 `ps -A | grep ruby | awk '{ print $1 }' | head -n 1`"
alias krp='kill_first_ruby_process'

alias fs='foreman start'
alias reload='reload_dots'
