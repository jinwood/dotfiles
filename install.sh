#this will be a scratchpad for now.....

#remap capslock to esc
touch ~/.Xmodmap
echo "! 66 is the keycode of Caps_Lock
clear    Lock
keycode  66 = Escape" > ~/.Xmodmap
xmodmap ~/.Xmodmap
