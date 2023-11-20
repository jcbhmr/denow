#!/bin/bash
set -ex

python -m http.server 7000 &
sleep 3s # let server get ready

export DENO_DL_BASE_URL="http://localhost:7000/"

if [[ $OS == Windows_NT ]]; then
  powershell -Command "irm ${DENO_DL_BASE_URL}install.ps1 | iex"
fi

curl -fsSL ${DENO_DL_BASE_URL}install.sh | sh

./denow eval 'console.log("Hello world!")'
./denow eval 'console.log(Deno.version.deno)'
