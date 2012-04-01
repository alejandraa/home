DOTS
====

DOTS is a framework for ZSH productivity forked off of the popular [Oh My ZSH!][omz] starter framework. It is slightly slimmed down and expects a certain level of ZSH familiarity and shell comfortability before use. I decided to separate this as an extra project when it became clear that I did not need many of the higher-level functionality (such as themes) for everyday shell use.

Features
--------

- Plugin library with backwards compatibility for ZSH plugins
- Simplified prompt string themeing
- Configuration persistence via the `persist` command. This copies your dot-files to the **config/** directory and allows you to optionally store them in Git.

Roadmap
-------

### v1.0.0

- Test installer
- Get all names changed from .oh-my-zsh to .dots
- Make sure there's no private data in my bin dir

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

You *might* need to modify your $PATH in **~/.zshrc** if you're not able to find some commands after switching to **DOTS**.

Forking
-------

It's recommended that you fork this project so you can store your own custom settings in **config/**.

Usage
-----

Edit `lib/dots/prompt.zsh` to change your prompt string.

Type `persist .vimrc` or `forget .vimrc` to either add or remove your configs to the .dots/ directory, wherein they can then be pushed to your GitHub fork.

License
-------

    Copyright (c) 2012 Tom Scott

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Contributors
------------

Just me, [@tubbo][twt]

[omg]: https://github.com/robbyrussell/oh-my-zsh
[twt]: https://twitter.com/tubbo
