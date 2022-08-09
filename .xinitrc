#!/bin/sh

sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
userresources=~/.Xresources

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f $userresources ]; then
    xrdb -merge $userresources
fi

setxkbmap -model pc104 -layout br -option numpad:microsoft

# Fix mic problem
# http://wiki.archlinux.org/index.php/PulseAudio/Troubleshooting#No_microphone_input_on_Acer_Aspire_One_and_Lenovo_Ideapad-310-15ISK
pactl set-source-volume 1 -100% -0

[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

spare_modifier="Hyper_L"
xmodmap -e "keycode 65 = $spare_modifier"
xmodmap -e "add Hyper_L = $spare_modifier"
xmodmap -e "keycode any = space"
xcape -e "$spare_modifier=space"

# Better beep sound (volume, hertz frequency, duration in miliseconds)
xset b 10 30 200

# Use Natural Scrolling on my touchpad
#xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1

xrandr --output HDMI-1 --left-of eDP1 --auto & # Set monitors config
# xrandr --auto

picom & # Xorg compositor
dunst & # Notification manager
redshift-gtk -t 4500K:3500K -l -29.6812544:-51.1082496 & # Caring for my eyes
flameshot & # Prinscreen software
workrave & # Caring for my body and eyes health
dropbox & 
(sleep 20 && onedrive_tray) &
i3 

