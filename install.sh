#!/bin/sh
# Deno wrapper v3.1.2
# https://github.com/jcbhmr/deno_wrapper
# MIT License
# Copyright (c) 2023 Jacob Hummer
set -e
version='3.1.2'
help="Deno wrapper v${version}
🦕 Like ./gradlew, but for Deno

  curl -fsSL https://deno.land/x/deno_wrapper/install.sh | sh
  curl -fsSL https://deno.land/x/deno_wrapper/install.sh | sh -s 1.30.0"
denow=$(cat <<'EOF'
#!/bin/sh
# Generated by deno_wrapper v{{version}}
# https://github.com/jcbhmr/deno_wrapper
# MIT License
# Copyright (c) 2023 Jacob Hummer
set -e
# https://stackoverflow.com/a/29835459
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
deno_dir="$script_dir/.deno"

# https://manpages.ubuntu.com/manpages/kinetic/en/man1/chronic.1.html
chronic() (
  set +e
  output=$($@ 2>&1)
  exit_code=$?
  set -e
  if [ "$exit_code" -ne 0 ]; then
    echo "$output" >&2
  fi
  return "$exit_code"
)

if [ ! -d "$deno_dir" ]; then
  # https://github.com/denoland/deno_install#readme
  export DENO_INSTALL=$deno_dir
  curl -fsSL https://deno.land/x/install/install.sh | chronic sh -s "v{{pinned}}"
fi

# https://github.com/denoland/deno_install/blob/master/install.sh#L53
export DENO_INSTALL=$deno_dir
export PATH="$DENO_INSTALL/bin:$PATH"

exec deno "$@"
EOF
)

[ "$1" = --help ] && echo "$help" && exit
pinned=$1 && if [ -z "$pinned" ]; then
  if command -v deno >/dev/null; then
    pinned=$(deno eval 'console.log(Deno.version.deno)')
  elif command -v jq >/dev/null; then
    pinned=$(curl -fsSL https://api.github.com/repos/denoland/deno/releases/latest | jq -r '.tag_name')
  else
    # Updated 2023-05-28
    pinned=1.34.0
  fi
fi

echo -n "$denow" | sed "s/{{version}}/$version/" | sed "s/{{pinned}}/$pinned/" > denow
chmod +x denow

echo 'Add the .deno folder to your .gitignore'
echo 'To get started, run ./denow!'
