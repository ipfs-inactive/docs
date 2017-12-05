#!/usr/bin/env bash

set -e

# Dependencies:
# - npm install aegir
# - go get -u github.com/davecheney/godoc2md

usage() {
  echo "Usage: scripts/pkg2md.sh github.com/some-org/some-repo v1.2.3 path/to/basedir baseurl"
  exit 1
}

[ "$1" ] || usage
[ "$2" ] || usage
[ "$3" ] || usage
[ "$4" ] || usage

repo="$(echo "$1" | sed -e 's/^https:\/\///' -e 's/git:\/\///' -e 's/git@github.com:/github.com\//' -e 's/\.git$//')"
name="$(echo "$repo" | sed -e 's/.*\///')"
ref="$2"
basedir="$3"
baseurl="$4"

if echo "$name" | grep -P '^go-' > /dev/null; then

  # Go: get the source, run godoc2md
  #
  # TODO also render subdirectories
  export GOPATH="$(pwd)/tmp/gopath"
  go get -d "$repo"
  (cd "$GOPATH/src/$repo" && git clean -fdx && git fetch && git reset --hard "$ref")
  mkdir -vp "$basedir/$name"
  cat <<EOF > "$basedir/$name/index.md"
+++
title = "$name"
description = "$name package reference"
url = "$baseurl/$name"
+++

EOF
  godoc2md -v -template scripts/go-pkg.md "$repo" >> "$basedir/$name/index.md"
else

  # JS: clone repo, npm install, run aegir docs
  tmpdir="tmp/js"
  mkdir -vp "$tmpdir"
  if [ ! -d "$tmpdir/$name" ]; then
    git clone -q "https://$repo" "$tmpdir/$name"
  else
    (cd "$tmpdir/$name" && git clean -fdx && git fetch && git reset --hard "$ref")
  fi

  cd "$tmpdir/$name"
  aegir docs -d md
  cd -
  mkdir -vp "$basedir/$name"
  cat <<EOF > "$basedir/$name/index.md"
+++
title = "$name"
description = "$name module reference"
url = "$baseurl/$name"
+++

EOF
  cat "$tmpdir/$name/docs/index.md" | sed -e 's/^<!--.*$//' >> "$basedir/$name/index.md"
fi
