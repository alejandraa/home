#
# DOTS Installer
#

if [ -d ~/.dots ]
then
  echo "Error: You already have DOTS installed."
  cd ~/.dots
  exit
fi

echo "\033[0;34mInstalling DOTS...\033[0m"
/usr/bin/env git clone https://github.com/tubbo/dots.git ~/.dots

echo "\033[0;34mLooking for an existing zsh config...\033[0m"
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]
then
  echo "\033[0;33mFound ~/.zshrc.\033[0m \033[0;32]Backing up to ~/.zshrc.pre-dots\033[0m";
  cp ~/.zshrc ~/.zshrc.pre-dots;
  cp ~/.zshrc ~/.dots/config/zshrc;
  rm ~/.zshrc;
else
  echo "\033[0;34mCreating a template ZSH config from our example...\033[0m"
  cp ~/.dots/templates/zshrc.zsh-template ~/.zshrc
fi

echo "\033[0;34m Linking ZSH config...\033[0m"
ln -s ~/.dots/config/zshrc ~/.zshrc;

echo "\033[0;34mCopying your current PATH and adding it to the end of ~/.zshrc for you.\033[0m"
echo "export PATH=$PATH" >> ~/.zshrc

echo "\033[0;34mTime to change your default shell to zsh!\033[0m"
chsh -s `which zsh`

echo "\n\n \033[0;32mCongratulations! We like yo DOTS!\033[0m"
/usr/bin/env zsh
source ~/.zshrc
