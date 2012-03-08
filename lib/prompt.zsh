#!/bin/zsh
#
# The prompt string. Any compatible OMZ theme will work here. Just paste in the contents of your OMZ theme in here and save it.

# thanks Mikachu...this changes the line editor so i have white text w/a grey bg when i type new commands
zle_highlight=(region:underline
               special:bold,fg=white,c
               bg=black
               default:fg=white,bg=grey
              )
if [[ x$termcap[Co] = x88 ]]; then
  zle_highlight+=('fg_start_code:\e[38;5;'
                  fg_default_code:88
                  'bg_start_code:\e[48;5;'
                  bg_default_code:88
                  isearch:bg=9
                  suffix:bold,bg=12
                 )
else
  zle_highlight+=(isearch:standout)
fi 2> /dev/null

# utility
local reset_color_with_bg="%{$reset_color%}%{$bg[grey]%}"

# information to the right of the prompt
local path_prompt="%{$bg[grey]%}%{$reset_color_with_bg%}%~"
local git_prompt='%{$bg[grey]%}${return_status}%{$fg[cyan]%}$(git_prompt_info)$(git_prompt_status)%{$reset_color_with_bg%} '
local ruby_prompt='%{$bg[grey]%}${return_status}%{$fg[magenta]%}$(rvm-prompt i v p g)%{$reset_color_with_bg%} '
local user_prompt="%{$bg[grey]%}%{$fg[yellow]%}%n@%m%{$reset_color_with_bg%}"

# da prompt son
PROMPT="%{$bg[grey]%}%{$fg[white]%}♬  %{$reset_color_with_bg%}"
RPROMPT="${git_prompt}%{$bg[black]%}%{$fg[black]%}${ruby_prompt}%{$bg[grey]%}${user_prompt}%{$bg[grey]%}%{$fg[black]%}:${path_prompt} %{$reset_color%}"

# git plugin
ZSH_THEME_GIT_PROMPT_PREFIX="${ff}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
