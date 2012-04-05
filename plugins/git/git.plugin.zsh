# Aliases
alias g='git'
compdef g=git
alias gst='git status'
compdef _git gst=git-status
alias gu='git pull'
compdef _git gl=git-pull
alias gur='git pull --rebase'
compdef _git gl=git-pull
alias gup='git fetch && git rebase'
compdef _git gup=git-fetch
alias gp='git push'
compdef _git gp=git-push
alias gpf='git push tubbo'
compdef _git gpf=git-push
gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff
alias gc='git commit -v'
compdef _git gc=git-commit
alias gca='git commit -v -a'
compdef _git gca=git-commit
alias gco='git checkout'
compdef _git gco=git-checkout
alias gcm='git checkout master'
alias gb='git branch'
compdef _git gb=git-branch
alias gba='git branch -a'
compdef _git gba=git-branch
alias gcount='git shortlog -sn'
compdef gcount=git
alias gcp='git cherry-pick'
compdef _git gcp=git-cherry-pick
alias gl='git l'
compdef _git glg=git-log
alias gls='git log --stat --max-count=5'
compdef _git gls=git-log
alias glg='git log --graph --max-count=5'
compdef _git glg=git-log
alias lol='git lol'
compdef _git lol=git-log
alias gss='git status -s'
compdef _git gss=git-status
alias ga='git add'
compdef _git ga=git-add
alias gm='git merge'
compdef _git gm=git-merge
alias gls="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
compdef _git gls=git-log
alias grh='git reset HEAD'
compdef _get grh=git-reset
alias grhh='git reset HEAD --hard'
compdef _get grhh=git-reset
alias grv='git remote -v'
compdef _get grv=git-remote
alias gd='git diff'
compdef _get grv=git-diff
alias gg='git grep'
compdef _get gg=git-grep
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
alias gbl='git blame'
compdef _get gbl=git-blame


# Super useful alias aliases
alias s='gst'
compdef _get grv=git-statuss

# Git and svn mix
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'
compdef git-svn-dcommit-push=git


alias gsr='git svn rebase'
alias gsd='git svn dcommit'
#
# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

# these aliases take advantage of the previous function
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
