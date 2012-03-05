# get the version of Ruby we're using and the current gemset
function rvm_prompt_info() {
  # local full_ruby_version=$(~/.rvm/bin/rvm current gemset 2> /dev/null) || return
  declare -rx current_gemset=$(rvm current gemset)
  echo "%{$fg[blue]%}[%{$reset_color%}${current_gemset}%{$fg[blue]%}]%{$reset_color%}-"
}


