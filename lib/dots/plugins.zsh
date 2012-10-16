# Load the plugin architecture
source "$ZSH/vendor/antigen/antigen.zsh"

# Set up the plugin architecture
antigen-lib

# Bare Oh My ZSH plugins
antigen-bundle cap

# Local modifications to OMZ plugins
antigen-bundle $HOME/.dots/lib/plugins/aws
antigen-bundle $HOME/.dots/lib/plugins/bundler
antigen-bundle $HOME/.dots/lib/plugins/git
antigen-bundle $HOME/.dots/lib/plugins/git-process
antigen-bundle $HOME/.dots/lib/plugins/knife
antigen-bundle $HOME/.dots/lib/plugins/macvim
antigen-bundle $HOME/.dots/lib/plugins/osx
antigen-bundle $HOME/.dots/lib/plugins/rails3
antigen-bundle $HOME/.dots/lib/plugins/ruby

# From alternative sources
antigen-bundle zsh-users/zsh-syntax-highlighting
antigen-bundle kennethreitz/autoenv

# Apply loaded plugins to the environment
antigen-apply
