DOTS
====

DOTS is a framework for ZSH that helps you manage your dot-files, ZSH sugar functionality, and your general shell experience. It began its life as a fork off the popular [Oh My ZSH framework][omz]. It has similar design philosophies and functionality, but different goals. Where Oh My ZSH is meant for new users to get more acclamated with ZSH, DOTS is meant for the slightly more advanced user who wants the built-in functionality of Oh My ZSH but wants additional customization and functionality, such as the copying and synchronization of "dot-files".

Features
--------

- Vast, modular plugin library, built on top of [Oh My ZSH][omz]'s architecture.
- Simplified prompt string themeing in the `lib/dots/prompt.zsh` directory.
- Configuration persistence via the `persist` command. This copies your dot-files to the **config/** directory and allows you to optionally store them in Git. Add your persisted configs to your fork's `.gitignore` if you don't want them synchronized.

Installation
------------

### One line install:

If you really trust me, you can run this simple command in your Terminal to download and install the DOTS framework!

    curl -L https://github.com/tubbo/dots/raw/master/tools/install.sh | sh

### Manual install:

For the more paranoid users, here's basically what the above script does:

    git clone git://github.com/tubbo/dots.git ~/.dots
    ln -s ~/.dots/config/zshrc ~/.zshrc
    chsh -s /bin/zsh

Then start (or restart) ZSH by reloading or opening a new terminal window.

### Problems?

You *might* need to modify your $PATH in **~/.zshrc** if you're not able to find some
commands after switching to **DOTS**.

Usage
-----

There are a number of commands built-in to the DOTS framework:

### persist <dot-file>

You can persist any dot file with DOTS. Simply run this command on the file...it will copy the
file to your `$DOTS` folder and symlink that new file in its original place, preserving your
settings in a git repository but making it accessible for the application needing to use it.

### forget <dot-file>

The opposite of `persist`. Deletes the symlink and restores your file. For when you just need to
fuggeddaboutit...

### upgrade_zsh

Downloads, unarchives and compiles the latest version of ZSH.

### osx_for_hackers

For Mac OS X users, this runs a bunch of settings that I found very helpful for browsing and using
my Mac. It's totally optional, but this alias simply runs the `tools/osx.zsh` script.

### configure_dots

Opens up the `$DOTS` folder in your text editor of choice (defined with `EDITOR=` in your zshrc).
Useful for fixing bugs or development.

### upgrade_dots

Downloads the latest `HEAD` from the DOTS Github repository.

### uninstall_dots

If you don't think DOTS is for you, just get rid of it with this command.

Forking
-------

It's recommended that you fork this project so you can store your own custom settings in **config/**, and get the most use out of this framework.

To do so, click the **Fork** button at the top of this page.

Then, type the following into your Terminal:

    git remote add <your-github-username> git@github.com:<your-github-username>/dots.git

And to make sure it works, type

    git pull <your-github-username> master

We like the follow the convention for fork names set forth in [the hub plugin][hub] by [Chris Wernstrath][cw]. You can feasibly name the fork anything you like.

You can either modify **tools/upgrade.sh** to `git pull` from your fork and `git push` to your fork after the upgrade is complete to keep it in sync, or do it manually by setting `DISABLE_AUTO_UPDATE="true"` (which is disabled by default in **config/zshrc**).

Usage
-----

Edit `lib/dots/prompt.zsh` to change your prompt string.

Type `persist .vimrc` or `forget .vimrc` to either add or remove your configs to the .dots/ directory, wherein they can then be pushed to your GitHub fork.

License
-------

DOTS is released under **The MIT License**:

    Copyright (c) 2012 Tom Scott

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Contributors
------------

Just me, [@tubbo][twt]

[omz]: https://github.com/robbyrussell/oh-my-zsh
[twt]: https://twitter.com/tubbo
[hub]: https://github.com/defunkt/hub
[cw]: https://defunkt.io
