#!/bin/sh
# Deno wrapper v2.0.0
# https://github.com/jcbhmr/deno_wrapper
# MIT License
# Copyright (c) 2023 Jacob Hummer
set -e

version=2.0.0
help="
Deno wrapper v${version}

🦕 Like ./gradlew, but for Deno

USAGE:

  deno_wrapper [version]

EXAMPLE:
  curl -fsSL https://deno.land/x/deno_wrapper/deno_wrapper.sh | sh
  ./denow eval 'console.log(42)'
  #=> 42
"
[ "$1" = --help ] && echo "$help" && exit

if [ -z "$1" ]; then
  pinned=$(deno eval 'console.log(Deno.version.deno)')
else
  pinned=$1
fi

curl -fsSL "https://deno.land/x/deno_wrapper@$version/denow" \
  | sed "s/{{version}}/$version/" \
  | sed "s/{{pinned}}/$pinned/" \
  > denow
chmod +x denow
[ -d .git ] && git update-index --chmod +x denow

curl -fsSL "https://deno.land/x/deno_wrapper@$version/denow.bat" \
  | sed "s/{{version}}/$version/" \
  | sed "s/{{pinned}}/$pinned/" \
  > denow.bat
