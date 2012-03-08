##
# This is my ZSH configuration. I use oh-my-zsh for ease of use
##

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Program and documentation paths
PATH=/usr/local/bin:/usr/pear/bin:$HOME/.oh-my-zsh/bin:/usr/local/share/npm/bin:/usr/local/Cellar/python/2.7.1/bin:/usr/local/git/bin/:$HOME/.rvm/bin:$HOME/bin:$PATH
MANPATH=/opt/local/share/man:$MANPATH

# Default text editors
EDITOR='subl'
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

# Load my custom theme (based on "funky")
ZSH_THEME="cky"

# Keep everything case-insensitive
# CASE_SENSITIVE="true"

# Automatically update every week
# DISABLE_AUTO_UPDATE="true"

# Use colors in `ls`
# DISABLE_LS_COLORS="true"

# Set the Terminal title automatically
# DISABLE_AUTO_TITLE="true"

# Red dots are displayed when ZSH is hanging
COMPLETION_WAITING_DOTS="true"

# Load oh-my-zsh plugins
plugins=(git osx bundler thor rvm gem rails3 ruby growl sublime brew powder cake cap ruby github git-flow)

# Make Ruby/Rails even faster
RUBY_HEAP_MIN_SLOTS=1000000
RUBY_HEAP_SLOTS_INCREMENT=1000000
RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
RUBY_GC_MALLOC_LIMIT=1000000000
RUBY_HEAP_FREE_MIN=500000

# Run oh-my-zsh!
source $ZSH/oh-my-zsh.sh
