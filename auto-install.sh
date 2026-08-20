#!/usr/bin/env sh
THISDIR=$(cd "$(dirname "$0")"; pwd)
OS="$($THISDIR/os.sh)"
DIR="$(cd $(dirname ${1-}); pwd)"

echo "AUTOINSTALL"
echo $THISDIR
echo $OS
echo $DIR

if [ -f "$DIR/Brewfile" ] && [ "$OS" = "macos" ]; then
  "$THISDIR/homebrew/install.sh"
  brew bundle install --file="$DIR/Brewfile"
elif [ -f "$DIR/Debfile" ] && command -v apt >/dev/null 2>&1; then
  xargs -a "$THISDIR/Debfile" sudo apt install -qq -y --no-install-recommends
elif [ -f "$DIR/Dnffile" ] && command -v dnf >/dev/null 2>&1; then
  sed -e 's/#.*//' -e '/^[[:space:]]*$/d' "$DIR/Dnffile" | xargs sudo dnf install -y
elif [ -f "$DIR/Yayfile" ] && command -v pacman >/dev/null 2>&1; then
  echo 1
  if ! command -v yay >/dev/null 2>&1; then
    echo 2
    sudo pacman --noconfirm --needed -S yay
  fi
  echo 3
  yes | xargs -a "$DIR/Yayfile" yay --needed --answerclean No --answerdiff N -S --noprovides
fi

if [ -d "$DIR/config" ]; then
  echo "Installing config dirs..."
  for DOTDIR in "$DIR/config/"*; do
    XDGDIR="$HOME/.config/$(basename $DOTDIR)"
    if [ ! -L "$XDGDIR" ] && [ -d "$XDGDIR" ]; then
      MOVEDIR="$XDGDIR.old-$(date -Iseconds)"
      echo "Found old dir, gracefully moving to $MOVEDIR"
      mv -f "$XDGDIR" "$MOVEDIR"
    fi
    ln -sfn "$DOTDIR" "$XDGDIR" 
  done
fi
