#!/usr/bin/env sh

set -eu

OS_RELEASE_FILE="${OS_RELEASE_FILE:-/etc/os-release}"

if [ "$(uname -s)" = "Darwin" ]; then
  os="macos"
elif [ -r "$OS_RELEASE_FILE" ]; then
  # shellcheck disable=SC1090
  . "$OS_RELEASE_FILE"
  os="${ID:-linux}"
elif [ -r /etc/lsb-release ]; then
  # shellcheck disable=SC1091
  . /etc/lsb-release
  os=$(printf '%s' "${DISTRIB_ID:-linux}" | tr '[:upper:]' '[:lower:]')
else
  os="$(uname -s | tr '[:upper:]' '[:lower:]')"
fi

case "$(uname -n)" in
  codespace*) os="codespace" ;;
esac

printf '%s\n' "$os"
