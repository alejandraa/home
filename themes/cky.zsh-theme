# CKY by @tubbo
# =============
#
# A theme for Oh My ZSH that emphasizes CMYK colors primarily.
#
# Looks best with iTerm2 and Solarized.

local reset_color_with_bg="%{$reset_color%}%{$bg[grey]%}"

# information to the right of the prompt
local path_prompt="%{$bg[grey]%}%{$reset_color_with_bg%}%~"
local git_prompt='%{$bg[grey]%}${return_status}%{$fg[cyan]%}$(git_prompt_info)$(git_prompt_status)%{$reset_color_with_bg%}'
local ruby_prompt='%{$bg[grey]%}${return_status}%{$fg[magenta]%}$(rvm-prompt i v p g)%{$reset_color_with_bg%} '
local user_prompt="%{$bg[grey]%}%{$fg[yellow]%}%n@%m%{$reset_color_with_bg%}"

# da prompt son
PROMPT="%{$fg[white]%}♬  %{$reset_color%}"
RPROMPT="${git_prompt}%{$bg[black]%}%{$fg[black]%}${ruby_prompt}%{$bg[grey]%}${user_prompt}%{$bg[grey]%}%{$fg[black]%}:${path_prompt} %{$reset_color%}"

# git plugin
ZSH_THEME_GIT_PROMPT_PREFIX="${ff}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
