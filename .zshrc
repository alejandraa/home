#!/bin/zsh
#
# A less-fancy prompt string for basic shells.

if [[ -o login ]]; then
  # use the regular shell
else
  PROMPT='♬  '
fi
