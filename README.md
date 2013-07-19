DOTS
====

DOTS is a framework for ZSH that helps you manage your dot-files, ZSH
sugar functionality, and your general shell experience. It began its
life as a fork off the popular [Oh My ZSH framework][omz]. It has
similar design philosophies and functionality, but different goals.
Where Oh My ZSH is meant for new users to get more acclamated with ZSH,
DOTS is meant for the slightly more advanced user who wants the built-in
functionality of Oh My ZSH but wants a bit more additional
customization. It also includes some extra tools that help with day-to-day
shell management tasks.

Features
--------

- Modular plugin architecture inspired by [Oh My ZSH][omz], but using Antigen for greater efficiency.
  Only code that's specific to your repo needs to be in your repo.
- Simplified prompt string themeing in the `lib/dots/prompt.zsh` directory.
- Configuration persistence via the `persist` command. This copies your
  dot-files to the **config/** directory and allows you to optionally
  store them in Git. Add your persisted configs to your fork's
  `.gitignore` if you don't want them synchronized, and `forget`
  them when you don't want them symlinked anymore. Keeping your
  configuration files in a place that's easily accessible with a
  text editor helps you keep an eye on your configuration.
- Aliases for common shell functionality like searching for a running
  process, opening your text editor, viewing files with a pager, setting
  the title of the current iTerm tab, [optimizing your OS X environment](osx4h),
  and much more.
- Environment boostrapping, installs a global gemset and a series of
  programs through Homebrew (as well as Homebrew itself) that aid in
  your day-to-day programming tasks.

Installation
------------

Before installing, make sure you have Git on your system!

Fork this project, then clone your fork of the repo like so:

```bash
$ git clone git@github.com:tubbo/dots.git ~/.dots
```

You'll then need to 


Usage
-----

### dots

The DOTS binary is another useful tool in your shell adventures. Invoke
`dots help` to check out what it does. This binary is most useful for
updating the DOTS framework from source and bootstrapping the environment
on new installs.


### dots persist DOT_FILE

You can persist any dot file with DOTS. Simply run this command on 
the file...it will copy the file to your `$DOTS` folder and symlink 
that new file in its original place, preserving your settings in a 
git repository but making it accessible for the application needing
to use it.

### dots forget DOT_FILE

The opposite of `persist`. Deletes the symlink and restores your file. 
For when you just need to fuggeddaboutit...

### dots reload

Symlink all dotfiles in ~/.dots/config to your home directory.

### dots update

Pull the latest changes from Git's origin:master and run `antigen
update` to make sure all plugins and framework code are up to date.

### ti NEW_TITLE

Sets the title of the iTerm window to the String you pass in. This is a
function called **set_title()** but is aliased to `ti` for convenience.

### o, v and e

These three commands open, view and edit files, respectively. They use
the Finder (OS X only), whatever you set as your `$PAGER` and whatever
you set as your `$EDITOR` to do their tasks. Merely aliases, these
conventions are prime examples of how DOTS is constructed. They all use
sensible defaults, for example `o` will open the current directory, but
`o ~/Code` will open up ~/Code in the Finder. `e` follows suit, but `v`
throws an error as this should almost never be the case. 


Hidden Configuration
--------------------

In many cases, programmers want to keep some sensible defaults checked
in to their DOTS repo, but may need to keep their own personal key and
certificate settings private. In this case, you can simply put those
values in a `~/.dots/config/file.zsh`. These files are ignored both by
Git and by DOTS when it symlinks configuration into the repo. In your
application's dotfile, insert the following line to load configuration
from your untracked file:

```bash
$ dots hide FILE
```

This will run the following shell command:

```bash
$ source $DOTS/config/$1.zsh
```

where `$1` is the first argument given to the function.

Environment Bootstrapping
-------------------------

DOTS installs a number of programs for you:

- **Vim** for text editing. It fits into the DOTS philosophy very nicely
  of having each program do one thing really well.
- The latest version of the **Ruby** programming language. We believe
  that you should keep your tools up to date, and Homebrew has been
  very reliable in maintaining the latest version of Ruby, as Homebrew
  is itself a Ruby project. It's also a great shell scripting language,
  among other things...
- **Hub for Git** is a plugin for Git that makes it easier to work with
  Github. I use Github to host all my code so I find this software useful.
  Hub is aliased to `git` when the github plugin is enabled.

Run `dots bootstrap` to install these apps via Homebrew (and Pip)

License
-------

DOTS is released under **The MIT License**:

    Copyright (c) 2012 Tom Scott

    Permission is hereby granted, free of charge, to any person 
    obtaining a copy of this software and associated documentation files
    (the "Software"), to deal in the Software without restriction,
    including without limitation the rights to use, copy, modify, merge,
    publish, distribute, sublicense, and/or sell copies of the Software,
    and to permit persons to whom the Software is furnished to do so,
    subject to the following conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
    BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
    ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Contributing
------------

To contribute to the project, fork it and send me a pull request!

I accept either traditional email pulls or Github pull requests.

[omz]: https://github.com/robbyrussell/oh-my-zsh
[hub]: https://github.com/defunkt/hub
[cw]: https://defunkt.io
[osx4h]: https://gist.github.com/2260182
