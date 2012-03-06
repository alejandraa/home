#
# who is this doin this synthetic type of alpha beta psychedelic funky?
#######################################################################

# Taken from Tassilo's Blog
# http://tsdh.wordpress.com/2007/12/06/my-funky-zsh-prompt/

# open/close brackets
local op="%{$fg[blue]%}[%{$reset_color%}"
local cp="%{$fg[blue]%}]%{$reset_color%}"
local sp="%{$fg[gray]%}-%{$reset_color%}"
local ff="%{$fg[white]%}"

# information to the right of the prompt
local path_prompt="${op}${ff}%~${cp}-"
local git_prompt='${return_status}${ff}$(git_prompt_info)$(git_prompt_status)%{$reset_color%}'
local ruby_prompt="${return_status}$(rvm_prompt_info)%{$reset_color%}"
local user_prompt="${op}${ff}%n@%m${cp}"

# da prompt son
PROMPT="${ff}♬%{$reset_color%}  "
RPROMPT="${git_prompt}${ruby_prompt}${path_prompt}${user_prompt}"

# git plugin
ZSH_THEME_GIT_PROMPT_PREFIX="${op}${ff}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${cp}${sp}"
ZSH_THEME_GIT_PROMPT_DIRTY="!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
