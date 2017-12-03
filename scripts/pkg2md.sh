#!/usr/bin/env bash

set -e

# Dependencies:
# - npm install aegir
# - go get -u github.com/davecheney/godoc2md

usage() {
  echo "Usage: scripts/pkg2md.sh github.com/some-org/some-repo v1.2.3 path/to/destination/"
  exit 1
}

[ "$1" ] || usage
[ "$2" ] || usage
[ "$3" ] || usage

repo="$(echo "$1" | sed -e 's/^https:\/\///' -e 's/git:\/\///' -e 's/git@github.com:/github.com\//' -e 's/\.git$//')"
name="$(echo "$repo" | sed -e 's/.*\///')"
ref="$2"
dest="$3"

if echo "$name" | grep -P '^go-' > /dev/null; then

  # Go: get the source, run godoc2md
  #
  # TODO also render subdirectories
  export GOPATH="$(pwd)/tmp/gopath"
  go get -d -u -v "$repo"
  (cd "$GOPATH/src/$repo" && git reset --hard HEAD && git fetch && git checkout "$ref")
  mkdir -vp "$dest/$name"
  cat <<EOF > "$dest/$name/index.md"
+++
title = "$name"
description = "$name module reference"
+++

EOF
  godoc2md -v "$repo" >> "$dest/$name/index.md"
else

  # JS: clone repo, npm install, run aegir docs
  tmpdir="tmp/js"
  mkdir -vp "$tmpdir"
  if [ ! -d "$tmpdir/$name" ]; then
    git clone -q "https://$repo" "$tmpdir/$name"
  else
    (cd "$tmpdir/$name" && git reset --hard HEAD && git fetch && git checkout "$ref")
  fi

  cd "$tmpdir/$name"
  aegir docs -d md
  cd -
  mkdir -vp "$dest/$name"
  cat <<EOF > "$dest/$name/index.md"
+++
title = "$name"
description = "$name module reference"
+++

EOF
  cat "$tmpdir/$name/docs/index.md" | sed -e 's/^<!--.*$//' >> "$dest/$name/index.md"
fi
