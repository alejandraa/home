trap echo" 'I'\''m sorry Dave, I can'\''t let you do that'" INT
stty -echo
echo -n '\r\e[K'
#### set locale
() {
  local charset lc value TIME_dk
  case $TERM in
    rxvt-unicode)
    charset=".UTF-8"
    TIME_dk=en_DK
    ;;
    *)
    charset=""
    TIME_dk=sv_SE
    ;;
  esac
  for lc value in LC_CTYPE sv_SE LANG en_US LC_NUMERIC POSIX LC_TIME $TIME_dk LC_COLLATE sv_SE LC_MONETARY sv_SE LC_MESSAGES en_US LC_PAPER sv_SE LC_NAME sv_SE LC_ADDRESS sv_SE LC_TELEPHONE sv_SE LC_MEASUREMENT sv_SE LC_IDENTIFICATION sv_SE; do
    if [[ $value == POSIX ]]; then
      eval ": \${${(q)lc}:=${(q)value}}; export ${(q)lc}"
    else
      eval ": \${${(q)lc}:=${(q)value}${(q)charset}}; export ${(q)lc}"
    fi
  done
}

### Zsh modules

zmodload zsh/mathfunc
zmodload zsh/complete
zmodload zsh/compctl
zmodload zsh/complist
zmodload zsh/datetime
zmodload -aF zsh/stat -b:stat b:zstat
zmodload zsh/terminfo
zmodload zsh/attr
zmodload zsh/zselect

### startup commands
if [[ -n "$ZSHRUN" ]]; then
  PS1=$'%Bzshrun%b %F{9}%~%f> '
else
  if [[ $USERNAME = mikachu && ${+SSH_CLIENT} = 0 ]]; then
    if [[ $PWD = ~ && $SHLVL = 1 ]]; then
      #test -f .tdldb && {tdll -1; echo}
      [ ! .when/calendar(ah-1N) ] && () {
        local output
        output="$(when i)"
        touch -a .when/calendar
        (( $#output )) && printf '%s\n\n' "$output"
      }
      # this test checks if there are files in ~/put before running an expensive ls
      [ ~/put(FN) ] && {ls --color=auto --quoting-style=shell -T 0 -A -v ~/put}
    fi

    if [ "$TERM" = linux ]
    then
      MAILPATH='/home/mikachu/mail/list?New mailing list mail:/var/spool/mail/mikachu?New mail'
      setopt mailwarning
      MAILCHECK=10
      TMOUT=200
    fi
  fi
  REPORTTIME=20
  () {
    if [[ "$terminfo[colors]" = 88 ]]; then
      local darkpurple='%F{5}'
      local purple='%F{13}'
      local darkred='%F{1}'
      local red='%F{9}'
      local darkgreen='%F{2}'
      local green='%F{10}'
      local blue='%F{12}'
      local white='%F{7}'
      local darkwhite='%F{8}'
      local yellow='%F{11}'
      local darkcyan='%F{6}'
      local boldcyan='%B%F{14}'
      local blackbg='%K{0}'
      #local randcol=%F\{$(( RANDOM % (79-17) + 17 ))\}
      local shlvlcol=%F\{$(( 88 - SHLVL ))\}
      _preacceptcolor=96
      _postacceptcolor=94
    else
      local darkpurple='%F{5}'
      local purple='%B%F{5}'
      local darkred='%F{1}'
      local red='%B%F{1}'
      local darkgreen='%F{2}'
      local green='%B%F{2}'
      local blue='%F{12}'
      local white='%F{7}'
      local darkwhite='%F{8}'
      local yellow='%F{11}'
      local darkcyan='%F{6}'
      local red='%B%F{1}'
      local boldcyan='%B%F{6}'
      local blackbg='%K{0}'
      #local randcol='%F{2}'
      _preacceptcolor=31
      _postacceptcolor=34
    fi
    local reset='%f%b%u'
    local psvarcol=$'%{\e[0;%vm%}'
    local psvarcolbold=$'%{\e[1;%vm%}'
    psvar[1]=$_preacceptcolor
    if [[ $UID = 0 ]]; then
      local pathc=$white
      local darkpathc=$darkwhite
    else
      local pathc=$yellow
      local darkpathc=$darkyellow
    fi
    # {hh:mm:ss:~/foo}% text goes here                  'tty number (in vt only)' 'number of jobs' 'error status'
    PS1="$reset$green{$shlvlcol%D{%T}$darkgreen|$darkpathc%40<...<$pathc%~%<<%(3V.$purple/%3v%(4V.$white%B:$red%4v%b.).)$green}%(2L.$psvarcolbold%(3L.(%L).).$psvarcol)%(9V.(%9v).)%#%f%b "
    [[ $TERM == linux ]] && local tty=$TTY
    RPS1="$blue$tty:t%(1j.$yellow %j jobs.)%(?.. $red$blackbg%?%k)%f%b"
    setopt transientrprompt

    PS2="$reset$yellow<$darkcyan%_$white:$darkpathc%40<...<$pathc%~%<<$yellow>$blue%# %(1j.$yellow%j jobs .)%(?.%f%b.$red$blackbg%?%k%f%b )"

    PS3="$red?#%f%b "
  }
fi

HISTSIZE=13000
SAVEHIST=12000
export HINDI=${HINDI:-""}
if [[ -n "$ZSHRUN" ]]; then
  setopt histignorealldups
  HISTFILE=~/.zrunhistory
elif [[ "$HINDI" = "" ]]; then
  HISTFILE=~/.history
else
  unset HISTFILE
  fc -R ~/.history
fi
cdpath=(~/.cdpath)
CORRECT_IGNORE=_*

### Zsh options

 if [[ -n "$DISPLAY" ]]; then
   setopt nohup
   setopt nocheckjobs
 fi
 setopt autocd
 setopt pushdignoredups
 setopt histverify
 setopt autopushd
 setopt correct
 setopt nohashlookup
 setopt nohistbeep
 setopt ignoreeof
 setopt pathdirs
 setopt incappendhistory
 setopt notify
 setopt autocontinue
 setopt dvorak
 setopt histignorespace
 setopt histreduceblanks
 setopt histignoredups
 setopt histfinddups
 setopt pushdminus
 unsetopt beep
 setopt extendedglob
 setopt banghist
histchars=$'\2\6#' # ^B^F#
 setopt noclobber
 setopt cbases
 setopt magicequalsubst
 setopt histsubstpattern
 setopt chase{dots,links}
 setopt braceccl
 __a=({$'\x00'-$'\xff'})
 unsetopt braceccl
 setopt rcquotes
 setopt noshortloops
 setopt histfcntllock
 setopt noeditdeactivatesregion

### Completion system options
 unsetopt completeinword
 setopt globcomplete
 setopt nolistambiguous
 setopt listpacked

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' `: +'r:|[._-]=* r:|=*'` +'l:|=* r:|=*'

#_expand before _complete if you want =mplayer<tab> to expand the path of the binary f.e.
zstyle ':completion:*' completer _oldlist _complete _correct
zstyle ':completion:*' accept-exact-dirs 'yes'
zstyle ':completion:*' file-sort name
zstyle ':completion:*' ignore-parents pwd
zstyle ':completion:*' insert-tab empty
zstyle ':completion:*' list-colors ${${(s.:.)LS_COLORS}%ec=*}
zstyle ':completion:*:*:-command-:*' list-colors ''
#zstyle ':completion:*:(directories|other-files|files|local-directories|bookmarks|executables|suffix-aliases)' list-colors ${${(s.:.)LS_COLORS}%ec=*}
#zstyle ':completion:*' file-list dirprop=user.notes
#zstyle ':completion:*' dirinfo-format '%f '${(%):-%F{11}}%i${(%):-%f}
zstyle ':completion:*' list-prompt "%SAt %p: Hit TAB for more, or the character to insert%s"
#zstyle ':completion:*' max-errors 3
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*' prompt 'errors: %e'
zstyle :compinstall filename ~/.zshrc

autoload -U compinit
compinit -C
zstyle ':completion:*' special-dirs ..
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-dirs-first true
#zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:functions' prefix-needed true
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*' hosts ${${${(M)${(f)"$(<~/.ssh/config)"}##Host *}#Host }#\*} ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*}
#sort of a hack
function _urls_http() {
local localhttp
zstyle -a ":completion:${curcontext}:urls" local localhttp
[[ -prefix http://$localhttp[1] ]] && return 1
local -a rel relroot abs
reply=(${(f)"$(curl -e ${PREFIX%/*}/ ${PREFIX%/*}/ 2> /dev/null | sed -n 's,.*[Hh][Rr][Ee][Ff]="\([^"]*\)".*,\1,p' )"})
rel=(${${reply:#[^/]#:*}:#/*})
relroot=(${(M)${reply:#[^/]#:*}:#/*})
abs=(${(M)reply:#$PREFIX*})
reply=( ${PREFIX%/*}/$^rel ${(M)PREFIX#http://[^/]#/}$^relroot $abs )
}
zstyle -e ':completion:*:urls' urls '_urls_http'
zstyle ':completion:*:urls' local mika.l3ib.org ~/html html
url() { REPLY=($REPLY(:a)); REPLY=${REPLY//$HOME\/html/http:\/\/mika.l3ib.org} }
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST
#zstyle ':completion::complete:cd::' tag-order local-directories path-directories
zstyle -e :completion::complete:cd::path-directories ignored-patterns 'reply=( ${(Q)PREFIX}*(-/:q) )'
zstyle ':completion:*:-tilde-::' group-order 'named-directories'
zstyle ':completion::approximate*:*' insert-unambiguous yes
zstyle ':completion:*:descriptions' format "%B---- %d%b"
zstyle ':completion:*:messages' format '%B%U---- %d%u%b'
zstyle ':completion:*:warnings' format '%B%F{9}---- no match for: %d%f%b'
zstyle ':completion:*:corrections' format '%B---- %d %F{11}(errors: %e)%f%b'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*' remove-all-dups 'yes'
zstyle ':completion:*' select-scroll '-10'
zstyle ':completion:*' use-perl 'yes'
#zstyle ':completion:*:processes' command 'ps aux'
#autoload -Uz colors; colors
#zstyle ':completion:*:processes' list-colors "=(#b) #([0-9]#) #([^ ]#)*=$color[cyan]=$color[yellow]=$color[green]"
#zstyle ':completion:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:processes' command 'ps aux --sort=-%cpu'
() {
local arr
arr=( '' 88 2 64 32 54 55 7 8 22 23 )
zstyle ':completion:*:processes' list-colors "=(#b) #[^ ]#${(l:9*9:: #([^ ]#):)}*${(j:=38;5;:)arr}"
}
#autoload colors
#colors
#zstyle ':completion:*:processes' list-colors "=(#b)root(*)=$color[red]=35" #"=(#b)([^ ]##) ##([0-9]##) #([0-9]##.[0-9] ##[0-9]##.[0-9])*==$color[yellow]=$color[green]=$color[red]=$color[green]"
#man pages
zstyle ':completion:*:manuals.*'    insert-sections   true
zstyle ':completion:*:manuals'      separate-sections true
#Make things split words by shell arguments, not spaces
autoload -U select-word-style
select-word-style s

#set up some tags for completing other things
zstyle ':completion:all-matches:*' old-matches only
zstyle ':completion:all-matches::::' completer _all_matches
zle -C all-matches complete-word _generic
zstyle ':completion:pids::::' completer _pids
zle -C pids complete-word _generic
zstyle ':completion:most-recent-file:*' match-original both
zstyle ':completion:most-recent-file:*' file-sort modification
zstyle ':completion:most-recent-file:*' file-patterns '*:all\ files'
zstyle ':completion:most-recent-file:*' hidden all
zstyle ':completion:most-recent-file:*' completer _files
zle -C most-recent-file menu-complete _generic
zstyle ':completion:most-accessed-file:*' match-original both
zstyle ':completion:most-accessed-file:*' file-sort access
zstyle ':completion:most-accessed-file:*' file-patterns '*:all\ files'
zstyle ':completion:most-accessed-file:*' hidden all
zstyle ':completion:most-accessed-file:*' completer _files
zle -C most-accessed-file menu-complete _generic
zstyle ':completion:expand-alias-word:*' complete true

zle -C menu-select-interactive menu-complete _generic
zstyle ':completion:menu-select-interactive:*' menu select interactive

#per-command customizations
zstyle ':completion:*:mplayer:*' file-patterns '*:all-files'
zstyle ':completion:*:gdb::' group-order 'processes'
#zstyle ':completion:*:edit::' file-patterns '*.(c|cpp|cxx|C):source-files:source\ file ^*.(c|cpp|cxx|C):other-files:other\ file'
zstyle ':completion:*:git:*' tag-order - '! plumbing-sync-commands plumbing-sync-helper-commands plumbing-internal-helper-commands'
#zstyle ':completion:*:git:*' group-order main-porcelain-commands

compdef _gnu_generic rm mv df dog localedef watch {,meta}flac ls zsshosh idn touch
compdef _pids pmap procmem pwdx
compdef _git {gitk,qgit}=git-rev-list
compdef _vim edit=gvim

### Load functions and keybindings

# Set up appearance
zle_highlight=(region:underline
               special:bold,bg=black
               default:bg=blue
              )
if [[ x$termcap[Co] = x88 ]]; then
  zle_highlight+=('fg_start_code:\e[38;5;'
                  fg_default_code:88
                  'bg_start_code:\e[48;5;'
                  bg_default_code:88
                  isearch:bg=9
                  suffix:bold,bg=12
                 )
else
  zle_highlight+=(isearch:standout)
fi 2> /dev/null

ZLE_REMOVE_SUFFIX_CHARS=$' \n\t;&|'
ZLE_SPACE_SUFFIX_CHARS='&|'

PROMPT_EOL_MARK=

# Load up some functions that come with zsh
autoload -U zcalc
autoload -U zmv
autoload -U zcp
autoload -U zln
autoload -U copy-earlier-word
zle -N copy-earlier-word
autoload -U edit-command-line
zle -N edit-command-line
autoload -U delete-whole-word-match
zle -N kill-whole-word-match delete-whole-word-match
autoload -U replace-string
zle -N replace-string

if [[ -f ~/.zkbd/$TERM-$VENDOR-$OSTYPE ]]; then
  source ~/.zkbd/$TERM-$VENDOR-$OSTYPE || echo >&2 "Warning: failed to parse zkbd file $TERM-$VENDOR-$OSTYPE"
elif [[ -z $TERM ]]; then
  echo >&2 "Warning: \$TERM is empty!"
else
  echo >&2 "Warning: no zkbd file definition found for $TERM-$VENDOR-$OSTYPE"
fi

# Helper function for using zkbd definitions with less clutter
function zbindkey() {
  [[ "$1" = "-s" ]] && {
    local s=-s
    shift
  }
  [[ -n ${key[$1]} ]] && builtin bindkey $s "${key[$1]}" "$2"
}
# Bind basic keys
zbindkey Alt-Insert     yank
zbindkey Insert         overwrite-mode
zbindkey Delete         delete-char
zbindkey Home           beginning-of-line
zbindkey End            end-of-line
zbindkey PageUp         up-history
zbindkey PageDown       down-history
zbindkey NumReturn      accept-line
zbindkey Shift-Tab      reverse-menu-complete
zbindkey Up             up-line-or-search
zbindkey Down           down-line-or-search
zbindkey Alt-Up         up-history
zbindkey Alt-Down       down-history
zbindkey Control-Up     history-beginning-search-backward
zbindkey Control-Down   history-beginning-search-forward
zbindkey Control-Left   backward-word
zbindkey Control-Right  forward-word
zbindkey Control-Delete kill-whole-word-match #autoloaded
zbindkey Alt-Home       beginning-of-history
zbindkey Alt-End        end-of-history
bindkey "^[h"           backward-char
bindkey "^[n"           forward-char
bindkey "^[c"           up-history
bindkey "^[t"           down-history
bindkey "^[C"           history-beginning-search-backward
bindkey "^[T"           history-beginning-search-forward
bindkey "^[N"           history-search-forward
bindkey "^[H"           history-search-backward
bindkey "^[g"           _backward-to-/
bindkey "^[r"           _forward-to-/
bindkey "^[G"           backward-word
bindkey "^[R"           forward-word
bindkey "^_^U"          accept-search #accepts also completion

# Declare these as custom widget functions
zle -N _exit
zle -N _clearbelowprompt
zle -N _show_surroundings
zle -N _nohist
zle -N _nocdls
zle -N _indicatefreecolor
zle -N _togglecombining
zle -N _showgitstuff
zle -N _showcurrargrealpath
zle -N _title_init
zle -N _fullpath
zle -N _shortpath
zle -N _insert-last-command-output
zle -N _insert-last-line
zle -N _runcmdhiddenurxvt
zle -N _runcmdhiddenrox
zle -N _runhelp
zle -N _runhelpcurrentword
zle -N _trim_to_region
zle -N _narrow_to_region_marked
zle -N randtint
zle -N blacktint
autoload -U _options_to_start
zle -N _options_to_start
zle -N _space_toggle
zle -N _gitref
zle -N _quote_word
zle -N _unquote_word
zle -N _quote_unquote_word
zle -N _reverse_word
zle -N _reverse_transpose_chars
zle -N increase-char _increase_char
zle -N decrease-char _increase_char
zle -N increase-number _increase_number
zle -N decrease-number _increase_number
zle -N accept-line _accept_line
zle -N accept-line-and-down-history _accept_line
zle -N accept-and-hold _accept_line
zle -N self-insert _self_insert
zle -N digit-argument _digit_argument
zle -N neg-argument _digit_argument
zle -N insert-next-word _insert_next_word
zle -N _toggle_region_active
zle -N _hextochar
zle -N _chartohex
zle -N zle-line-init _zle_line_init
zle -N zle-line-finish _zle_line_finish
zle -N _start_paste
zle -N _end_paste
zle -N paste-insert _paste_insert
zle -N _spaceafterpastequote
zle -N self-insert-unmeta-right _self_insert_unmeta_right
zle -N overwrite-mode _overwrite_mode
zle -N swap-case _swap_case

# Bind them
zbindkey F1       _runhelp
zbindkey Alt-F1   _runhelpcurrentword
zbindkey F2       _clearbelowprompt
zbindkey F3       _title_init
zbindkey Shift-F3 _showgitstuff
#zbindkey F4       _nocdls
zbindkey F4       _indicatefreecolor
zbindkey Shift-F4 _togglecombining
zbindkey Control-Insert \
                  _spaceafterpastequote
zbindkey F5       _shortpath
zbindkey F6       _fullpath
zbindkey F7       randtint
zbindkey Alt-F7   blacktint
zbindkey F8       _nohist
zbindkey F9       execute-last-named-cmd
zbindkey Alt-F9   _complete_help
zbindkey F10      execute-named-cmd
zbindkey F11      push-input
zbindkey Alt-F11  get-line
zbindkey F12      describe-key-briefly
bindkey "^[q"     _exit
bindkey "^X^H"    _insert-last-command-output
bindkey "^_^H"    _insert-last-command-output
bindkey "^[p"     _insert-last-line
#bindkey "^[h"     _runhelp
bindkey "^_^Y"    _options_to_start
bindkey "^[^@"    _space_toggle
bindkey "^X^G"    _gitref
bindkey "^_^G"    _gitref
bindkey "^XQ"     _quote_word
bindkey "^X^[q"   _unquote_word
bindkey "^Xq"     _quote_unquote_word
bindkey "^X^R"    _reverse_word
bindkey "^[^T"    _reverse_transpose_chars
bindkey "^[^O"    increase-char
bindkey "^[^E"    decrease-char
bindkey "^_^T"    transpose-words
bindkey "^[^P"    increase-number
bindkey "^[^_"    decrease-number
bindkey "^_^[t"   _trim_to_region
bindkey "^X^I"    _narrow_to_region_marked
bindkey "^_^I"    _narrow_to_region_marked
bindkey "^Z"      _runcmdhiddenurxvt
bindkey "^[^Z"    _runcmdhiddenrox
bindkey "^[e"     insert-next-word
bindkey "^_^R"    _toggle_region_active
bindkey "^_^L"    _show_surroundings
bindkey "^_^E"    _hextochar
bindkey "^_^O"    _chartohex
bindkey "^_."     _showcurrargrealpath
bindkey "^_^D"    list-expand
bindkey "^[~"     swap-case

# Bind custom defined completers
bindkey "^N"      most-recent-file
bindkey "^[^N"    most-accessed-file
bindkey "^X^A"    all-matches
bindkey "^_^A"    all-matches
bindkey "^X^P"    pids
bindkey "^_^P"    pids

# Bind other useful stuff
#bindkey "^[e"  expand-word
#bindkey "^[r"  overwrite-mode
bindkey "^r"   history-incremental-pattern-search-backward
bindkey "^[^r" history-incremental-pattern-search-forward
bindkey "^U"   undo
bindkey "^[o"  edit-command-line #autoloaded
bindkey "^Y"   redo
bindkey "^[,"  copy-earlier-word #autoloaded
bindkey "^X^M" accept-and-menu-complete
bindkey "^[m"  menu-select-interactive
bindkey "^X^E" expand-cmd-path
bindkey "^X^W" where-is
bindkey "^[^K" kill-whole-line
bindkey "^X^L" reset-prompt
bindkey "^V"   vi-quoted-insert
bindkey "^XR"  replace-string
bindkey "^[j"  backward-char
bindkey "^[k"  forward-char
bindkey "^[ "  self-insert-unmeta-right

# Hooks
bindkey -N paste
bindkey -R -M paste "^@"-"\M-^?" paste-insert
bindkey '^[[200~' _start_paste
bindkey -M paste '^[[201~' _end_paste
bindkey -M paste -s '^M' '^J'

# Unbind defaults that conflict with keychains
bindkey -r "^_"

# These characters are used for $histchars
bindkey "^F" self-insert
bindkey "^B" self-insert

# Shortcut keybinds
function _runcmdpushinput_ls () {
  zle .push-input
  BUFFER=\ ${WIDGET##*_}
  zle .accept-line
}
zle -N _runcmdpushinput_ls
bindkey '^[v' _runcmdpushinput_ls
#bindkey -s '^[v' "${key[F11]} ls
#"
#bindkey -s '^[n' "${key[F11]} n
#"

# isearch overrides hooks when accepting, so don't
bindkey -M isearch '^M' accept-search
bindkey -M isearch '^J' accept-search

### Functions

## Some helper functions

function _numbertoword() {
  local words
  words=(rat clam mole bee emu newt goat frog lion dog bat vole ant wasp bear wolf seal dodo mink eel oxen cat hawk fox yak owl swan crow pig slug elk)
  [[ $UID = 0 ]] && words=(${(U)words})
  [[ $UID = 0 ]] && REPLY='['
  REPLY+=$words[$1%$#words+1]$1
  [[ $UID = 0 ]] && REPLY+=']'
}

function _getcol() {
  local -A cmds
  local -a array
  local slice ret
  cmds[rtorrent]=red
  cmds[(mplayer|*.(${(j:|:)${(@k)saliases[(R)mplayer*]}}))]=darkblue
  array=(${(z)1})
  slice=$array[1]
  ret=${${${cmds[(K)$slice]}[1]}:-blue}
  if [[ -z $2 ]]; then
    echo $ret
  else
    typeset -g $2=$ret
  fi
}

#for changing a *term title
function ct() {
  local MATCH
  if [[ "$1" = "-e" ]]; then
    #nulls terminate the string when printed, so change them
    if [[ $TERM = rxvt-unicode ]]; then
      printf '\0\e:\e]0;%s\007' ${${${2//$'\x00'/\^@}//
/\\n}//(#m)[$'\x00'-$'\x1f']/$'\x16'$MATCH}
    else
#   #(q) instead of (V) is also an option
      printf '\0\e]0;%s\007' ${${2//
/\\n}//(#m)[$'\x00'-$'\x1f']/${(V)MATCH}}
    fi
  elif [[ "$1" = "-t" ]]; then
    pts="$2"
    ct -e "$3" > /dev/pts/$pts
  else
    ct -e "$*"
  fi
}

function cursorcol() {
  printf '\e]12;%s\a' $1
}

function cursorcol_normal() {
  case $ZLE_STATE in
    *overwrite*)
      cursorcol green
      ;;
    *)
      [[ $UID = 0 ]] && cursorcol red || cursorcol \#A6CAF4
      ;;
  esac
}

function _update_title() {
  if [ -n "$BUFFER" ]; then
    local REPLY r1 r2
    #r1=$RBUFFER[1]
    #r2=$RBUFFER[2,-1]
    #if [[ $r1 = [[:space:]] ]]; then
    #  r1=_
    #elif [[ -z $r1 ]]; then
    #  r1=_
    #elif (( ${(m)#r1} == 2 )); then
    #  r1=$r1$'\u035f'
    #else
    #  r1=$r1$'\u0332'
    #fi
    _numbertoword $TTY:t
    #ct -e "${HINDI}$REPLY <$LBUFFER$r1$r2>"
    ct -e "${HINDI}$REPLY <$LBUFFERâ—ˆ$RBUFFER>"
  else
    precmd
  fi
}

function toggleopt() {
  [[ $options[$1] = on ]] && setopt no$1 || setopt $1
}
compdef toggleopt=setopt

## Hooks

[[ -t 1 ]] && { # no terminal as output?
#XXX Need to refactor this so useful stuff isn't only in the urxvt case
  case $TERM in
    *xterm*|rxvt*|(dt|k|E)term)

    zstyle ':vcs_info:*' actionformats %b %a
    zstyle ':vcs_info:*' formats %b
    zstyle ':vcs_info:*' max-exports 2
    zstyle ':vcs_info:*' enable git hg svn
    zstyle ':vcs_info:(hg|svn):*' formats '%b[%s]'
    function precmd_git() {
      local vcs_info_msg_{0..1}_

      psvar[3,4]=
      [[ ! "$_SHOWGITSTUFF" = 1 ]] && [[ "$PWD" != /home/mikachu/code/* ]] && return
      autoload -Uz vcs_info
      vcs_info
      psvar[3]=$vcs_info_msg_0_
      psvar[4]=$vcs_info_msg_1_
    }

    _zsh_date=$(strftime %x $EPOCHSECONDS)
    function pre{exec,cmd}_datechange() {
      local newdate
      newdate=$(strftime %x $EPOCHSECONDS)
      if [[ $_zsh_date != $newdate ]]; then
        printf "Date changed from %s to %s\n" $_zsh_date $newdate
        _zsh_date=$newdate
      fi
    }

    function precmd_showtime() {
      if ! (( ${+_zsh_time} )); then return 0; fi
      if (( $EPOCHSECONDS - $_zsh_time > 10 )); then
        printf "%i seconds elapsed\n" $(( EPOCHSECONDS - _zsh_time ))
      fi
      unset _zsh_time
    }

    function preexec_recordtime() {
      _zsh_time=$EPOCHSECONDS
    }

    function precmd() {
      [[ "$_INDICATE_FREE_COLOR" = 1 ]] && tint green
      precmd_git
      local REPLY
      _numbertoword $TTY:t
      ct "${HINDI}$REPLY {${(%):-"%100<...<%~%<<"}}"
      precmd_showtime
      precmd_datechange
      cursorcol_normal
    }
    ;;
  *screen*)
    function precmd() {
      print -Pn "\033]0;S $TTY:t${HINDI}{%100<...<%~%<<}\007"
    }
    ;;
  *)
    function precmd() {}
  esac

  case $TERM in
    *xterm*|rxvt*|(dt|k|E)term)
    function preexec () {
      local REPLY cmd="$1" time
      [[ "$_INDICATE_FREE_COLOR" = 1 ]] && () {local REPLY; _getcol "$cmd" REPLY; tint ${REPLY}:500}
      if [ "$#1" -gt 512 ];then 1=${1[1,509]}...; fi
      _numbertoword $TTY:t
      strftime -s time "%x %T" $EPOCHSECONDS
      ct -e "${HINDI}$REPLY [$1] {${(%):-"%100<...<%~%<<"}} $time"
      preexec_datechange
      preexec_recordtime
      cursorcol_normal
    }
#`"
    ;;
    *screen*)
    function preexec () {
      local REPLY
      _numbertoword $TTY:t
      print -Pn "\033]0;S $REPLY${HINDI}[${${${${1## #}/(#s)[[:upper:]]#=[[:alnum:]]# /}##(fakeroot|time|exec|sudo) }%% *}] {%100<...<%~%<<}\007"
    }
    ;;
  esac
}

function chpwd() {
  stty -echo >& /dev/null
  test -f .tdldb && tdll -1 >&2
    test -d .git &&
    {
      git brunch
      test -d .git/svn &&
      {
        echo -n r
        git svn find-rev master
      }
      git name-rev HEAD
      git describe --tags HEAD 2> /dev/null
    } >&2
  if [[ "$_NONOCDLS" = 1 ]]
  then
    ls $LS_OPTIONS >&2
  fi
}

function zsh_directory_name () {
  case $1 in
    d)
      return 1
    ;;
    n)
      local arg="${2[2,-1]}"
      local -a ret
      case $2 in
        /*)
          ret=( /${(j:/:)${(s:/:)PWD}[1,(er)$arg]} )
        ;;
        .*)
          ret=( (../)##$arg([1]) )
        ;;
        c*)
          ret=( $^cdpath/$arg(N) )
          ret=( $ret[1] )
        ;;
        a*)
          ret=( "${${$(bs file $arg)}:h}" )
        ;;
        A*)
          ret=( "$(bs file $arg)" )
        ;;
        o*)
          local wantdir=0
          [[ $arg[-1] == / ]] && { wantdir=1; arg[-1]= }
          ret=( "/proc/$arg/cwd" )
          zstat -A ret +link $ret 2> /dev/null
          (( $wantdir )) && ret=($ret(:h))
        ;;
        m*)
          local -a fds pids
          local fd pts target pid ppid wantdir=0
          [[ $arg[-1] == / ]] && { wantdir=1; arg[-1]= }
          fd=${arg#*:}
          pts=${arg%:*}
          pids=( $(pidof mplayer) )
          # prune caching processes
          for pid in $pids; do
            ppid=${=${$(</proc/$pid/stat)%%*)}[3]}
            # remove the child as they are more short-lived
            (( $pids[(I)$ppid] )) && pids[(r)$pid]=()
          done
          for pid in $pids; do
            zstat -A target +link /proc/$pid/fd/2
            if test $target(:t) = $pts; then
              zstat -A ret +link /proc/$pid/fd/$fd
              (( $wantdir )) && ret=($ret(:h))
              break
            fi
          done
        ;;
        M*)
          local pid fd wantdir=0
          [[ $arg[-1] == / ]] && { wantdir=1; arg[-1]= }
          fd=${arg#*:}
          pid=${arg%:*}
          zstat -A ret +link /proc/$pid/fd/$fd 2> /dev/null
          (( $wantdir )) && ret=($ret(:h))
        ;;
      esac
      if (( $#ret )); then
        reply=( $ret )
        return 0
      else
        return 1
      fi
    ;;
    c)
      local -a types vals description
      types=( '.:children of parent directories' '/:pwd segment' 'c:cdpath' 'a:dir of file in audacious' 'A:file in audacious' 'o:cwd of running process' 'M:files open by mplayer by pid' 'm:files open by mplayer in pts' )
      case $PREFIX in
        '')
          vals=( $types )
          _describe 'dynamic dir type' vals -V dynamic-dirs -o -S ''
        ;;
        .*)
          vals=( (../)##*~(../)##$PWD:t(/:t) )
        ;|
        /*)
          vals=( ${${(s:/:)PWD}[1,-2]} )
        ;|
        c*)
          vals=( $^cdpath/*(N-/:t) )
        ;|
        a* | A*)
          local range=5 before after index num
          local -a plinfo file
          plinfo=( ${(f)"$(bs playlistposition playlistlength)"} )
          before=$(( $plinfo[1] - range ))
          if (( before > 1 )); then; before=$range; else; (( before = before + range - 1 )); fi
          after=$(( $plinfo[2] - $plinfo[1] - range ))
          if (( after > 1 )); then; after=$range; else; (( after = after + range )); fi
          vals=( -{$before..1} +{0..$after} )
          num=$#vals
          for index in {$num..1}; do
            file[index*2-1]=(file)
            file[index*2]=($vals[index])
          done
          file=( ${(f)"$(bs $file)"} )
          for index in {1..$num}; do
            description[index]=("$vals[index]: $file[index]")
          done
        ;|
        o*)
          local pid dir comm
          local -A dups
          vals=( /proc/<->(nu:$USER::t) )
          for pid in $vals; do
            dir="$(zstat +link /proc/$pid/cwd 2> /dev/null)"
            if (( $+dups[$dir] )); then
              vals[(r)$pid]=()
              continue
            fi
            dups[$dir]=1
            comm="$(cat /proc/$pid/comm 2> /dev/null)"
            description+=( "${(r:22:):-${comm}[$pid]} $dir" )
          done
        ;|
        m*)
          local -a fds pids pts
          local fd target pid ppid
          pids=( $(pidof mplayer) )
          # prune caching processes
          for pid in $pids; do
            ppid=${=${$(</proc/$pid/stat)%%*)}[3]}
            # remove the child as they are more short-lived
            (( $pids[(I)$ppid] )) && pids[(r)$pid]=()
          done
          fds=( /proc/${^pids}/fd/*(@) )
          for fd in $fds; do
            zstat -A target +link $fd
            if test -f $target; then
              target=( $target(:h) )
              description+=( "$pts:${fd:t} $target" )
              vals+=( $pts:${fd:t} )
            elif [[ $fd = */2 ]]; then
              if test -c $target; then
                pts=($target(:t))
              else
                break
              fi
            fi
          done
          typeset -U vals
        ;|
        M*)
          local -a fds pids
          local fd target pid ppid
          pids=( $(pidof mplayer) )
          # prune caching processes
          for pid in $pids; do
            ppid=${=${$(</proc/$pid/stat)%%*)}[3]}
            # remove the child as they are more short-lived
            (( $pids[(I)$ppid] )) && pids[(r)$pid]=()
          done
          fds=( /proc/${^pids}/fd/*(@) )
          for fd in $fds; do
            zstat -A target +link $fd
            test -f $target && {
              pid=${${(s:/:)fd}[2]}
              target=( $target(:h) )
              description+=( "$pid:${fd:t} $target" )
              vals+=( $pid:${fd:t} )
            }
          done
          typeset -U vals
        ;|
        [./caAomM]*)
          (( ${description:+1} )) || description=( "$vals[@]" )
          _wanted -V dynamic-dirs expl ${${types[(r)$PREFIX[1]*]}[3,-1]} compadd -P $PREFIX[1] -qQS / -d description - ${(q)^vals}\]
        ;;
        *)
          _message "dynamic directory name: $PREFIX[1] isn't really a thing."
          return 1
      esac
    ;;
  esac
}

command_not_found_handler() { 
  if autoload +X $1 >& /dev/null; then
    $1 "${(@)argv[2,-1]}"
    return 0
  else
    return 1
  fi
}

## Widget functions

# Some hooks into accept-line
if [[ -n "$ZSHRUN" ]]; then
  unset ZSHRUN
  unsetopt correct
  function _accept_and_quit() {
  local -a buf
  buf=(${(z)BUFFER})
  if which $buf[1] >& /dev/null; then
    zsh -c "${BUFFER}" &|
    exit
  else
    zle -M "Command $buf[1] not found"
  fi
  }
  zle -N _accept_and_quit
  bindkey "^M" _accept_and_quit
fi

function _accept_line () {
  if [[ $CONTEXT = vared ]]; then
    zle .$WIDGET
    return
  fi
  if [[ "$BUFFER" = ../[^[:blank:]]##/cu\ #* ]]; then
    BUFFER="cd $BUFFER"
  elif [[ "$BUFFER" = [[:xdigit:]](#c7,40).(#c2,3)[[:xdigit:]](#c7,40)(|\ *) ]]; then
    BUFFER="qgit $BUFFER"
  elif [[ "$BUFFER" = [[:xdigit:]](#c7,40) ]]; then
    if git rev-parse 2> /dev/null; then
      if git cat-file -e "$BUFFER" 2> /dev/null; then
        BUFFER="git show $BUFFER|edit -"
      else
        zle -M "Not a valid object sha-1."
        return
      fi
    else
      zle -M "Not a git repo."
      return
    fi
  fi
  psvar[1]=$_postacceptcolor
  zle .reset-prompt
  psvar[1]=$_preacceptcolor
  __zle_line_accepted=2
  zle .$WIDGET
}

#I completely forgot this can also be worked around by using =~ instead of =
##work around the fact that zle-line-pre-redraw overwrites some static vars
##used by isearch
#function _line_redraw_abort() {
#  zle -D zle-line-pre-redraw 2> /dev/null
#  zle .$WIDGET
#}
#zle -N history-incremental-pattern-search-backward _line_redraw_abort
#zle -N history-incremental-pattern-search-forward _line_redraw_abort
#zle -N history-incremental-search-backward _line_redraw_abort
#zle -N history-incremental-search-forward _line_redraw_abort

function _zle_line_init() {
  zle -N zle-line-pre-redraw _line_redraw
  # Tell urxvt to send escape codes around a paste
  [[ $TERM == rxvt-unicode || $TERM = xterm ]] && printf '\e[?2004h'
}

function _zle_line_finish() {
  ZLE_LINE_ABORTED=$BUFFER
  # Tell it to stop
  [[ $TERM == rxvt-unicode || $TERM = xterm ]] && printf '\e[?2004l'
}

function _recover_line_or_else() {
  if [[ -z $BUFFER && $CONTEXT = start && -n $ZLE_LINE_ABORTED && $ZLE_LINE_ABORTED != $history[$((HISTCMD-1))] ]]; then
    LBUFFER+=$ZLE_LINE_ABORTED
    unset ZLE_LINE_ABORTED
  else
    zle .up-history
  fi
}
zle -N up-history _recover_line_or_else

function _start_paste() {
  bindkey -A paste main
}

function _end_paste() {
  bindkey -e
  if [[ $_SPACE_AFTER_PASTE_QUOTE = 1 ]]; then
    LBUFFER+=${(q)_paste_content}' '
  else
    LBUFFER+=$_paste_content
  fi
  unset _paste_content
}

function _spaceafterpastequote() {
  if [[ $_SPACE_AFTER_PASTE_QUOTE = 1 ]]; then
    _SPACE_AFTER_PASTE_QUOTE=0
    zle -M "Not inserting a space after pastes, not quoting"
  else
    _SPACE_AFTER_PASTE_QUOTE=1
    zle -M "Inserting a space after pastes and quoting"
  fi
}

function _self_insert_unmeta_right() {
  local NUMERIC=-1
  zle .self-insert-unmeta
}

function _overwrite_mode() {
  zle .$WIDGET
  cursorcol_normal
}

function _swap_case() {
  local pos char start end
  if (( REGION_ACTIVE )); then
    if ((MARK < CURSOR)); then
      start=$MARK
      end=$CURSOR
    else
      start=$CURSOR
      end=$MARK
    fi
  else
    if [[ $#BUFFER = $CURSOR ]]; then
      ((CURSOR--))
    fi
    start=$CURSOR
    end=$((CURSOR+${NUMERIC:-1}))
    NUMERIC=1
  fi
  for (( pos=start+1; pos < end+1; pos++ )); do
    char=$BUFFER[pos]
    if [[ $char = [[:upper:]] ]]; then
      char=${(L)char}
    elif [[ $char = [[:lower:]] ]]; then
      char=${(U)char}
    fi
    BUFFER[pos]=$char
    (( !REGION_ACTIVE )) && zle .forward-char
  done
}

# just type '...' to get '../..'
rationalise-dot() {
  local MATCH
  if [[ $LBUFFER =~ '(^|/| |	|'$'\n''|\||;|&)\.\.$' ]]; then
    LBUFFER+=/
    zle self-insert
    zle self-insert
  else
    zle self-insert
  fi
}
zle -N rationalise-dot
bindkey . rationalise-dot
# without this, typing a . aborts incremental history search
bindkey -M isearch . self-insert

#tracks written text in titlebar
#todo
#make it work properly :)
function _title_init() {
  # this uses a custom patch
  if [ $_NO_SHOW_TITLE ]; then
    unset _NO_SHOW_TITLE
    zle -D zle-line-edited
    precmd
  else
    _NO_SHOW_TITLE=1
    zle -N zle-line-edited _update_title
  fi
}

#This uses =~ to avoid conflicting with isearch (some static vars get overwritten)
function _line_redraw_brace_detect() {
  local char=$BUFFER[pos]
  if [[ $char =~ '\(' ]]; then
    dir=1
    that=')'
  elif [[ $char =~ '\)' ]]; then
    dir=-1
    that='('
  elif [[ $char =~ '\[' ]]; then
    dir=1
    that=']'
  elif [[ $char =~ '\]' ]]; then
    dir=-1
    that='['
  elif [[ $char =~ '\{' ]]; then
    dir=1
    that='}'
  elif [[ $char =~ '\}' ]]; then
    dir=-1
    that='{'
  fi
}

function _line_redraw() {
  unset region_highlight

  [[ $__zle_line_accepted -gt 0 ]] && {
    (( __zle_line_accepted-- ))
    return
  }

  #same reason for =~ here as above
  if [[ $POSTDISPLAY[1,3] =~ '|<<' && $PREDISPLAY[-3,-1] =~ '>>|' ]]; then
    # we are in narrow-to-region-marked, highlight the markers
    region_highlight=("P$(( $#PREDISPLAY - 3 )) $#PREDISPLAY fg=9,bg=blue,bold" "P$(( $#PREDISPLAY + $#BUFFER )) $(( $#PREDISPLAY + $#BUFFER + 3 )) fg=9,bg=blue,bold")
  fi

  #this stuff is so slow
  [[ $#BUFFER -gt 250 ]] && { zle -D zle-line-pre-redraw; return }

  local -a hackcol
  hackcol=(red cyan)
  local i
  for i in 0 1; do () {
    #hilight matching parens,braces,brackets
    local ct=1 pos=$((CURSOR+i)) cpos dir this that
    _line_redraw_brace_detect
    #(( ! dir )) && {
    #  (( pos-- ))
    #  _line_redraw_brace_detect
    #}
    (( ! dir )) && continue
    this=$BUFFER[pos]
    cpos=$pos
    #can i use a (I:something:b:something) subscript instead of the loop?
    while (( ((dir > 0) ? (pos < $#BUFFER) : pos > 0) && ct )) {
      (( pos+=dir ))
      [[ $BUFFER[pos] == $that ]] && (( ct-- ))
      [[ $BUFFER[pos] == $this ]] && (( ct++ ))
    }
    (( ct )) ||
      region_highlight+=("$((cpos-1)) $cpos bold,bg=${hackcol[i+1]},fg=black"
                        "$((pos-1)) $pos bold,bg=${hackcol[i+1]},fg=black")
  }; done
#  local index=1 pos oldpos=0 region_highlight_tmp
#  while [[ ${pos::="$BUFFER[(in:index++:)[[:space:]]]"} -lt $#BUFFER ]]; do
#    region_highlight_tmp+=("$oldpos $((pos-1)) bg=$((index%88))")
#    oldpos=$pos
#  done
#  region_highlight_tmp+=("$oldpos $#BUFFER bg=$((index%88))")
#  region_highlight=($region_highlight_tmp)
}

function _toggle_region_active() {
  (( REGION_ACTIVE = !REGION_ACTIVE ))
}

#NUMERIC controls how many characters to the left to include, default is 4.
#Give it negatively to use decimal instead of hex.
function _hextochar() {
  local pos=$CURSOR unit
  unit=0x
  (( NUMERIC < 0 )) && {
    (( NUMERIC = -NUMERIC ))
    unit=
  }
  [[ ${+NUMERIC} != 1 ]] && {
    (( CURSOR > 4 )) && NUMERIC=4 || NUMERIC=CURSOR
  }
  
  BUFFER[CURSOR-NUMERIC+1,CURSOR]=${(#):-$unit$BUFFER[CURSOR-NUMERIC+1,CURSOR]}
  (( CURSOR = pos - NUMERIC + 1 ))
}

function _chartohex() {
  local char new pos
  pos=$CURSOR
  char=$BUFFER[CURSOR]
  if [[ ${+NUMERIC} == 1 ]]; then
    (( new = [##10] #char ))
  else
    (( new = [##16] #char ))
  fi
  BUFFER[CURSOR]=$new
  (( CURSOR = pos + $#new - 1 ))
}

function _paste_insert() {
  _paste_content+=$KEYS
}

function _self_insert() {
  # Don't OOM if you accidentally press some big numeric without watching.
  if (( NUMERIC > 1000 )) || (( NUMERIC < -1000)); then
    zle -M "Unsetting NUMERIC"
    unset NUMERIC
  fi
  zle .self-insert
}

function _self_insert_git() {
  if [[ $BUFFER = (git(-| )|gitk |qgit )* ]]; then
    if [[ ! $LBUFFER[-1] = '\' ]]; then
      LBUFFER+='\'
    fi
    fi
  _self_insert
}

zle -N self-insert-git _self_insert_git
bindkey '~' self-insert-git
bindkey '^' self-insert-git
bindkey -M isearch '~' self-insert
bindkey -M isearch '^' self-insert

# Display NUMERIC too
function _digit_argument () {
  if [[ $WIDGET = neg-argument ]]; then
    if [[ -n $NUMERIC ]]; then
      zle -M - ""
    else
      zle -M - -
    fi
  elif [[ $LASTWIDGET = neg-argument ]]; then
    zle -M - "$((NUMERIC * $KEYS[-1] ? NUMERIC * $KEYS[-1] : $KEYS[-1]))"
  else
    zle -M - "$NUMERIC$KEYS[-1]"
  fi
  zle .$WIDGET
}

function _exit() {
  zle kill-buffer
  if [[ $SHLVL -gt 1 ]]; then
    psvar[1]=$_postacceptcolor
    psvar[9]=exit
    zle .reset-prompt
  fi
  exit
}

function _clearbelowprompt() {
  zle -M ""
}

function _show_surroundings() {
  #zle -M ${"$(eval 'for a in $history[(I)<'$((HISTNO-10))-$((HISTNO+10))'>]; do if [[ $a -eq $HISTNO ]]; then printf '\''\n%s: %s\n\n'\'' $a $history[$a]; else; printf '\''%s: %s\n'\'' $a $history[$a]; fi; done')"}
  #zle -M ${"$(eval 'for a in $history[(I)<'$((HISTNO-10))-$((HISTNO+10))'>]; do printf '\''%s: %s\n'\'' $a $history[$a]; done')"}
  (( $LINES < 5 )) && { zle -M ""; return }
  local bound line i
  typeset -a output
  typeset -A star
  bound=${NUMERIC:-$(( LINES < 10 ? 1 : LINES / 3 ))}
  star[$HISTNO]="*"
  for ((i = HISTNO - $bound; i < HISTNO + $bound && i < HISTCMD; i++)); do
    line="${${:-$star[$i]$i: $history[$i]}[1,COLUMNS-1]}"
    while (( ${(m)#line} > COLUMNS-1 )); do
      line[-1]=
      #for broken zsh#line=$line[1,-2]
    done
    output=( $line $output )
  done
  zle -M ${(pj:\n:)output}
}
zle -N zle-isearch-update _show_surroundings
zle -N zle-isearch-exit _clearbelowprompt

function _nohist() {
  if [[ "$HINDI" = "" ]]
    then
      unset HISTFILE
      export HINDI="#"
    else
      unset HISTFILE
      HISTFILE=~/.history
      export HINDI=""
  fi
  if [[ -n "$HISTFILE" ]]
    then
      zle -M "Using history file $HISTFILE"
    else
      zle -M "Not using history file"
  fi
  precmd
}

function _indicatefreecolor() {
  if [[ "$_INDICATE_FREE_COLOR" != "1" ]]
    then
      _INDICATE_FREE_COLOR=1
      tint green
      zle -M "Indicating running commands with blue bg and free terminal with green"
    else
      _INDICATE_FREE_COLOR=0
      zle -M "Not changing colour when running commands"
  fi
}

function _togglecombining() {
  toggleopt combiningchars
}

function _nocdls() {
  if [[ "$_NONOCDLS" != "1" ]]
    then
      _NONOCDLS=1
      zle -M "Now doing ls when dir changes"
    else
      _NONOCDLS=0
      zle -M "Stop doing ls when changing dir"
  fi
}

function _showcurrargrealpath() {
  setopt localoptions nullglob #this was nonomatch, why?
  local REPLY REALPATH
  _split_shell_arguments_under
  #zle -M "$(realpath ${(Q)${~REPLY}} 2> /dev/null | head -n1 || echo 1>&2 "No such path")"
  REALPATH=( ${(Q)${~REPLY}}(:A) )
  zle -M "${REALPATH:-Path not found: $REPLY}"
}

function _showgitstuff() {
  if [[ "$_SHOWGITSTUFF" != "1" ]]
    then
      _SHOWGITSTUFF=1
      precmd
      zle .reset-prompt
      zle -M "Now showing git stuff"
    else
      _SHOWGITSTUFF=0
      psvar[2,4]=
      precmd
      zle .reset-prompt
      zle -M "Stop showing git stuff"
  fi
}

function _runcmdhiddenurxvt() {
  unset SHLVL
  _runcmdhidden urxvt -geometry ${COLUMNS}x${LINES}
}

function _runcmdhiddenrox() {
  _runcmdhidden rox
}

function _runhelp() {
  local lookup
  if [[ "$CURSORCOMMAND" = git ]]; then
    # tiny bug here, want CURSOR+1 so you get the right result when on the
    # first letter, but then it breaks when at the end of the line which is
    # the far more common case.
    lookup=git-${${(z)BUFFER[(b:CURSOR:R)$CURSORCOMMAND,-1]}[2]}
  else
    lookup=$CURSORCOMMAND
  fi
  _runcmdhidden man $lookup
}

function _runhelpcurrentword()
{
  local REPLY
  _split_shell_arguments_under
  _runcmdhidden man $REPLY
}

function _runcmdhidden() {
  "$@" >& /dev/null < /dev/null &|
}

case $TERM in
  rxvt*)
    function randtint() {
      echo -en '\e]705;random\007'
    }
    function blacktint() {
      echo -en '\e]705;black\007'
    }
    function tint() {
      echo -en '\e]705;'"$1"'\007'
    }
    function fade() {
      [[ -n "$1" ]] && echo -en '\e]714;'"$1"'\007'
      [[ -n "$2" ]] && echo -en '\e]709;'"$2"'\007'
    }
  ;;
  *)
    function randtint(){}
    function blacktint(){}
  ;;
esac

function setcol () {
  echoti initc $1 $(( 16#${2[1,2]} * 1000 / 255 )) $(( 16#${2[3,4]} * 1000 / 255 )) $(( 16#${2[5,6]} * 1000 / 255 ))
}

function _insert-last-command-output () {
  local hist=$history[$((HISTCMD-1))] REPLY

  autoload -U read-from-minibuffer
  read-from-minibuffer -k1 "Do you want to execute $hist again y/[n]? " && [[ $REPLY = [yY]* ]] || return 1
  LBUFFER+=${(j: :)${(qf)"$(eval $hist 2> /dev/null)"}}
}

function _insert-last-line () {
  LBUFFER+="$history[$((HISTNO-1))]"
}

function _fullpath() {
  PS1="$PS1:s/\%~/%d/:s/40</400</"
  zle reset-prompt
}
function _shortpath() {
  PS1="$PS1:s/\%d/%~/:s/400</40</"
  zle reset-prompt
}

autoload -U narrow-to-region
function _narrow_to_region_marked()
{
  local right
  local left
  local OLDMARK=MARK
  if ((REGION_ACTIVE == 0)); then
    MARK=CURSOR
  fi
  if ((MARK < CURSOR)); then
    left="$LBUFFER[0,$((MARK-CURSOR-1))]"
    right="$RBUFFER"
  else
    left="$LBUFFER"
    right="$BUFFER[$((MARK+1)),-1]"
  fi
  narrow-to-region -p "$left>>|" -P "|<<$right"
  _line_redraw #update highlight stuff doesn't happen here otherwise
  MARK=OLDMARK
}

function _trim_to_region()
{
  if (( ! REGION_ACTIVE )) || (( MARK == CURSOR )); then
    return
  fi
  zle .kill-region
  BUFFER=$CUTBUFFER
}

function _space_toggle()
{
  if [[ $BUFFER[1] != " " ]]; then
    BUFFER=" $BUFFER"
    (( CURSOR+=1 ))
    (( MARK+=1 ))
  else
    (( MARK-=1 ))
    (( CURSOR-=1 ))
    BUFFER[1]=
  fi
}

function _reverse_word()
{
  modify-current-argument '${(j::)${(@Oa)${(s::)ARG}}}'
}

#function magic-abbrev-expand() {
#  local -A abbrevs
#  abbrevs=(
#  "Im"    "| more"
#  "Ia"    "| awk"
#  "Ig"    "| grep"
#  "Ieg"   "| egrep"
#  "Iag"   "| agrep"
#  "Igr"   "| groff -s -p -t -e -Tlatin1 -mandoc"
#  "Ip"    "| $PAGER"
#  "Ih"    "| head"
#  "Ik"    "| keep"
#  "It"    "| tail"
#  "Is"    "| sort"
#  "Iv"    "| ${VISUAL:-${EDITOR}}"
#  "Iw"    "| wc"
#  "Ix"    "| xargs"
#  )
#  modify-current-argument '${abbrevs[$ARG]:-$ARG}'
#  zle self-insert
#}
#
#zle -N magic-abbrev-expand
#bindkey ' ' magic-abbrev-expand

function _reverse_transpose_chars () {
  zle .backward-char; zle .transpose-chars; zle .backward-char
}

function _increase_char() {
  local char

  [[ $#BUFFER -le 0 ]] && return

  char=$BUFFER[CURSOR]

  if [[ $WIDGET = increase-char ]]; then
    char=${(#):-$((#char+${NUMERIC:-1}))}
  else
    char=${(#):-$((#char-${NUMERIC:-1}))}
  fi

  BUFFER[CURSOR]=$char
}

function _increase_number() {
  integer pos NUMBER i first last prelength diff
  pos=$CURSOR

  i=1
  # find numbers starting from the left of the cursor to the end of the line
  while [[ $BUFFER[pos] != [[:digit:]] ]]; do
    (( pos += i ))
    (( $pos > $#BUFFER )) && i=-1
    (( $pos < 0 )) && return
  done

  # use the numeric argument and default to 1
  # negate if called as decrease-number
  NUMBER=${NUMERIC:-1}
  if [[ $WIDGET = decrease-number ]]; then
    (( NUMBER = 0 - $NUMBER ))
  fi

  # find the start of the number
  i=$pos
  while [[ $BUFFER[i-1] = [[:digit:]] ]]; do
    (( i-- ))
  done
  first=$i

  while [[ $BUFFER[i] = 0 ]]; do
    (( i++ ))
  done
  #zeros=$(( i - first ))

  # include one leading - if found
  if [[ $BUFFER[first-1] = - ]]; then
    (( first-- ))
  fi

  # find the end of the number
  i=$pos
  while [[ $BUFFER[i+1] = [[:digit:]] ]]; do
    (( i++ ))
  done
  last=$i

  # change the number and move cursor after it
  prelength=$#BUFFER
  (( BUFFER[first,last] += $NUMBER ))
#  (( diff = $#BUFFER - $prelength ))
#  print -l :: $zeros $diff > /fifo
#  if (( diff < 0 )); then
#    BUFFER[first,first-1]=${(l:zeros+diff::0:):-}
#  fi
  (( diff = $#BUFFER - $prelength ))
  (( CURSOR = last + diff ))
}

function _quote_word()
{
  local q=qqqq
  modify-current-argument '${('$q[1,${NUMERIC:-1}]')ARG}'
}

function _unquote_word()
{
  modify-current-argument '${(Q)ARG}'
}

function _quote_unquote_word()
{
  local q=qqqq
  modify-current-argument '${('$q[1,${NUMERIC:-1}]')${(Q)ARG}}'
}

autoload -U modify-current-argument
autoload -U split-shell-arguments

function _split_shell_arguments_under()
{
  local -a reply
  split-shell-arguments
  #have to duplicate some of modify-current-argument to get the word
  #_under_ the cursor, not after.
  setopt localoptions noksharrays multibyte
  if (( REPLY > 1 )); then
    if (( REPLY & 1 )); then
      (( REPLY-- ))
    fi
  fi
  REPLY=${reply[$REPLY]}
}

function _gitref()
{
  local REPLY
  local msg="Select one of s, S, t, a, c, v, q, Q, r${${1+.}:-, h (help).}"
  zle -R $msg
  read -k
  case $REPLY in
    (s)
      modify-current-argument '$(git rev-parse --short='${NUMERIC:-4}' ${(Q)ARG} 2> /dev/null)'
    ;;
    (S)
      modify-current-argument '$(git rev-parse ${(Q)ARG} 2> /dev/null)'
    ;;
    (t)
      modify-current-argument '$(git describe --tags ${(Q)ARG} 2> /dev/null)'
    ;;
    (a)
      modify-current-argument '$(git describe --all ${(Q)ARG} 2> /dev/null)'
    ;;
    (c)
      modify-current-argument '${(q)$(git describe --contains ${(Q)ARG} 2> /dev/null)}'
    ;;
    (v)
      if [[ -d $(git rev-parse --show-cdup).git/svn ]]; then
        modify-current-argument '$(git rev-parse --short='${NUMERIC:-4}' $(git svn find-rev r$ARG 2> /dev/null) 2> /dev/null || git svn find-rev $ARG 2> /dev/null)'
      else
        zle -R "Not a git-svn repo."
      fi
    ;;
    (q)
      _quote_word
    ;;
    (Q)
      _unquote_word
    ;;
    (w)
      modify-current-argument '$(git rev-list $ARG 2> /dev/null | wc -l)'
    ;;
    (r)
      local -a match mbegin mend
      modify-current-argument '${ARG//(#b)((#B)(*[^.])#)(#b)(.(#c2,3))((#B)([^.]*)#)/$match[3]$match[2]$match[1]}'
    ;;
    (h)
      [[ $1 = help ]] && return
      _split_shell_arguments_under
      word=$REPLY
      zle -M \
"
s: convert word to sha1, takes numeric argument (default: 4) ($(git rev-parse --short=${NUMERIC:-4} $word 2> /dev/null))
S: convert word to full length sha1 ($(git rev-parse $word 2> /dev/null))
t: convert word to described tag ($(git describe --tags $word 2> /dev/null))
a: convert word to described ref ($(git describe --all $word 2> /dev/null))
c: convert word to contained tag (${(q)$(git describe --contains $word 2> /dev/null)})
v: convert word with git svn find-rev
q: quote word
Q: unquote word
r: change order of range from a..b or a...b to b..a or b...a respectively
h: this help message"
      _gitref help
    ;;
    (*)
      [[ -n $REPLY ]] && repeat ${NUMERIC:-1}; do zle -U - $REPLY; done
    ;;
  esac
  zle -R -c
}

function _insert_next_word() {
  zle .insert-last-word 1 -1
}

## User functions

function shuffle() {
  RANDOM=`date +%N` #nanoseconds are pretty random in this context
  {
  while IFS= read -r i; do
    echo $RANDOM$RANDOM "$i";
  done
  } | sort -n | sed 's/^[0-9]* //'
}

function shufflearray () {
	zmodload zsh/mathfunc
	typeset -a swap
	integer n k
	n=$#reply 
	for ((n += 1; n > 0; n-- )) do
		((k = 1 + int(rand48() * n) ))
		swap=("$reply[k]") 
		reply[k]="$reply[n]" 
		reply[n]=("$swap") 
	done
}

function braceccl() {
  local a
  for a ({$(( #1 ))..$(( #2 ))}) {
    echo -n "${(#)a} "
  }
}

function randomline() {
#modeled after akk's randomline python script, and runs slower :P
  RANDOM=`date +%N`
  local num_lines=0 line picked
  while read line; do
    (( (RANDOM % ++num_lines) == 0 )) && picked=$line
  done
  echo $picked
}

function man () { if [ -z $DISPLAY ] ; then command pinfo -m "$@"; else; urxvt +sb +ip -e pinfo -m "$@" &|:; fi }

#allow su -c command with spaces without quoting the spaces
function suc () {
  local user
  if [[ $1 = -u ]]; then
    user=$2
    shift; shift
  else
    user=root
  fi
  su $user -c "${(pj: :)@}"
}
compdef suc=sudo

function src ()
{
  autoload -U zrecompile
  [ -f ~/.zshrc ] && zrecompile -p ~/.zshrc
  [ -f ~/.zshenv ] && zrecompile -p ~/.zshenv
  [ -f ~/.zcompdump ] && zrecompile -p ~/.zcompdump
  [ -f ~/.zlogin ] && zrecompile -p ~/.zlogin
  [ -f ~/.zlogout ] && zrecompile -p ~/.zlogout
  [ -f ~/.delete-to ] && zrecompile -p ~/.delete-to
  [ -f ~/.zshurxvt ] && zrecompile -p ~/.zshurxvt
  for a ($fpath) {[ -w $a:r -a $a/_*(N[1]) ] && zrecompile -p $a.zwc $a/_*}
  if [[ $UID = 0 ]]; then
    [ -f /etc/profile ] && zrecompile -p /etc/profile
    [ -f /etc/zprofile ] && zrecompile -p /etc/zprofile
    [ -f /etc/profile.env ] && zrecompile -p /etc/profile.env
  fi
  :
}

function tarc () { if [ -e $1 ] ; then if [ -n "$1" ] ; then tar cvjf $1.tar.bz2 $1; fi; fi }
function rarx () { rar x $1/\*.rar }

function dmesgtotimestamp () { strftime %x\ %T $(( EPOCHSECONDS - ${"$(</proc/uptime)"%%.*} + ${${1%%.*}#\[} )) }
function dmesgtimestamp() {
  local line
  dmesg | while read -r line; do
    if [[ $line[1] == '[' ]]; then
      strftime \[%x\ %T\]\ $line[$line[(i)\]]+2,-1]\
      $(( EPOCHSECONDS - ${"$(</proc/uptime)"%%.*} + ${line[2,$line[(i)\]]-1]%%.*}))
    else
      echo -E - $line
    fi
  done
}

function anytoany () { echo $(( [${4+#}#$3] $2#$1 )) }
function dectohex () { anytoany $1 10 16 $2 }
function hextodec () { anytoany $1 16 10 $2 }
function bintohex () { anytoany $1  2 16 $2 }
function bintodec () { anytoany $1  2 10 $2 }
function dectobin () { anytoany $1 10  2 $2 }
function hextobin () { anytoany $1 16  2 $2 }
function octtohex () { anytoany $1  8 16 $2 }
function hextooct () { anytoany $1 16  8 $2 }
function octtodec () { anytoany $1  8 10 $2 }
function dectooct () { anytoany $1 10  8 $2 }
function bintooct () { anytoany $1  2  8 $2 }
function octtobin () { anytoany $1  8  2 $2 }
function bytetombit () { echo $(( $1/1024.0**2*8 )) }
function mbittobyte () { echo $(( $1*1024.0**2/8 )) }
function byteleft() { echo $((33554432 - $1 )). }
alias dvdleft='echo $(( ( 4700000000 - $( du -sb `[[ $PWD = */.par ]] && echo .. || echo .` | sed "s/[^0-9]//g" ) ) /1024.0/1024.0))'

function parseroman () {
  local max=0 sum i j
  local -A conv
  conv=(I 1 V 5 X 10 L 50 C 100 D 500 M 1000)
  for j in ${(Oas::)1}; do
    i=conv[$j]
    if (( i >= max )); then
      (( sum+=i ))
      (( max=i ))
    else
      (( sum-=i ))
    fi
  done
  if (( ${+2} )); then
    : ${(P)2::=$sum}
  else
    echo $sum
  fi
}

function printroman() {
  local -a conv
  local number=$1 div rom num out
  conv=(I 1 IV 4 V 5 IX 9 X 10 XL 40 L 50 XC 90 C 100 CD 400 D 500 CM 900 M 1000)
  for num rom in ${(Oa)conv}; do
    (( div = number / num, number = number % num ))
    while (( div-- > 0 )); do
      out+=$rom
    done
  done
  if (( ${+2} )); then
    : ${(P)2::=$out}
  else
    echo $out
  fi
}

function normalizeroman() {
  local roman=$1
  parseroman $roman roman
  printroman $roman roman
  if (( ${+2} )); then
    : ${(P)2::=$roman}
  else
    echo $roman
  fi
}

function rot () {
  local decode=0
  if [[ $1 == -d ]] {
    decode=1
    shift
  }
  local rot word=$2 i ri=0
  rot=(${(s: :)1})
  if (( decode )) {
    for (( i=1; i<=$#rot; i++ )) {
      (( rot[i] = 26 - $rot[i] ))
    }
  }
  for (( i=1; i<=$#word; i++ )) {
    if [[ $word[i] == [a-z] ]] {
      echo -n ${(#):-$(( ( ##$word[i] - ##a + $rot[ri+1] + 26 ) % 26 + ##a ))}
    } elif [[ $word[i] == [A-Z] ]] {
      echo -n ${(#):-$(( ( ##$word[i] - ##A + $rot[ri+1] + 26 ) % 26 + ##A ))}
    } else {
      echo -n $word[i]
    }
    (( ri = (ri + 1) % $#rot ))
  }
}

function hexip () { hostx $(( 16#$1 )) }
#function hexip () { local a; a=${(j:.:):-$(for a (${1[1,2]} ${1[3,4]} ${1[5,6]} ${1[7,8]}) {hextodec $a})}; hostx $a }
#function hexip () { a=$((16#${1[1,2]})).$((16#${1[3,4]})).$((16#${1[5,6]})).$((16#${1[7,8]})); hostx $a }
function iptodec () {local a; a=(${(s:.:)1}); echo $(( $a[4] + $a[3] * 256 + $a[2] * 256*256 + $a[1] * 256*256*256)) }

function cd () {
  local opt
  # eat options from the beginning
  while case $1 in
    -[qLPs]#|--)
      opt=($opt $1)
      shift
    ;|
    --)
    ;&
    ^(-[qLPs]#))
      false
    ;;
  esac; do :; done
  # eat options from the end, if -- wasn't given
  if [[ $opt[(I)--] == 0 ]]; then; while case $@[#] in
    -[qLPs]#)
      opt=($opt $@[#])
      set -- $@[1,#-1]
    ;;
    *)
      false
    ;;
  esac; do :; done; fi
  if [[ $1:t = "cu" ]]; then
    local dir=$1:h
    shift
    builtin cd -q $opt $dir && {
      preexec cup $@
      cup $@
    }
  else
    if [[ ${+2} = 0 ]]; then
      if [[ -f $1 ]]; then
        builtin cd $opt $1:h
      else
        if ! builtin cd $opt $1 && [[ $#@ -eq 1 && ! -d $1 ]]; then
          echo -En "cd: $1 doesn't exist, do you want to create it? [y/N] "
          read -sq && mkcd $1
        fi
      fi
    else
      if [[ -z $3 ]]; then
        builtin cd $opt "$1" "$2"
      else
        echo cd: too many arguments
      fi
    fi
  fi
}

function mkcd () {
  test -z "$1" && echo >&2 "mkcd: no path given" && return
  test -d "$1" && echo >&2 "mkcd: directory $1 already exists"
  mkdir -p -- "$1"
  cd -- "$1"
}

function concat() {echo -n ${(j::)@}}

#removes scrollbar and cursor
function small() {
if test -n "$1"; then
  echo -n `concat "\033[?"{25,30}l` > /dev/pts/$1
else
  echo -n `concat "\033[?"{25,30}l`
fi
}

#and back
function big() {
if test -n "$1"; then
  echo -n `concat "\033[?"{25,30}h` > /dev/pts/$1
else
  echo -n `concat "\033[?"{25,30}h`
fi
}

function ccsb csb() {
if test -n "$1"; then
  $0 > /dev/pts/$1
else
  test "$0" = ccsb && echoti clear
  printf '\033]720;\007'
fi
}

#prints UTF8_STRINGs from xprop, todo: lollerskates
function uprop() {
print -l `xprop $@|sed -r -e '/^[^\s]+UTF8_STRING/!d' -e 's/ = /'$'\xa0'=$'\xa0'/g -e "s/\s?0x(..),?/\\\\\x\1/g"`
}

function sidebysidenoflip() {
montage "$1" "$2" -adjoin -borderwidth 0 -geometry 640x480 "$3"
}

function sidebysideflip() {
montage "$1" -rotate 90\> "$2" -rotate 90\> -adjoin -borderwidth 0 -geometry 720x960 "$3"
}

function name() {
  [[ $#@ -eq 1 ]] || { echo Give exactly one argument ; return 1 }
  test -e "$1" || { echo No such file or directory: "$1" ; return 1 }
  local newname=$1
  if vared -c -p 'rename to: ' newname &&
    [[ -n $newname && $newname != $1 ]]
  then
    command mv -i -- $1 $newname
  else
    echo Some error occured; return 1
  fi
}

function repoint() {
  [[ $#@ -eq 1 ]] || { echo Give exactly one argument ; return 1 }
  test -h "$1" || { echo No such symlink: "$1" ; return 1 }
  local oldtarget="$(zstat +link "$1")"
  local newtarget=$oldtarget
  if vared -c -p 'repoint to: ' newtarget &&
    [[ -n $newtarget && $newtarget != $oldtarget ]]
  then
    command rm -- "$1"
    command ln -s -- "$newtarget" "$1"
  else
    echo Some error occured; return 1
  fi
}

function note() {
  local SECTION=notes
  local MODE=edit
  local brief=off
  local NOTE
  while true; do
    if [[ $1 = -n ]]; then
      SECTION=$2
      if [[ $# -lt 2 ]]; then
        echo 1>&2 "Option -n requires an argument."
        return
      fi
      shift; shift
    elif [[ $1 = -l ]]; then
      MODE=view
      shift
    elif [[ $1 = -b ]]; then
      brief=on
      MODE=view
      shift
    elif [[ $1 = -h ]]; then
      echo "Usage:"
      echo "$0 -h | [ -l ] [ -n SECTION ] [ -- ] file [ additional files ]"
      echo
      echo "-l          List notes instead of editing."
      echo "-b          Don't list files with no notes (implies -l)."
      echo "-n SECTION  Edit/list section SECTION (default 'notes')."
      echo "--          Terminate option list."
      echo "-h          This help text."
      return
    elif [[ $1 = -- ]]; then
      shift
      break
    elif [[ $1 = -* ]]; then
      echo 1>&2 "Warning: unknown option $1, terminating option list and treating as file."
      echo 1>&2 "         If it is a file, precede it with -- to suppress this warning."
      break
    else
      break
    fi
  done
  if [[ $# = 0 ]]; then
    $0 -h
    return 1
  fi
  for file
  do
    if [[ ! -e $file ]]; then
      echo 1>&2 "No such file or directory: $file"
      continue
    fi
    unset NOTE
    zgetattr $file user.$SECTION NOTE 2> /dev/null
    case $MODE in
    edit)
      if [[ $# -gt 1 ]]; then
        echo $file:
      fi
      OLDNOTE=$NOTE
      vared -c -p "${(C)SECTION}: " NOTE
      if [[ -n $NOTE ]]
      then
        zsetattr $file user.$SECTION $NOTE
      elif [[ -n $OLDNOTE ]]; then
        zdelattr $file user.$SECTION
      fi
    ;;
    view)
      if [[ -n $NOTE || $brief = off ]]; then
        if [[ $# -gt 1 ]]; then
          echo $file:
        fi
        echo -E - "$NOTE"
      fi
    ;;
    esac
  done
}
alias lyrics='note -n lyrics'

function accessinfo() {
  local a
  a=( ${1:-$PWD}(:a) )
  while true; do
    echo ${(l:6:)$(dectooct $(zstat -L +mode $a) 1)} ${(l:5:)$(zstat +uid $a)} $a:t
    [[ $a = / ]] && return
    a=$a:h
  done
}

function tagedit() {
  local tag
  tag="$(vorbiscomment -l $1)"
  vared -p "$1"$'\n' tag
  printf %s "$tag" | vorbiscomment -w $1
}

function debuglink () {
  for a ("$@") {strip --only-keep-debug -o $a.dbg $a; strip --strip-debug -o $a.new $a; mv -f $a.new $a; objcopy --add-gnu-debuglink=$a.dbg $a}
}

function hexdiff () {
  diff -u$4 <(${3:-hexdump} "$1") <(${3:-hexdump} "$2")
}

function urldiff () {
  diff -u <(curl -s "$1") <(curl -s "$2")
}

function cwdiff() {
  dwdiff -C3 -c$'e:\e[91m,e:\e[92m' $1 $2
}

function sumcharvals() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: $0 [string] [mod] [parameter]"
    echo
    echo "sums the char values of string and modulates with mod"
    echo "if parameter is given, assign result to it, otherwise echo"
    return 0
  fi
  local name=$1 sum=0
  integer i
  for (( i=1; i <= $#name; i++ )) {
    (( sum+=##$name[i] ))
  }
  [[ -n $2 ]] && (( sum%=$2 ))
  if [[ -n $3 ]]; then
    typeset -g $3=$sum
  else
    echo $sum
  fi
}

#nice eh
function sumvals{,avg{,float}}{,assign}() {
  local op sum assign
  case $0 in
  *assign)
    assign=$1
    shift
  ;|
  *)
  op=${(j:+:)@}
  ;|
  sumvals(|assign))
    sum=$(( $op ))
  ;|
  sumvalsavg(|assign))
    sum=$(( ( $op ) / $# ))
  ;|
  sumvalsavgfloat(|assign))
    sum=$(( ( $op ) / $#. ))
  ;|
  *assign)
    typeset -g $assign=$sum
  ;;
  *)
    echo $sum
  ;;
  esac
}

function sleep () {
  local extsleep=0
  while (( $# )); do
    if [[ $1 == (<->(.<->(#c,1))(#c,1)|.<->) ]]; then
      zselect -t ${$(( $1 * 100 ))%.[0-9]#} 2> /dev/null
    else
      # got passed weird stuff
      extsleep=1
    fi
    if (( $? == 2 || $? == 127 )); then
      # no select() support or zselect module not loaded
      extsleep=1
    fi
    if (( $extsleep )); then
      command sleep "$@"
      return $?
    fi
    shift
  done
  return $(( $? ))
}

## Only for root
if [[ $UID = 0 ]]; then

  function sshblock() {
    iptables -A INPUT -p tcp --source $1 --dport 22 -j REJECT --reject-with tcp-reset
  }

  function makeoverlay () {
          test -d "$1" || { test -d "/usr/portage/$1" && 1=${1#/usr/portage} } || { echo makeoverlay: package "$1" not found; return 1 }
          mkcd $PORTDIR_OVERLAY/"$1"
          cp -r "/usr/portage/$1"/* .
          return 0
  }
  compdef _portage makeoverlay=emerge

  function addprovided () {
          echo "$@" >> /etc/portage/profile/package.provided
  }

  function pmerge () {
  emerge -va $@ &&
  if ! [[ $@ =~ clean ]]; then
    emerge -va --clean $@
  fi
  }
  #complete above as for emerge
  compdef _portage pmerge=emerge

  alias PT=PORTAGE_TMPDIR=/tmp
fi

## urxvt functions
[[ "$TERM" = rxvt-unicode ]] && source ~/.zshurxvt

source ~/.delete-to

## Glob functions

#usage, *(e:in /other/dir:)
function in() { test -e $1/$REPLY }

#usage, *(e:hastype mp3:)
function hastype() { local a; a=( $REPLY/*.$1([1]N) ); [[ -n $a ]] }

#usage, *(e:fattr name:) or *(e:fattr name value:)
function fattr() {
  local val
  zgetattr $REPLY user.$1 val 2>/dev/null
  [[ -n "$val" && ( -z "$2" || "$val" =~ "$2" ) ]]
}
#fi

#usage *(+torrenttarget) although *.torrent(+torrenttarget) makes more sense
#will cache the target of a torrent in user.file using settorrentattr()
function torrenttarget() {
  local val file
  zgetattr $REPLY user.file val 2>/dev/null
  if [[ -n $val ]]; then
    REPLY=$val
    return 0
  elif [[ $REPLY = *.torrent ]]; then
    settorrentattr $REPLY 2> /dev/null
    REPLY=$file
    [[ -n $REPLY ]]
  else
    return 1
  fi
}

#save the target of a .torrent file in the user.file xattr using btshowmetainfo.py
function settorrentattr() {
  local torrent=$1
  file=$(btshowmetainfo.py $torrent 2> /dev/null | grep '^file name\|^directory name'|cut -b 17-)
  if [[ -n $file ]]; then
    zsetattr $torrent user.file $file
  else
    echo 1>&2 "Couldn't find target file/directory for $torrent"
    return 1
  fi
}

# *(@-) also works
function brokensym() {
  [[ -L $REPLY && ! -e `zstat +link $REPLY` ]]
}
#usage *(@e:matchsym regex:)
function matchsym() {
  local link
  zstat -A link +link $REPLY
  [[ $link =~ "$@" ]]
}
#this is needed for convenience
alias matchsym='noglob matchsym'

#for *(o+romansort)
romansort() {
  REPLY=${REPLY:gs/(#b)( |_|(#s))([IVXLCDM]#)( |_|(#e))/'$match[1]$(parseroman ${match[2]})$match[3]\'}
}

### Math Functions
autoload -U zmathfuncdef
# colour takes red, green, blue (0..3) as arguments
zmathfuncdef colour '16 + $1 * 16 + $2 * 4 + $3'

### Aliases

#emerge aliases
alias eix='noglob eix'
alias iuse='euse -i'
[[ $UID != 0 ]] && alias pmerge='emerge -pv'
[[ $UID = 0 ]] && alias Cmerge='emerge -Cv'
alias cmerge='emerge -p --changelog'
function Smerge () {emerge -s \^"$@"\$}
function select-one () {
  local opt strip i l r p
  local -a alts
  if [[ $1 = -s ]]; then
    strip=$2
    shift; shift
  fi
  if [[ "$#@" -eq 0 ]]; then
    return 1
  elif [[ "$#@" -eq 1 ]]; then
    REPLY="$@[1]"
    return
  elif [[ "$#@" -lt 10 ]]; then
    opt=-sk
  fi
  for i ({1..$#@}) {alts+=("$i: ${${@[$i]}#$strip}")}
  if zle; then
    zle -R 'Pick one' $alts
  else
    print >&2 -l - $alts
  fi
  read $opt
  while [[ $REPLY != [[:digit:]]## ]] || [[ $REPLY -lt 1 ]] || [[ $REPLY -gt $#@ ]]; do
    if zle; then
      zle -R "Invalid reply${REPLY:+ }${(V)REPLY}, try again." $alts
      if [[ $opt == -sk ]]; then
        read $opt
      else
        p=$PREDISPLAY
        PREDISPLAY=$BUFFER$'\n'"Pick one: "
        l=$LBUFFER
        r=$RBUFFER
        BUFFER=
        zle recursive-edit
        REPLY=$BUFFER
        LBUFFER=$l
        RBUFFER=$r
        PREDISPLAY=$p
      fi
    else
      echo >&2 "Invalid reply, try again."
      read $opt
    fi
  done
  zle -R -c
  REPLY="$@[$REPLY]"
}

function pcd Pcd vcd dcd () {
  local REPLY dir odir star
  star=/*
  case $0 in
    pcd) dir=/usr/portage odir=/usr/local/overlays/mikachu ;;
    Pcd) dir=/usr/local/overlays/mikachu odir=/usr/portage ;;
    vcd) dir=/var/db/pkg ;;
    dcd) dir=/usr/share/doc star= ;;
  esac
  if [[ $# = 0 ]] && [[ $PWD = $odir/* ]]; then
    cd $dir/${PWD#$odir}
  else
    if [[ $1 = */* ]]; then
      cd $dir/$1
    else
      REPLY=($dir$~star/$1(-/N))
      if (( $#REPLY )) {
        select-one -s $dir/ $REPLY
      } else {
        select-one -s $dir/ $dir$~star/$1*(-/)
      }
      cd $REPLY
    fi
  fi
}
function show-one () {
  local REPLY
  select-one $@
  echo -E - $REPLY
}

#dirlist aliases
alias sl='\ls ${LS_OPTIONS#-A}'
alias ls='ls $LS_OPTIONS'
alias dir='ls --format=vertical'
alias vdir='ls -lh'
alias d=dir
alias v='vdir -s'
alias n='ls -N'
alias sv='ls -sh'
alias ls.='ls -d .[^.]*'
alias lsd='ls -ld *(-/DN)'
alias lt='ls -trlc'
alias nt='ls -trNc'
alias lss='ls -sShr'
alias x='ls -X'

#vcs aliases
function cdiff() {
if test -d CVS -a -f ChangeLog.cvs -a -f ChangeLog.cvs.bak; then
  diff -u ChangeLog.cvs ChangeLog.cvs.bak|edit - >& /dev/null
elif test -d .svn -a -f ChangeLog.svn.latest; then
  edit ChangeLog.svn.latest
elif test -d .svn -a -f ChangeLog.svn -a -f ChangeLog.svn.bak; then
  diff -u ChangeLog.svn ChangeLog.svn.bak|edit - >& /dev/null
fi
}
function cup() {
(
  [ $PWD:t = build ] && cd -q ..
  if test -d CVS -a ! -d .git; then cvs up -dP "$@"
  elif test -d .svn; then svn up "$@"
  elif test -d .hg; then hg pull "$@"
  elif test -d .git -o "$PWD:t:e" = git; then
    if [[ $1 = r ]]; then
      git remote update
    elif test -d .git/svn; then
      git svn fetch "$@"
    elif test -d CVS; then
      git cvsimport -r cvs -v -i -k -u -s _ "$@"
    else
      git fetch "$@"
    fi
  else
    echo "no git or cvs or svn repository in here guy"
  fi
)
}
alias cu=cup
function c2l() {
if test -d CVS; then cvs2cl.pl;
elif test -d .svn; then : mv -f ChangeLog.svn ChangeLog.svn.bak; svn2cl -o ChangeLog.svn;
else
  echo "no cvs or svn repository in here guy"
fi
}

#function aliases
alias ren='noglob zmv -W'
alias mcd='mount /cdrom'
alias umcd='umount /cdrom'
alias mcr='mount /cdrw'
alias umcr='umount /cdrw'
alias tarz='tar xvf'
alias tary='tar xvf'
alias tarr='tar xvf'
alias hup='kill -HUP'
alias hupall='killall -HUP'
alias plmk='perl Makefile.PL'
alias ftptail='tail -f -n 50 /var/log/proftpd'
alias ftpttail='tail -f -n 50 /var/log/proftpdtransferlog'
alias httptail='tail -f -n 50 /var/log/apache2/access.log|logresolve'
alias httpnow='su root -c '\''for a ($(pidof apache2)) {ls -l /proc/$a/fd/|fgrep -v /dev/null|fgrep -v socket:|fgrep -v pipe:|fgrep -v /session_mm_apache|fgrep -v /tmp/.xcache.|fgrep -v anon_inode:\[eventpoll\]|fgrep -v /var/cache/apache-mm|egrep -v "^total "|grep -v X11/locale|cut -d ">" -f 2}'\'
#alias httpnu="dog http://mika.l3ib.org/status|sed -n '/<b>W<\/b>/{n;n;s/<td>\([^<]\+\)<td.*GET \([^\(HTTP\)]\+\).*/\1 \2/p}'"
alias httpnu="dog http://mika.l3ib.org/status|sed -n '/<b>W<\/b>/{N;N;s/.*\n<\/td><td>\([[:digit:]]\+\.[[:digit:]]\+\.[[:digit:]]\+\.[[:digit:]]\)<\/td>.*GET \/\(.*\)HTTP\/1\..<\/td><\/tr>/\1 \2/p}'"
alias ftpwhom='ps axf|grep proftpd|egrep -v '\''(grcat|grep|tail)'\''|grep -A 50 accepting|ssed -R s/\^\\s//g|ssed -R '\''s/\s+/ /g'\''|cut -d \  -f 4-'
alias {l,}grep='LC_CTYPE=$LC_CTYPE:r grep'
if [[ $TERM = rxvt-unicode ]]; then
  function grep egrep fgrep() {
    GREP_COLORS='ms=38;5;27:fn=38;5;73:ln=38;5;25:se=38;5;20' command $0 --color=auto "$@"
  }
fi

#suffix aliases
alias -s {avi,mkv,ogm,mpg,wmv,vob,mp3,mp4,flv,ogg,flac,tta,wav,rar}='mplayer -fs -cache 10000'
alias -s {jpg,png}=viewnior

#directory aliases
alias cp='cp --preserve=xattr -i'
alias mv='mv -i'
alias rm='rm -v'
alias cdsrc='cd /usr/src'
alias cdftp='cd /home/ftp/uploads'
alias rda='rm -R'
alias dc='cd'

#short aliases
alias j='jobs -l'
function c m () {
case $0 in
  c) 0=configure ;;
  m) 0=mikareconf ;;
esac
if [[ -f $0 ]];then
  ./$0 $@
elif [[ $PWD:t =~ build.* ]]; then
  echo using $0 from ..;../$0 $@
else
  ./$0 $@
fi
}
compdef -e 'words[1]=./configure;_configure' c m
alias q='exit'
alias less='less -r'
alias emacs="emacs --no-splash"
alias ds="du -hs"
alias dn="du -ms ./* | sort -n"
alias sur="suc -u root "
alias idn="idn --quiet"
alias qiv="qiv -R"
alias - +x="chmod +x"
alias - -x="chmod -x"
alias ped="perl -pe"
alias l=locate
alias li='locate -i'
alias scpn='scp -o noneswitch=yes'
alias mp=mplayer
alias bp='bs pause'
alias pl='print -l'

#misc aliases
alias asdf='setxkbmap -keycodes xfree86+mikachu+labtec-evdev -compat complete+mikachu -symbols se_dvorak -types complete+mikachu'
alias aoeu='setxkbmap se'
alias iconviu='iconv -f ISO-8859-1 -t UTF-8'
alias iconvui='iconv -t ISO-8859-1 -f UTF-8'
alias iconvue='iconv -f UTF-8 -t eucjp'
alias iconveu='iconv -f eucjp -t UTF-8'
alias iconvus='iconv -f UTF-8 -t sjis'
alias iconvsu='iconv -f sjis -t UTF-8'
alias romaji='kakasi -Ha -Ja -Ka -C -s'
alias uromaji='iconvue|romaji|iconveu'
alias vakna='at <<< "bs play"'
alias chocka='at <<< sine3'
function remind() { at "$2" <<< "play ~/misc/sounds/burnsahoyhoy.wav >& /dev/null & DISPLAY=:0 gmessage -pc $1" }
alias initmidi='asfxload ~/soundfonts/PersonalCopy5.1f.sf2; aconnect 16:0 17:3'
alias uninitmidi='asfxload -i; aconnect -d 16:0 17:3'
alias regal='{ galeon -q;while pidof galeon >& /dev/null; do sleep 0.5; done;(cd -q;galeon-client >>& .xsession-errors &|) }'
alias dtirssi='cursorcol purple; exec dtach -A .irssi/dtach irssi'
alias pst='ps -o pid,lstart,etime,cputime,tname,comm'
alias tider='
echo -n Ottawa"   ":;TZ=America/Montreal date
echo -n SanFran"  ":;TZ=America/Los_Angeles date
echo -n Ã–stkusten:;TZ=US/Eastern date
echo -n Hemma"    ":;date
echo -n Japan"    ":;TZ=Japan date
echo -n Canberra\ :;TZ=Australia/Canberra date
'
alias uptime='command uptime;false cat /proc/up(penis|dike)(N) || /usr/bin/uptime | perl -ne "/(\d+) d/;print 8,q(=)x\$1,\"D\n\""'
alias zftp='autoload -U zfinit;unalias zftp;zfinit;zftp'
alias debcflags='export CFLAGS="-g3 ${CFLAGS//-fno-unswitch-loops /}";export CXXFLAGS="-g3 ${CXXFLAGS//-fno-unswitch-loops /}"'
alias smallcflags='export CFLAGS="-Os ${CFLAGS//-O3 /}";export CXXFLAGS="-Os ${CXXFLAGS//-O3 /}"'
alias o1ld='export LDFLAGS=-Wl,-O1'
alias dmake='PATH=/usr/lib/distcc/bin:$PATH make -j4'
alias binwrite='cdrdao write --device 0,1,0 --speed 8 --driver generic-mmc-raw "$@"'
alias exit=' exit'

#global aliases
alias -g NF='*(.om[1])'
alias -g ND='*(/om[1])'
alias -g NN='*(om[1])'
alias -g GM='| gmessage -file - -c -s 500x600'
alias -g VIDEO="(#i)*.(mpg|avi|vob|mpeg|wmv|mov|asf)"
alias -g RPWD='`readlink -f $PWD`'
alias -g MPSCALE='-fs -zoom -sws 6'
alias -g MPPOS='-fixed-vo -geometry +69+130 -xy 1158'
alias -g XVMC='-vc ffmpeg12mc -vo xvmc -nomenu -vf-clr'
alias -g SEDQUOTE='sed -e "s/'\''/'\''\\\\'\'\''/g" -e "s/\(.*\)/'\''\1'\''/g"'

#environment modifiers
alias noca='LD_PRELOAD=~/bin/noca.so '

typeset -A _cflags
typeset -A _cxxflags
#getting C(XX)?FLAGS from the gentoo build system
source /etc/make.conf
_cflags[gentoo]=$CFLAGS
_cxxflags[gentoo]=$CXXFLAGS
CPPFLAGS=-DMIKACHU
export CFLAGS CXXFLAGS CPPFLAGS LDFLAGS
_cflags[mikachu]=$CFLAGS
_cxxflags[mikachu]=$CXXFLAGS
_cflags[debug3]="${CFLAGS/-O?( |)/} -gdwarf-2 -g3 -O0"
_cxxflags[debug3]="${CXXFLAGS/-O?(| )/} -gdwarf-2 -g3 -O0"
_cflags[debug1]="${CFLAGS/-O?( |)/} -gdwarf-2 -g -O1"
_cxxflags[debug1]="${CXXFLAGS/-O?(| )/} -gdwarf-2 -g -O1"
_cflags[wall]="$CFLAGS -Wall"
_cxxflags[wall]="$CXXFLAGS -Wall"
function cflags() {
  case $# in
    0)
    print -l ${(k)_cflags}
    ;;
    1)
    export CFLAGS=$_cflags[$1]
    export CXXFLAGS=$_cxxflags[$1]
    echo CFLAGS:
    echo -E - $CFLAGS
    echo CXXFLAGS:
    echo -E - $CXXFLAGS
    ;;
  esac
}
compdef 'compadd -o ${(k)_cflags}' cflags

[[ $USERNAME = mikachu ]] && export CONFIG_SITE=~/bin/config.site
trap - INT