current_path=`pwd`
printf '\033[0;34m%s\033[0m\n' "Upgrading DOTS from upstream..."
( cd $ZSH && git pull origin master )
printf '\033[0;34m%s\033[0m\n' 'Your DOTS have been upgraded to the newest version! https://github.com/tubbo/dots for more information.'
cd "$current_path"
