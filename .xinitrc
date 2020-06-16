#!/bin/sh

#sysresources=/etc/X11/xinit/.Xresources
#sysmodmap=/etc/X11/xinit/.Xmodmap
#userresources=~/.Xresources
#
## merge in defaults and keymaps
#
#if [ -f $sysresources ]; then
#    xrdb -merge $sysresources
#fi
#
#if [ -f $sysmodmap ]; then
#    xmodmap $sysmodmap
#fi
#
#if [ -f $userresources ]; then
#    xrdb -merge $userresources
#fi
#
## start some nice programs
#if [ -d /etc/X11/xinit/xinitrc.d ] ; then
# for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#  [ -x $f ] && . $f
# done
# unset f
#fi

setxkbmap -model pc104 -layout br 

[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

# Fix mic problem
# http://wiki.archlinux.org/index.php/PulseAudio/Troubleshooting#No_microphone_input_on_Acer_Aspire_One_and_Lenovo_Ideapad-310-15ISK
pactl set-source-volume 1 -100% -0

# Here gnome is kept as default

session=${1:-gnome}

#case $session in
#	i3|i3wm           ) exec i3;;
#	#kde               ) exec startplasma-x11;;
#	#xfce|xfce4        ) exec startxfce4;;
#	# No known session, try to run it as command
#	*                 ) echo 'running gnome';;
#esac

# Run those commands only with a i3 session
if [ "$session" == "i3" ];
then
	echo 'i3 is running!'

spare_modifier="Hyper_L" 
xmodmap -e "keycode 65 = $spare_modifier"   
xmodmap -e "add Hyper_L = $spare_modifier"
xmodmap -e "keycode any = space"  
xcape -e "$spare_modifier=space"

	#xrandr --output HDMI1 --right-of eDP1 --auto & # Set monitors config
	xrandr --auto

	# emacs --daemon & # Emacs Daemon

  workrave & # Caring for my body and eyes health
flameshot & # Prinscreen software 
pasystray & # PulseAudio system tray

	# Better beep sound (volume, hertz frequency, duration in miliseconds)
	xset b 10 30 200

# Use Natural Scrolling on my touchpad
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1

i3
fi
