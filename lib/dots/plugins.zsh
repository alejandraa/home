# Load the plugin architecture
source "$ZSH/vendor/antigen/antigen.zsh"

# Set up the plugin architecture
antigen-lib

# Local plugins and OMZ overrides
antigen-bundle $HOME/.dots lib/plugins/bundler
antigen-bundle $HOME/.dots lib/plugins/git
antigen-bundle $HOME/.dots lib/plugins/knife
antigen-bundle $HOME/.dots lib/plugins/ruby-rails
antigen-bundle $HOME/.dots lib/plugins/bower
antigen-bundle $HOME/.dots lib/plugins/heroku
antigen-bundle $HOME/.dots lib/plugins/vim
antigen-bundle $HOME/.dots lib/plugins/tmuxinator

# Plugins from alternative sources
antigen-bundle zsh-users/zsh-syntax-highlighting
antigen-bundle kennethreitz/autoenv

# Plugins directly from OMZ
antigen-use oh-my-zsh osx
antigen-use oh-my-zsh vi-mode
antigen-use oh-my-zsh tmux

# Apply loaded plugins to the environment
antigen-apply
