#!/bin/zsh
#
# My prompt string, designed to look like Powerline.

# Begin loading vcs_info
autoload -Uz vcs_info

# Enable vcs_info for Git and Subversion
zstyle ':vcs_info:*' enable git svn

# Only show the branch name on the left.
zstyle ':vcs_info:git*' formats " %b"

# Render the actual prompt string entirely within the precmd.
precmd() {
  vcs_info

  if [ "$POWERLINE_DATE_FORMAT" = "" ]; then
    POWERLINE_DATE_FORMAT=%D{%Y-%m-%d}
  fi

  # █
  #
  POWERLINE_RIGHT_B="none"


  if [ "$POWERLINE_RIGHT_B" = "" ]; then
    POWERLINE_RIGHT_B=%D{%H:%M:%S}
  elif [ "$POWERLINE_RIGHT_B" = "none" ]; then
    POWERLINE_RIGHT_B=""
  fi

  if [ "$POWERLINE_RIGHT_A" = "mixed" ]; then
    POWERLINE_RIGHT_A=%(?."$POWERLINE_DATE_FORMAT".%F{red}✘ %?)
  elif [ "$POWERLINE_RIGHT_A" = "exit-status" ]; then
    POWERLINE_RIGHT_A=%(?.%F{green}✔ %?.%F{red}✘ %?)
  elif [ "$POWERLINE_RIGHT_A" = "date" ]; then
    POWERLINE_RIGHT_A="$POWERLINE_DATE_FORMAT"
  fi

  POWERLINE_HIDE_HOST_NAME="true"

  if [ "$POWERLINE_HIDE_USER_NAME" = "" ] && [ "$POWERLINE_HIDE_HOST_NAME" = "" ]; then
      POWERLINE_USER_NAME="%n@%M"
  elif [ "$POWERLINE_HIDE_USER_NAME" != "" ] && [ "$POWERLINE_HIDE_HOST_NAME" = "" ]; then
      POWERLINE_USER_NAME="@%M"
  elif [ "$POWERLINE_HIDE_USER_NAME" = "" ] && [ "$POWERLINE_HIDE_HOST_NAME" != "" ]; then
      POWERLINE_USER_NAME="%n"
  else
      POWERLINE_USER_NAME=""
  fi

  POWERLINE_CURRENT_PATH="%d"

  if [ "$POWERLINE_FULL_CURRENT_PATH" = "" ]; then
    POWERLINE_CURRENT_PATH="%1~"
  fi

  if [ "$POWERLINE_GIT_CLEAN" = "" ]; then
    POWERLINE_GIT_CLEAN="✔"
  fi

  if [ "$POWERLINE_GIT_DIRTY" = "" ]; then
    POWERLINE_GIT_DIRTY="✘"
  fi

  if [ "$POWERLINE_GIT_ADDED" = "" ]; then
    POWERLINE_GIT_ADDED="%F{green}✚%F{black}"
  fi

  if [ "$POWERLINE_GIT_MODIFIED" = "" ]; then
    POWERLINE_GIT_MODIFIED="%F{blue}✹%F{black}"
  fi

  if [ "$POWERLINE_GIT_DELETED" = "" ]; then
    POWERLINE_GIT_DELETED="%F{red}✖%F{black}"
  fi

  if [ "$POWERLINE_GIT_UNTRACKED" = "" ]; then
    POWERLINE_GIT_UNTRACKED="%F{yellow}✭%F{black}"
  fi

  if [ "$POWERLINE_GIT_RENAMED" = "" ]; then
    POWERLINE_GIT_RENAMED="➜"
  fi

  if [ "$POWERLINE_GIT_UNMERGED" = "" ]; then
    POWERLINE_GIT_UNMERGED="═"
  fi

  ZSH_THEME_GIT_PROMPT_PREFIX="  "
  ZSH_THEME_GIT_PROMPT_SUFFIX=""
  ZSH_THEME_GIT_PROMPT_DIRTY=" $POWERLINE_GIT_DIRTY"
  ZSH_THEME_GIT_PROMPT_CLEAN=" $POWERLINE_GIT_CLEAN"

  ZSH_THEME_GIT_PROMPT_ADDED=" $POWERLINE_GIT_ADDED"
  ZSH_THEME_GIT_PROMPT_MODIFIED=" $POWERLINE_GIT_MODIFIED"
  ZSH_THEME_GIT_PROMPT_DELETED=" $POWERLINE_GIT_DELETED"
  ZSH_THEME_GIT_PROMPT_UNTRACKED=" $POWERLINE_GIT_UNTRACKED"
  ZSH_THEME_GIT_PROMPT_RENAMED=" $POWERLINE_GIT_RENAMED"
  ZSH_THEME_GIT_PROMPT_UNMERGED=" $POWERLINE_GIT_UNMERGED"
  ZSH_THEME_GIT_PROMPT_AHEAD=" ⬆"
  ZSH_THEME_GIT_PROMPT_BEHIND=" ⬇"
  ZSH_THEME_GIT_PROMPT_DIVERGED=" ⬍"

  POWERLINE_SHOW_GIT_ON_RIGHT="true"
  POWERLINE_HIDE_GIT_PROMPT_STATUS=""

  # Get status of the working tree
  INDEX=$(command git status --porcelain -b 2> /dev/null)
  STATUS=""
  if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_RENAMED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  elif $(echo "$INDEX" | grep '^D  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  elif $(echo "$INDEX" | grep '^AD ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  fi
  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    STATUS="$ZSH_THEME_GIT_PROMPT_STASHED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^## .*ahead' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_AHEAD$STATUS"
  fi
  if $(echo "$INDEX" | grep '^## .*behind' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_BEHIND$STATUS"
  fi
  if $(echo "$INDEX" | grep '^## .*diverged' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DIVERGED$STATUS"
  fi

  if [ "$vcs_info_msg_0_" = "" ]; then
     POWERLINE_GIT_INFO_LEFT=""
     POWERLINE_GIT_INFO_RIGHT=""
  else
      if [ "$POWERLINE_SHOW_GIT_ON_RIGHT" = "" ]; then
          if [ "$POWERLINE_HIDE_GIT_PROMPT_STATUS" = "" ]; then
              POWERLINE_GIT_INFO_LEFT=" %F{blue}%K{white}"$'\ue0b0'"%F{white}%F{black}%K{white}"$'$vcs_info_msg_0_ $STATUS%F{white}'
          else
              POWERLINE_GIT_INFO_LEFT=" %F{blue}%K{white}"$'\ue0b0'"%F{white}%F{black}%K{white}"$'$vcs_info_msg_0_%F{white}'
          fi
          POWERLINE_GIT_INFO_RIGHT=""
      else
          POWERLINE_GIT_INFO_LEFT=""
          POWERLINE_GIT_INFO_RIGHT="%F{white}%K{white}%F{black}%K{white}$vcs_info_msg_0_%K{white}"
      fi
  fi


  if [ $(id -u) -eq 0 ]; then
      POWERLINE_SEC1_BG=%K{red}
      POWERLINE_SEC1_FG=%F{red}
  else
      POWERLINE_SEC1_BG=%K{green}
      POWERLINE_SEC1_FG=%F{green}
  fi
  POWERLINE_SEC1_TXT=%F{black}
  if [ "$POWERLINE_DETECT_SSH" != "" ]; then
    if [ -n "$SSH_CLIENT" ]; then
      POWERLINE_SEC1_BG=%K{red}
      POWERLINE_SEC1_FG=%F{red}
      POWERLINE_SEC1_TXT=%F{white}
    fi
  fi
  PROMPT="$POWERLINE_SEC1_BG$POWERLINE_SEC1_TXT $POWERLINE_USER_NAME %k%f$POWERLINE_SEC1_FG%K{blue}"$'\ue0b0'"%k%f%F{white}%K{blue} "$POWERLINE_CURRENT_PATH"%F{blue}"$POWERLINE_GIT_INFO_LEFT" %k"$'\ue0b0'"%f "

  if [ "$POWERLINE_DISABLE_RPROMPT" = "" ]; then
      if [ "$POWERLINE_RIGHT_A" = "" ]; then
          RPROMPT="$POWERLINE_GIT_INFO_RIGHT%F{white}"$'\ue0b2'"%k%F{black}%K{white} $POWERLINE_RIGHT_B %f%k"
      elif [ "$POWERLINE_RIGHT_B" = "" ]; then
          RPROMPT="$POWERLINE_GIT_INFO_RIGHT%F{white}"$'\ue0b2'"%k%F{240}%K{white} $POWERLINE_RIGHT_A %f%k"
      else
          RPROMPT="$POWERLINE_GIT_INFO_RIGHT%F{white}"$'\ue0b2'"%k%F{black}%K{white} $POWERLINE_RIGHT_B %f%F{240}"$'\ue0b2'"%f%k%K{240}%F{255} $POWERLINE_RIGHT_A %f%k"
      fi
  fi
}
