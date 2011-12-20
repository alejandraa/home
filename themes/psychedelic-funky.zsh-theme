#
# who is this doin this synthetic type of alpha beta psychedelic funky?
#######################################################################

# Taken from Tassilo's Blog
# http://tsdh.wordpress.com/2007/12/06/my-funky-zsh-prompt/

# open/close brackets
local blue_op="%{$fg[blue]%}[%{$reset_color%}"
local blue_cp="%{$fg[blue]%}]%{$reset_color%}"

# path string
local path_p="${blue_op}%~${blue_cp}"

# user@host string
local user_host="${blue_op}%n@%m${blue_cp}"

# git plugin
ZSH_THEME_GIT_PROMPT_PREFIX="─${blue_op}"
ZSH_THEME_GIT_PROMPT_SUFFIX=$blue_cp

# da prompt son
PROMPT="╭─${path_p}─${user_host}${git_prompt_info}
╰─ ♬ "
#local cur_cmd="${blue_op}%_${blue_cp}"
PROMPT2="╭─${path_p}─${user_host}
╰─ ♯ "