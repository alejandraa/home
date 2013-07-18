# Install all Vim plugins with Vundle
vundle() {
  vim +BundleInstall +qall
  echo "Your Vundle has been installed to ~/.vim/bundle"
}

# Define an easy-to-remember alias for the vundle command
alias vimb=vundle
