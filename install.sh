#this will be a scratchpad for now.....

#remap capslock to esc
touch ~/.Xmodmap
echo "! 66 is the keycode of Caps_Lock
clear    Lock
keycode  66 = Escape" > ~/.Xmodmap
xmodmap ~/.Xmodmap

#download backgroud image
curl https://cache.desktopnexus.com/cropped-wallpapers/2346/2346173-1920x1080-[DesktopNexus.com].jpg?st=RfAXWSisCuS-cSgAjyuguQ&e=1547072492 > ~/Pictures/wallpaper.jpg

#set uk timezone
sudo timedatectl set-ntp true
sudo timedatectl set-timezone Europe/London

ln -sf ./i3/config ~/.config/i3/config
#more
