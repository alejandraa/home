#
# who is this doin this synthetic type of alpha beta psychedelic funky?
#######################################################################

# Taken from Tassilo's Blog
# http://tsdh.wordpress.com/2007/12/06/my-funky-zsh-prompt/

# open/close brackets
local blue_op="%{$fg[blue]%}[%{$reset_color%}"
local blue_cp="%{$fg[blue]%}]%{$reset_color%}"

# information to the right of the prompt
local path_prompt="${blue_op}%~${blue_cp}-"
local git_prompt='${return_status}$(git_prompt_info)$(git_prompt_status)%{$reset_color%}'
local ruby_prompt="${return_status}$(rvm_prompt_info)%{$reset_color%}"
local user_prompt="${blue_op}%n@%m${blue_cp}"

# da prompt son
PROMPT="♬  "
RPROMPT="${git_prompt}${ruby_prompt}${path_prompt}${user_prompt}"
# PROMPT2="╭─${path_p}─${user_host}
# ╰─ ♯  "

# git plugin
ZSH_THEME_GIT_PROMPT_PREFIX="${blue_op}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${blue_cp}-"
ZSH_THEME_GIT_PROMPT_DIRTY="!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
