#!/usr/bin/env bash

set -euo pipefail

SCRIPT_ROOT=$(cd "$(dirname "$0")" && pwd)
DOTLOC="$SCRIPT_ROOT"
FUNPATH="$HOME/.local/share/zsh/site-functions"
OS="$($SCRIPT_ROOT/os.sh)"

info() {
    printf '\033[00;34m%s\033[0m\n' "$*"
}
doing() {
    info "$@"
}

info "Detected operating system: $OS"

case "$OS" in
  arch|manjaro|manjarolinux)
    info "Configuring Arch/Manjaro"
    "$SCRIPT_ROOT/os/arch/install.sh"
    ;;
  fedora)
    info "Configuring Fedora"
    "$SCRIPT_ROOT/os/fedora/install.sh"
    ;;
  macos)
    info "Configuring macOS"
    "$SCRIPT_ROOT/os/macos/install.sh"
    "$SCRIPT_ROOT/os/macos/configure.sh"
    ;;
  ubuntu|debian|linuxmint|pop)
    info "Configuring Debian/Ubuntu"
    "$SCRIPT_ROOT/os/ubuntu/install.sh"
    ;;
  codespace)
    info "Codespace detected; skipping system package installation"
    ;;
  *)
    printf 'Unsupported operating system: %s\n' "$OS" >&2
    exit 1
    ;;
esac

# OpenCode is packaged natively on macOS and Arch. Install its official binary
# on the Linux distributions where it is not available in the default repos.
case "$OS" in
  fedora|ubuntu|debian|linuxmint|pop|codespace)
    curl -fsSL https://opencode.ai/install | bash -s -- --no-modify-path
    ;;
esac

#install deno
curl -fsSL https://deno.land/x/install/install.sh | sh


# install ohmyzsh
export RUNZSH=no
export KEEP_ZSHRC=yes
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

doing "Installing completions..."
mkdir -p "$FUNPATH"
ln -sfn "$DOTLOC/completions/_repo" "$FUNPATH/_repo"

if [ ! -e "$HOME/.config/nvim" ]; then
  echo "Cloning lazyvim config"
  mkdir -p "$HOME/.config"
  git clone git@github.com:jinwood/lazyvim-config.git "$HOME/.config/nvim"
fi

# set executable
chmod +x "$SCRIPT_ROOT/bin/tat"

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

nvm install node
nvm use node

# npm
npm i -g typescript typescript-language-server

# link required files
echo "Linking Files..."
for file in .zshrc .gitconfig .tmux.conf; do
  target="$HOME/$file"
  source="$DOTLOC/$file"
  echo "linking $source -> $target"
  ln -sfn "$source" "$target"
done

echo "Linking ghostty config..."
mkdir -p "$HOME/.config/ghostty"
ln -sfn "$SCRIPT_ROOT/ghostty/config" "$HOME/.config/ghostty/config"

echo "Linking OpenCode config..."
mkdir -p "$HOME/.config/opencode/agent"
ln -sfn "$SCRIPT_ROOT/opencode/opencode.jsonc" "$HOME/.config/opencode/opencode.jsonc"
for agent in "$SCRIPT_ROOT"/opencode/agent/*.md; do
  ln -sfn "$agent" "$HOME/.config/opencode/agent/$(basename "$agent")"
done

info "Done"

if [ "${SHELL:-}" != "$(command -v zsh)" ]; then
  info "Your current session is not Zsh. Run 'exec zsh -l' or open a new login session to load the aliases."
else
  info "Open a new terminal or run 'exec zsh -l' to load the updated configuration."
fi
