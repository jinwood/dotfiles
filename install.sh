DOTLOC=$HOME/repos/dotfiles
FUNPATH=/usr/local/share/zsh/site-functions

# install homebrew if missing
if [[ ! -x "$(command -v brew)" ]]; then
  echo "Installing homebrew...\\n"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew is already installed.\\n"
fi

echo "Installing packages"
brew bundle install --file="./Brewfile" >/dev/null

#install deno
curl -fsSL https://deno.land/x/install/install.sh | sh

# link required files
echo "Linking Files..."
for file in zshrc zshenv gitconfig gitignore
do
  rm ~/.$file &>/dev/null
  ln -s "$DOTLOC/$file" ~/.$file
done

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
