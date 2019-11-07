# install homebrew
if [[ ! -x "$(command -v brew)" ]]; then
  echo "Installing homebrew...\\n"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew is already installed.\\n"
fi

echo "Installing packages"
echo $(pwd)
brew bundle --file="./os/macos/Brewfile"
