#this will be a scratchpad for now.....

#remap capslock to esc
touch ~/.Xmodmap
echo "! 66 is the keycode of Caps_Lock
clear    Lock
keycode  66 = Escape" > ~/.Xmodmap
xmodmap ~/.Xmodmap

#download backgroud image
curl https://cache.desktopnexus.com/cropped-wallpapers/2346/2346173-1920x1080-[DesktopNexus.com].jpg?st=RfAXWSisCuS-cSgAjyuguQ&e=1547072492 > ~/Pictures/wallpaper.jpg

if !  [ -x "$(command -v pacman)"]; then
    echo 'pacman not found!'
    exit 1
fi

sudo pacman -S feh
#set uk timezone
sudo pacman -S ntp
sudo timedatectl set-ntp true
sudo timedatectl set-timezone Europe/London
