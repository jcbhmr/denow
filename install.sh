#!/bin/sh
set -e

if [ -n "$DENOW_DL_BASE_URL" ]; then
  base_url="$DENOW_DL_BASE_URL"
else
  base_url='https://deno.land/x/denow/'
fi

if [ "$OS" = "Windows_NT" ]; then
  curl.exe -fsSL "${base_url}denow.bat" -o ./denow.bat
  curl.exe -fsSL "${base_url}denow" -o ./denow
  chmod +x ./denow
else
  if command -v curl 2> /dev/null; then
    curl -fsSL "${base_url}denow.bat" -o ./denow.bat
    curl -fsSL "${base_url}denow" -o ./denow
  elif command -v wget 2> /dev/null; then
    wget "${base_url}denow.bat" -O ./denow.bat
    wget "${base_url}denow" -O ./denow
  else
    echo "Neither 'curl' nor 'wget' found." >&2
    exit 1
  fi
  chmod +x ./denow
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
