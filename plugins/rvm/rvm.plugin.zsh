# Load RVM into a shell session
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

alias rubies='rvm list rubies'
alias gemsets='rvm gemset list'

local ruby18='ruby-1.8.7-p334'
local ruby19='ruby-1.9.2-p180'

function rb18 {
	if [ -z "$1" ]; then
		rvm use "$ruby18"
	else
		rvm use "$ruby18@$1"
	fi
}

_rb18() {compadd `ls -1 $rvm_path/gems | grep "^$ruby18@" | sed -e "s/^$ruby18@//" | awk '{print $1}'`}
compdef _rb18 rb18

function rb19 {
	if [ -z "$1" ]; then
		rvm use "$ruby19"
	else
		rvm use "$ruby19@$1"
	fi
}

_rb19() {compadd `ls -1 $rvm_path/gems | grep "^$ruby19@" | sed -e "s/^$ruby19@//" | awk '{print $1}'`}
compdef _rb19 rb19

function rvm-update {
	rvm get head
	rvm reload # TODO: Reload rvm completion?
}

# TODO: Make this usable w/o rvm.
function gems {
	local current_ruby=`rvm-prompt i v p`
	local current_gemset=`rvm-prompt g`

	gem list $@ | sed \
		-Ee "s/\([0-9, \.]+( .+)?\)/$fg[blue]&$reset_color/g" \
		-Ee "s|$(echo $rvm_path)|$fg[magenta]\$rvm_path$reset_color|g" \
		-Ee "s/$current_ruby@global/$fg[yellow]&$reset_color/g" \
		-Ee "s/$current_ruby$current_gemset$/$fg[green]&$reset_color/g"
}

# Quickly make an .rvmrc file for the current folder
function rvmrc {
	local folder=$(basename `pwd`)

	if [ -z "$1" ]; then
		rvm --rvmrc --create $1\@$folder
	else
		echo "You must specify a version of Ruby"
	fi
}

# The following functions were shamelessly stolen from http://skitch.com/oshuma/nni3k/zsh-prompt-git-clean
source ~/.rvm/scripts/rvm

# Prompt function. Return the full version string.
function ruby_prompt_version_full {
  version=$(
    rvm info |
    grep -m 1 'full_version' |
    sed 's/^.*full_version:[ ]*//' |
    sed 's/["]//g'
  ) || return
  echo $version
}

# Prompt function. Return just the version number.
function ruby_prompt_version {
  version=$(
    rvm info |
    grep -m 1 'version' |
    sed 's/^.*version:[ ]*//' |
    sed 's/["]//g'
  ) || return
  echo $version
}
