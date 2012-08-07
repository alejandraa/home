# Load the plugin architecture
source "$ZSH/vendor/antigen.zsh"

# Set up the plugin architecture
antigen-lib

# Load plugins
antigen-bundle tubbo/dots lib/plugins/aws
antigen-bundle tubbo/dots lib/plugins/bundler
antigen-bundle cap
antigen-bundle tubbo/dots lib/plugins/git
antigen-bundle tubbo/dots lib/plugins/git-flow
antigen-bundle tubbo/dots lib/plugins/knife
antigen-bundle tubbo/dots lib/plugins/macvim
antigen-bundle tubbo/dots lib/plugins/osx
antigen-bundle tubbo/dots lib/plugins/rails3
antigen-bundle tubbo/dots lib/plugins/ruby
antigen-bundle zsh-users/zsh-syntax-highlighting
