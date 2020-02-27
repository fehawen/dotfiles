#!/bin/sh
#
# Clone github repo. I'm so lazy.
#
# Usage: clo [username] [repository]

if [ $# -lt 2 ]; then
  printf '%s\n' "Usage: clo [username] [repository]"
  exit 1
fi

git clone https://github.com/"$1"/"$2".git
