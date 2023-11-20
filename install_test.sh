#!/bin/bash
set -ex

python -m http.server 7000 &
sleep 3 # let server get ready

export DENOW_DL_BASE_URL="http://localhost:7000/"

if [[ $OS == Windows_NT ]]; then
  pwsh -Command "irm ${DENOW_DL_BASE_URL}install.ps1 | iex"
fi

curl -fsSL ${DENOW_DL_BASE_URL}install.sh | sh

./denow eval 'console.log("Hello world!")'
./denow eval 'console.log(Deno.version.deno)'
