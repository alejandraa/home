#!/zsh
#
# Auto-completion

fpath=(/usr/local/share/zsh-completions /usr/local/etc/bash_completion.d $fpath)

## The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle :compinstall filename "$HOME/etc/profile.d/autocomplete.zsh"

autoload -Uz compinit
compinit

## End of lines added by compinstall
