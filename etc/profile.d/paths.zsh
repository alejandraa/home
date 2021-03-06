# Documentation PATHs
MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH

export PYTHONPATH=$HOME/.python/lib/python2.7/site-packages
export JSPATH=$HOME/node_modules/.bin
export PATH=$PYTHONPATH:$JSPATH:/bin:/usr/local/sbin:$PATH

# Cache the path laid out in this file and `reset_path` if the shell
# gets confused.
export DEFAULT_PATH=$PATH
alias reset_path='export PATH=$DEFAULT_PATH'

export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/
