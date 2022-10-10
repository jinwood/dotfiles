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

if [ "$OS" == "ManjaroLinux" ]; then
  echo "Configuring Manjaro"
  # chmod +x ./os/arch/configure.sh
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

#install vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#install deno
curl -fsSL https://deno.land/x/install/install.sh | sh


# cleanup old prompt files
rm -rf ~/.oh-my-zsh
if [[ -x $FUNPATH/prompt_pure_setup && -x $FUNPATH/async ]]; then
  rm -f $FUNPATH/prompt_pure_setup
  rm -f $FUNPATH/async
fi

# install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

doing "Installing completions..."
if [[ -x $FUNPATH/_repo ]]; then
  rm -f $FUNPATH/_repo
fi
ln -s "$DOTLOC/completions/_repo" $FUNPATH/_repo

echo "linking ${DOTLOC}/.vimrc to ~/.config/nvim/init.vim"
rm -rf ~/.config/nvim/
mkdir ~/.config
mkdir ~/.config/nvim
ln -s $DOTLOC/.nvimrc ~/.config/nvim/init.vim
pip3 install neovim

# link required files
echo "Linking Files..."
for file in zshrc gitconfig gitconfig-quest helix-config
 do
  rm ~/.$file &>/dev/null
  echo "linking -/home/julian/repos/dotfiles/.$file /home/julian/.$file"
  ln -s "$DOTLOC/.$file" "$HOME/.$file" 
done

ln -s "$DOTLOC/helix-config.toml" "$HOME/config/helix/config.toml"
#ln -s $(pwd)/init.vim ~/.config/nvim/init.vim


# set executable
chmod +x ./bin/tat

# change default shell to zsh
chsh -s /bin/zsh

# npm
npm i -g typescript typescript-language-server

echo "done"
