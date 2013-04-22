# Aliases
alias g='git'
compdef g=git

# Branching
alias gu='git pull'
compdef _git gl=git-pull
alias gur='git pull --rebase'
compdef _git gl=git-pull
alias gp='git push'
compdef _git gp=git-push
alias gpf="git push `git config github.user`"
compdef _git gpf=git-push
alias gph="git push heroku"
compdef _git gpf=git-push
gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff
alias gco='git checkout'
compdef _git gco=git-checkout
alias gb='git branch'
compdef _git gb=git-branch
alias gba='git branch -a'
compdef _git gba=git-branch
alias gm='git merge'
compdef _git gm=git-merge

# Logging and Viewing
alias gl='git blog'
compdef _git glg=git-log
alias gls='git log --stat --max-count=5'
compdef _git gls=git-log
alias glg='git log --graph --max-count=5'
compdef _git glg=git-log
alias lol='git lol'
compdef _git lol=git-log
alias gcount='git shortlog -sn'
compdef gcount=git
alias gst='git status'
compdef _git gst=git-status
alias gsts='git status -s'
compdef _git gss=git-status
alias gd='git diff'
compdef _get grv=git-diff
alias gg='git grep'
compdef _get gg=git-grep
alias gbl='git blame'
compdef _get gbl=git-blame

# Manipulation
alias gcp='git cherry-pick'
compdef _git gcp=git-cherry-pick
alias ga='git add'
compdef _git ga=git-add
alias gls="git l"
compdef _git gls=git-log
alias grv='git remote -v'
compdef _get grv=git-remote
alias gt='git reset'
compdef _get gt=git-reset
alias gth='git reset --hard'
compdef _get gt=git-reset
alias gts='git reset --soft'
compdef _get gt=git-reset
alias gthh='git reset --hard HEAD'
compdef _get gt=git-reset
alias gc='git commit -v'
compdef _git gc=git-commit
alias gca='git commit -v -a'
compdef _git gca=git-commit

# Stash
alias gs='git stash save'
compdef _get gsh=git-stash
alias gsp='git stash pop'
compdef _get gsh=git-stash

# Rebase
alias gr='git rebase'
compdef _get gg=git-rebase
alias grc='git rebase --continue'
compdef _get gg=git-rebase
alias grs='git rebase --skip'
compdef _get gg=git-rebase
alias gra='git rebase --abort'
compdef _get gg=git-rebase
alias gri='git rebase --interactive'
compdef _get gg=git-rebase
alias gmt='git mergetool'
compdef _get gmt=git-mergetool
alias gcf='git clean -f'
compdef _get gcf=git-clean
alias garc='gcf && ga . && grc' # a big one..., clean the repo, add everything, rebase --continue
compdef _get garc=git-add
compdef _get garc=git-rebase

# Super useful alias aliases
alias s='gst'
compdef _get grv=git-status

# Git and svn mix
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'
compdef git-svn-dcommit-push=git
alias gvr='git svn rebase'
alias gvd='git svn dcommit'

# Will return the current branch name
# Usage example: git pull origin $(current_branch)
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

# These aliases take advantage of the previous function
alias ggpull='git pull origin $(current_branch)'
compdef ggpull=git
alias ggpush='git push origin $(current_branch)'
compdef ggpush=git
alias ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'
compdef ggpnp=git

# Wrap git in the hub gem if it's installed
if (( $+commands[hub] )) ; then
  function git() {hub "$@"}
fi

# Github-specific
alias gpr='git pull-request'
alias gip='git internal-pull-request'
