##
# @tubbo's .zshrc
#
# uses oh-my-zsh for black magick mothafucka code
# http://github.com/tubbo/oh-my-zsh
##

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
omz=ZSH 	# alias to the ZSH configuration

# Program and documentation paths
PATH=/usr/local/bin:/usr/pear/bin:$HOME/bin:/usr/local/share/npm/bin:/usr/local/Cellar/python/2.7.1/bin:/usr/local/git/bin/:$HOME/Sites/blog/bin:$HOME/Projects/blog/bin:$PATH
MANPATH=/opt/local/share/man:$MANPATH

# Default text editors
EDITOR='subl -w'
GIT_EDITOR='subl -w'

# PostgreSQL config
ARCHFLAGS='-arch x86_64'
PGDATA=/usr/local/var/postgres

# MySQL config
MYSQL_PS1="\R:\m:\s \h> "

# Load RVM into a shell session
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# JSDoc config
JSDOCTEMPLATEDIR=/home/necromancer/Code/jsdoc/jsdoc-toolkit/templates

# Define the C compiler, we need this so RVM will actually install shit
CC=/usr/bin/gcc-4.2

# Clearing is something I do all the time
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

# Load the following plugins for aliases, extra completion, and other
# generally fun features. Some plugins have been modified, their
# modifications can be found in the custom/<plugin> directories.
plugins=(git osx bundler vagrant thor rvm gem)

# Run oh-my-zsh!
source $ZSH/oh-my-zsh.sh
