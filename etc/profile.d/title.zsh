# Set the title of the iTerm window.
function title() {
  print -Pn "\033];$1\007";
}
