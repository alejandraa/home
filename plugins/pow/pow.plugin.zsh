# Restart a rack app running under pow
# http://pow.cx/
#
# Adds a kapow command that will restart an app
#
#   $ kapow myapp
#   $ kapow # defaults to current directory
#
# Supports command completion.
#
# If you are not already using completion you might need to enable it with
# 
#    autoload -U compinit compinit
#
function kapow {
	FOLDERNAME=$1
	if [ -z "$FOLDERNAME" ]; then; FOLDERNAME=${PWD##*/}; fi
	touch ~/.pow/$FOLDERNAME/tmp/restart.txt;
	if [ $? -eq 0 ]; then; echo "pow: restarting $FOLDERNAME" ; fi
}

kapow(){
  local vhost=$1
  [ ! -n "$vhost" ] && vhost=$(rack_root_detect)
  if [ ! -h ~/.pow/$vhost ]
  then
    echo "pow: This domain isn’t set up yet. Symlink your application to ${vhost} first."
    return 1
  fi

  [ ! -d ~/.pow/${vhost}/tmp ] && mkdir -p ~/.pow/$vhost/tmp
  touch ~/.pow/$vhost/tmp/restart.txt;
  [ $? -eq 0 ] &&  echo "pow: restarting $vhost.dev"
}
compctl -W ~/.pow -/ kapow

powit(){
	local basedir=$(pwd)
  local vhost=$1
  [ ! -n "$vhost" ] && vhost=$(rack_root_detect)
  if [ ! -h ~/.pow/$vhost ]
	then
		echo "pow: Symlinking your app with pow. ${vhost}"
	  [ ! -d ~/.pow/${vhost} ] && ln -s $basedir ~/.pow/$vhost
    return 1
  fi
}

# View the standard out (puts) from any pow app
alias kaput="tail -f ~/Library/Logs/Pow/apps/*"
