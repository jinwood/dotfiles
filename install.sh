DOTLOC=$HOME/repos/dotfiles
FUNPATH=/usr/local/share/zsh/site-functions

SCRIPT_ROOT=$(cd "$(dirname "$0")" || exit 1; pwd)
if [ -d "$SCRIPT_ROOT/setup" ]; then
  SCRIPT_ROOT="$(dirname "${SCRIPT_ROOT}")"
fi

chmod +x ./os.sh
OS=$(./os.sh)

echo $OS

info() {
    printf "\033[00;34m$@\033[0m\n"
}
doing() {
    printf "\033[00;34m$@\033[0m\n"
}

if [ "$OS" == "ManjaroLinux" ] || [ "$OS" == "arch" ]; then
  echo "Configuring Arch/Manjaro"
  chmod +x ./os/arch/install.sh
  ./os/arch/install.sh
elif [ "$(uname)" == "Darwin" ]; then
	echo "Configuring macOS"
	chmod +x ./os/macos/install.sh
	chmod +x ./os/macos/configure.sh
	./os/macos/install.sh
	./os/macos/configure.sh
elif [ "$(uname)" == "Linux" ]; then
	echo "Configuring Linux"
	chmod +x ./os/ubuntu/install.sh
	./os/ubuntu/install.sh
fi

#install deno
curl -fsSL https://deno.land/x/install/install.sh | sh


# cleanup old prompt files
rm -rf ~/.oh-my-zsh
if [[ -x $FUNPATH/prompt_pure_setup && -x $FUNPATH/async ]]; then
  rm -f $FUNPATH/prompt_pure_setup
  rm -f $FUNPATH/async
fi

# install ohmyzsh
export RUNZSH=no
export KEEP_ZSHRC=yes
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

doing "Installing completions..."
if [[ -x $FUNPATH/_repo ]]; then
  rm -f $FUNPATH/_repo
fi
ln -s "$DOTLOC/completions/_repo" $FUNPATH/_repo

echo "Cloning lazyvim config"
git clone git@github.com:jinwood/lazyvim-config.git "$HOME/.config/nvim"

# set executable
chmod +x ./bin/tat

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
for file in .zshrc .gitconfig; do
  target="$HOME/$file"
  source="$DOTLOC/$file"
  echo "linking $source -> $target"
  rm -f "$target"
  ln -s "$source" "$target"
done

echo "done"
