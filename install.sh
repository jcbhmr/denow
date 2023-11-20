#!/bin/sh
set -e

if [ "$OS" = "Windows_NT" ]; then
  curl.exe -fsSL https://github.com/jcbhmr/denow/blob/main/denow.bat -o ./denow.bat
  curl.exe -fsSL https://github.com/jcbhmr/denow/blob/main/denow -o ./denow
  chmod +x ./denow
else
  url='https://github.com/jcbhmr/denow/blob/main/denow'
  echo "Downloading $url for *nix"
  if command -v curl 2> /dev/null; then
    curl -fsSL https://github.com/jcbhmr/denow/blob/main/denow.bat -o ./denow.bat
    curl -fsSL https://github.com/jcbhmr/denow/blob/main/denow -o ./denow
    chmod +x ./denow
  elif command -v wget 2> /dev/null; then
    wget https://github.com/jcbhmr/denow/blob/main/denow.bat -O ./denow.bat
    wget https://github.com/jcbhmr/denow/blob/main/denow -O ./denow
    chmod +x ./denow
  else
    echo "Neither 'curl' nor 'wget' found." >&2
    exit 1
  fi
fi

if [ -n "$1" ]; then
  deno_version="$1"
elif command -v grep 2> /dev/null; then
  # https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
  deno_version=$(curl --silent "https://api.github.com/repos/denoland/deno/releases/latest" | grep -Po "(?<=\"tag_name\": \").*(?=\")")
else
  echo "Unable to fetch latest version" >&2
  exit 1
fi

if [ "$OS" = "Windows_NT" ]; then
  powershell -Command "(gc ./denow.bat) -replace '%__DENO_VERSION__%', '$deno_version' | Out-File -encoding ASCII ./denow.bat"
  powershell -Command "(gc ./denow.bat) -replace '\$__DENO_VERSION__', '$deno_version' | Out-File -encoding ASCII ./denow"
else
  sed -i "s/%__DENO_VERSION__%/$deno_version/g" ./denow.bat
  sed -i "s/\$__DENO_VERSION__/$deno_version/g" ./denow
fi

echo "Created wrapper! You can use ./denow to launch Deno."
