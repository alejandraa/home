#!/bin/zsh

for file in $(grep -il "codehilite" vendor/assets/stylesheets/pygments/*.css); do
  sed -e "s/codehilite/highlight/g" $file > tmp/current.tmp
  mv tmp/current.tmp $file
done
