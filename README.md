# dotfiles

cd ~
curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
nano nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install nodejs
rm nodesource_setup.sh

sed -i 'npm set prefix ~/.npm
PATH="$HOME/.npm/bin:$PATH"
PATH="./node_modules/.bin:$PATH"' ~/.bashrc
