# Enables Growl notification support in iTerm2
function growl() {
  echo -e $'\e]9;'${1}'\007' ; echo $1 ; return ;
}
