#!zsh
#
# Commands exclusive to my work life.

# Restart the demo app server from anywhere.
alias rsd='pw restart demo'

# Stop running Spring.
alias ss='spring stop'

# Create a new WebLinc app implementation using the app template
# generator.
weblinc-app() {
  export GEMS_PATH='~/Code'
  /usr/local/bin/chruby 2.2.2;
  /usr/local/bin/chruby-exec 2.2.2 -- rails new $1 \
    --template=~/Code/weblinc/docs/guides/source/app_template.rb \
    --skip-active-record \
    --no-rc
}

# Create a new WebLinc plugin using the plugin template generator.
weblinc-plugin() {
  export GEMS_PATH='~/Code'
  /usr/local/bin/chruby 2.2.2;
  /usr/local/bin/chruby-exec 2.2.2 -- rails plugin new $1 \
    --template=~/Code/weblinc/docs/guides/source/plugin_template.rb \
    --skip-active-record \
    --no-rc
}

# Easy alias to any weblinc function.
weblinc() {
  weblinc-$1 $2
}
