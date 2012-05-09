# information to the right of the prompt
local path_prompt="%{$reset_color%}%~"
local git_prompt='${return_status}%{$fg[cyan]%}$(git_prompt_info)$(git_prompt_status)%{$reset_color_with_bg%} '

if [[ $(rvm-prompt i) == 'ruby' ]] ; then
  local ruby_prompt='${return_status}%{$fg[magenta]%}$(rvm-prompt v p g)%{$reset_color%} '
else
  local ruby_prompt='${return_status}%{$fg[magenta]%}$(rvm-prompt i v p g)%{$reset_color%} '
fi;

local user_prompt="%{$fg[yellow]%}%n@%m%{$reset_color%}"

# da prompt son
PROMPT="%{$fg[white]%}♬  %{$reset_color%}"
RPROMPT="${git_prompt} ${ruby_prompt} ${user_prompt} ${path_prompt} %{$reset_color%}"

# git plugin
ZSH_THEME_GIT_PROMPT_PREFIX="${ff}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
