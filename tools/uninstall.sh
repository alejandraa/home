echo "Removing ~/.dots"
if [[ -d ~/.dots ]]
then
  rm -rf ~/.dots
fi

echo "Looking for an existing zsh config..."
if [ -f ~/.zshrc.pre-dots ] || [ -h ~/.zshrc.pre-dots ]
then
  echo "Restored ~/.zshrc from ~/.zshrc.pre-dots";
  rm ~/.zshrc;
  cp ~/.zshrc.pre-dots ~/.zshrc;
  source ~/.zshrc;
else
  echo "Switching back to bash"
  chsh -s /bin/bash
  source /etc/profile
fi

echo "Thanks for using DOTS, it's been uninstalled."
