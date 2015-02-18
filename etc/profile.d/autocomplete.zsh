#!/zsh
#
# Auto-completion

fpath=(/usr/local/share/zsh/site-functions $fpath)

## The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle :compinstall filename "$HOME/etc/profile.d/autocomplete.zsh"

autoload -Uz compinit
compinit

## End of lines added by compinstall
