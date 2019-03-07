DOTLOC=$HOME/repos/dotfiles

# install homebrew if missing
if [[ ! -x "$(command -v brew)" ]]; then
  echo "Installing homebrew...\\n"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew is already installed.\\n"
fi

echo "Installing packages"
brew bundle install --file="./Brewfile" >/dev/null

# link required files
echo "Linking Files..."
for file in zshrc zshenv gitconfig gitignore
do
  rm ~/.$file &>/dev/null
  ln -s "$DOTLOC/$file" ~/.$file
done

# change default shell to zsh
chsh -s zsh

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/repos/dotfiles/.zshrc $HOME/.zshrc


# linking files
for file in vimrc
do
  rm /.$file &>/dev/null
  ln -s "$DOTLOC/$file" ~/.$file
done

echo "nvim"
mkdir -p ~/.config/
mkdir -p ~/.config/nvim/
echo "linking ${DOTLOC}/.vimrc to ~/.config/nvim/init.vim"
ln -s $DOTLOC/.nvimrc ~/.config/nvim/init.vim
pip3 install neovim

echo "done"
