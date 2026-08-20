#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
PACKAGE_FILE="$SCRIPT_DIR/Dnffile"

if ! command -v dnf >/dev/null 2>&1; then
  echo "Fedora installer requires dnf." >&2
  exit 1
fi

echo "Enabling the Ghostty COPR..."
if ! dnf copr --help >/dev/null 2>&1; then
  sudo dnf install --assumeyes dnf5-plugins || sudo dnf install --assumeyes dnf-plugins-core
fi
sudo dnf copr enable --assumeyes scottames/ghostty

echo "Installing Fedora packages..."
mapfile -t packages < <(sed -e 's/#.*//' -e '/^[[:space:]]*$/d' "$PACKAGE_FILE")
sudo dnf install --assumeyes "${packages[@]}"

echo "Fedora packages installed."
