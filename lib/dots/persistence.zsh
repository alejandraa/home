persist() {
  if [ $1 ] ; then;
    exec "mv $HOME/$1 $DOTS/config/$1.zsh"
    exec "ln -s $DOTS/config/$1.zsh ~/$1"
    exec "cd $DOTS; git add config/$1.zsh"
    echo "Dots is now persisting ~/$1"
  fi;
}

forget() {
  if [ $1 ] ; then;
    exec "cp $DOTS/config/$1.zsh $HOME/$1"
    exec "cd $DOTS; git rm -rf config/$1.zsh"
    echo "Dots is no longer persisting ~/$1"
  fi;
}
