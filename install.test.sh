#!/bin/bash
set -ex

owd="$PWD"
twd=$(mktemp -d)
trap 'rm -rf "$twd"' SIGINT SIGTERM ERR EXIT
cd "$twd"

<"$owd/install.sh" sh -s 1.30.0
[[ -f denow ]] || exit 1

v=$(./denow eval 'console.log(Deno.version.deno)')
[[ $v == 1.30.0 ]] || exit 1
[[ -d ".deno" ]] || exit 1
