#!/bin/sh

set -e

PATH="/usr/local/bin:$PATH"

trap 'rm -f "$$.tags"' EXIT

git ls-files | ctags --tag-relative -L - -f"$$.tags" --languages=-javascript,sql

mv "$$.tags" "tags"
