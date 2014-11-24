# Master configuration for all shells. Responsible for loading the
# "profile.d" drop-dir where all real configuration is stored.

for file in `ls $HOME/etc/profile.d`; do
  source "$HOME/etc/profile.d/$file"
done
