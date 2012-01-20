##
# This is my ZSH configuration. I use oh-my-zsh for ease of use
##

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Program and documentation paths
PATH=/usr/local/bin:/usr/pear/bin:$HOME/.oh-my-zsh/bin:/usr/local/share/npm/bin:/usr/local/Cellar/python/2.7.1/bin:/usr/local/git/bin/:$PATH
MANPATH=/opt/local/share/man:$MANPATH

# Default text editors
EDITOR='subl -w'
GIT_EDITOR='vim'

# PostgreSQL config
ARCHFLAGS='-arch x86_64'
PGDATA=/usr/local/var/postgres

# MySQL config
MYSQL_PS1="\R:\m:\s \h> "

# Load RVM into a shell session
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# JSDoc config
JSDOCTEMPLATEDIR=/home/necromancer/Code/jsdoc/jsdoc-toolkit/templates

# Define the C compiler
CC=/usr/bin/gcc-4.2

# Aliases
alias c=clear

# Load my custom oh my zsh theme (based on "funky")
ZSH_THEME="psychedelic-funky"	# if you set this to "random", it'll load a random theme each time that oh-my-zsh is loaded.

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Load oh-my-zsh plugins
plugins=(git osx bundler vagrant thor rvm gem)

# Run oh-my-zsh!
source $ZSH/oh-my-zsh.sh
