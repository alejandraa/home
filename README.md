DOTS
====

DOTS is a framework for ZSH that helps you manage your dot-files, ZSH sugar functionality, and your general shell experience. It began its life as a fork off the popular [Oh My ZSH framework][omz]. It has similar design philosophies and functionality, but different goals. Where Oh My ZSH is meant for new users to get more acclamated with ZSH, DOTS is meant for the slightly more advanced user who wants the built-in functionality of Oh My ZSH but wants additional customization and functionality, such as the copying and synchronization of "dot-files".

Features
--------

- Modular plugin architecture inspired by [Oh My ZSH][omz], but using Antigen for greater efficiency.
  Only code that's specific to your repo needs to be in your repo.
- Simplified prompt string themeing in the `lib/dots/prompt.zsh` directory.
- Configuration persistence via the `persist` command. This copies your dot-files to the **config/** 
  directory and allows you to optionally store them in Git. Add your persisted configs to your fork's 
  `.gitignore` if you don't want them synchronized, and `forget` them when you don't want them symlinked 
  anymore. Keeping your configuration files in a place that's easily accessible with a text editor helps you 
  keep an eye on your configuration.
- Aliases for common shell functionality like searching for a running
  process, opening your text editor, viewing files with a pager, setting
  the title of the current iTerm tab, [optimizing your OS X environment](osx4h),
  and much more.

Installation
------------

Just run the following commands:

```bash
$ gem install zsh_dots
$ dots install
```

This will link the gem's installation to `~/.dots`, and symlink all of
the files in `~/.dots/config` to your home directory as dotfiles (unless
existing ones are found).

### Problems?

You *might* need to modify your $PATH in **~/.zshrc** if you're not able to find some
commands after switching to **DOTS**.

Usage
-----

There are a number of commands built-in to the DOTS framework:

### persist DOT_FILE

You can persist any dot file with DOTS. Simply run this command on the file...it will copy the
file to your `$DOTS` folder and symlink that new file in its original place, preserving your
settings in a git repository but making it accessible for the application needing to use it.

### forget DOT_FILE

The opposite of `persist`. Deletes the symlink and restores your file. For when you just need to
fuggeddaboutit...

### osx_for_hackers

For Mac OS X users, this runs a bunch of settings that I found very helpful for browsing and using
my Mac. It's totally optional, but this alias simply runs the `tools/osx.zsh` script.

### set_title TO_STRING

Sets the title of the iTerm window to the String you pass in.

### o, v and e

These three commands open, view and edit files, respectively. They use
the Finder (OS X only), whatever you set as your `$PAGER` and whatever
you set as your `$EDITOR` to do their tasks. Merely aliases, these
conventions are prime examples of how DOTS is constructed. They all use
sensible defaults, for example `o` will open the current directory, but
`o ~/Code` will open up ~/Code in the Finder. `e` follows suit, but `v`
throws an error as this should almost never be the case. 

### more on e() and macvim

`e` has some special functionality for [alloy's MacVim
fork](http://github.com/alloy/macvim), referred to here as
`macvim_drawer`. 

`e`'s functionality is slightly different for users of `macvim_drawer`, 
as `mvim` automatically opens up to a directory for some users of the
fork. Because of this, `e` detects the use of `mvim` and will perform a
quick hack to allow you to type `e ~/Code/project` without leaving the
current directory. It `cd`s into the directory you give it, then opens a
file that's usually there, like `README.md`. It then `cd`s back to the
original directory and exits with a success code. You can disable this
functionality by setting `DRAWER=false` in your zshenv.

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
[osx4h]: https://gist.github.com/2260182
