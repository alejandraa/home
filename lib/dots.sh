# Check for updates on initial load...
if [ "$DISABLE_AUTO_UPDATE" != "true" ]
then
  /usr/bin/env ZSH=$ZSH zsh $ZSH/tools/check_for_upgrade.sh
fi

##
#
# Initializes DOTS
#
##

# add a function path
fpath=($ZSH/functions $ZSH/completions $fpath)

# Load all of the config files in ~/.dots that end in .zsh
# TIP: Add files you don't want in git to .gitignore
for config_file ($ZSH/lib/dots/*.zsh) source $config_file

# Set ZSH_CUSTOM to the path where your custom config files
# and plugins exists, or else we will use the default custom/
if [[ -z "$ZSH_CUSTOM" ]]; then
    ZSH_CUSTOM="$ZSH/lib/local"
fi

# A function for seeing if a plugin is available
is_plugin() {
  local base_dir=$1
  local name=$2
  test -f $base_dir/lib/plugins/$name/$name.plugin.zsh \
    || test -f $base_dir/lib/plugins/$name/_$name
}

# Add all defined plugins to fpath. This must be done
# before running compinit.
#for plugin ($plugins); do
  #if is_plugin $ZSH_CUSTOM $plugin; then
    #fpath=($ZSH_CUSTOM/lib/plugins/$plugin $fpath)
  #elif is_plugin $ZSH $plugin; then
    #fpath=($ZSH/lib/plugins/$plugin $fpath)
  #fi
#done

# Load and run compinit
autoload -U compinit
compinit -i

# Load all of the plugins that were defined in ~/.zshrc
#for plugin ($plugins); do
  #if [ -f $ZSH_CUSTOM/lib/plugins/$plugin/$plugin.plugin.zsh ]; then
    #source $ZSH_CUSTOM/lib/plugins/$plugin/$plugin.plugin.zsh
  #elif [ -f $ZSH/lib/plugins/$plugin/$plugin.plugin.zsh ]; then
    #source $ZSH/lib/plugins/$plugin/$plugin.plugin.zsh
  #fi
#done

# Load the Antigen plugin manager
source "$ZSH/lib/dots/antigen.zsh"

# Load all of your custom configurations from custom/
#for config_file ($ZSH_CUSTOM/*.zsh) source $config_file

# Load the theme
source "$ZSH/lib/dots/prompt.zsh"
