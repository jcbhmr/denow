#!/bin/bash
set -ex

python -m http.server 7000 &
sleep 3s # let server get ready

if [[ $OS == Windows_NT ]]; then
  powershell -Command "irm http://localhost:7000/install.ps1 | iex"
fi

curl -fsSL http://localhost:7000/install.sh | sh

./denow eval 'console.log("Hello world!")'
./denow eval 'console.log(Deno.version.deno)'
