# Load the plugin architecture
source "$ZSH/vendor/antigen/antigen.zsh"

# Set up the plugin architecture
antigen-lib

# Local plugins and OMZ overrides
antigen bundle tubbo/dots lib/plugins/bundler
antigen bundle tubbo/dots lib/plugins/git
antigen bundle tubbo/dots lib/plugins/knife
antigen bundle tubbo/dots lib/plugins/ruby-rails
antigen bundle tubbo/dots lib/plugins/bower
antigen bundle tubbo/dots lib/plugins/heroku
antigen bundle tubbo/dots lib/plugins/vim

# Plugins from alternative sources
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle kennethreitz/autoenv

# Plugins directly from OMZ
antigen use oh-my-zsh
antigen bundle osx
antigen bundle vi-mode
antigen bundle tmux

# Apply loaded plugins to the environment
antigen apply
