# Initialize chruby
source /usr/local/opt/chruby/share/chruby/chruby.sh

# Auto-switch Ruby based on .ruby-version
source /usr/local/opt/chruby/share/chruby/auto.sh

# Migrate from rbenv if necessary
if [[ -f "~/.rbenv" ]] ; then
  export RUBIES=(~/.rbenv/versions/*)
fi
