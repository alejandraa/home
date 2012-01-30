function growl() {
  echo -e $'\e]9;'${1}'\007' ; return ;
}
