echo Copy  vimrc? y/n
read installVim
if [ $installVim == y ]
then
	echo Copying .vimrc
	sudo cp .vimrc ~/.vimrc
fi

