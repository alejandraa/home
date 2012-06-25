# = Colors
#
# Setup for colors so you can view and use them easily within the prompt.

# ls colors
autoload colors; colors;
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Find the option for using colors in ls, depending on the version: Linux or BSD
if [ "$DISABLE_LS_COLORS" != "true" ] ; then
  ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
fi

# Color options
#setopt no_beep
setopt auto_cd
setopt multios
setopt cdablevarS

# TODO: Document this.
if [[ x$WINDOW != x ]]
then
    SCREEN_NO="%B$WINDOW%b "
else
    SCREEN_NO=""
fi

# Setup the prompt with pretty colors.
setopt prompt_subst

