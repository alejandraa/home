#!/bin/bash
#
# A bootstrap script for installing Homebrew, Homer, and my home
# directory. Meant to be run directly in the shell as pretty much the
# first command you run on a new machine install.

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap tubbo/homebrew-tap
brew install homer
homer init -c git@github.com:tubbo/home.git
brew flight install
