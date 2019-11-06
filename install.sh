DOTLOC=$HOME/repos/dotfiles
FUNPATH=/usr/local/share/zsh/site-functions

info() {
    printf "\033[00;34m$@\033[0m\n"
}

info "Configuring"

if [ "$(uname)" == "Darwin" ]; then
	echo "Configuring macOS"
	./os/macos/install.sh
	./os/macos/configure.sh
elif [ "$(uname)" == "Linux" ]; then
	echo "Configuring Linux"
	./os/ubuntu/install.sh
fi


#install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

#install vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#install deno
curl -fsSL https://deno.land/x/install/install.sh | sh

#install neovim python deps
pip install --user neovim

#create nvim config dir
mkdir ~/.config
mkdir ~/.config/nvim

# link required files
echo "Linking Files..."
for file in zshrc zshenv gitconfig gitignore nvimrc
do
  rm ~/.$file &>/dev/null
  ln -s "$DOTLOC/$file" ~/.$file
done
ln -s $(pwd)/init.vim ~/.config/nvim/init.vim

# cleanup old prompt files
if [[ -x $FUNPATH/prompt_pure_setup && -x $FUNPATH/async ]]; then
  rm -f $FUNPATH/prompt_pure_setup
  rm -f $FUNPATH/async
fi

doing "Installing completions..."
if [[ -x $FUNPATH/_repo ]]; then
  rm -f $FUNPATH/_repo
fi
ln -s "$DOTLOC/completions/_repo" $FUNPATH/_repo
success

# change default shell to zsh
chsh -s zsh

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/repos/dotfiles/.zshrc $HOME/.zshrc

# install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

mkdir -p ~/.config/
mkdir -p ~/.config/nvim/
echo "linking ${DOTLOC}/.vimrc to ~/.config/nvim/init.vim"
ln -s $DOTLOC/.nvimrc ~/.config/nvim/init.vim
pip3 install neovim

echo "Installing patched fonts"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# set executable
chmod +x ./bin/tat

echo "done"
