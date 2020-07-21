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

# Here gnome is kept as default

session=${1:-gnome}
space_i3=$2

# Run those commands only with a i3 session
if [[ $session == "plasma" ]]; then
	redshift-gtk & # Caring for my eyes
	flameshot & # Prinscreen software
	workrave & # Caring for my body and eyes health

	exec startplasma-x11
elif [[ $session == "i3" ]]; then
	echo 'i3 is running!'

	setxkbmap -model pc104 -layout br -option numpad:microsoft

	# Fix mic problem
	# http://wiki.archlinux.org/index.php/PulseAudio/Troubleshooting#No_microphone_input_on_Acer_Aspire_One_and_Lenovo_Ideapad-310-15ISK
	pactl set-source-volume 1 -100% -0

	if [[ $space_i3 == true ]]; then

	    [[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

	    spare_modifier="Hyper_L"
	    xmodmap -e "keycode 65 = $spare_modifier"
	    xmodmap -e "add Hyper_L = $spare_modifier"
	    xmodmap -e "keycode any = space"
	    xcape -e "$spare_modifier=space"
	fi

	# Better beep sound (volume, hertz frequency, duration in miliseconds)
	xset b 10 30 200

	# Use Natural Scrolling on my touchpad
	xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1

	#xrandr --output HDMI1 --right-of eDP1 --auto & # Set monitors config
	xrandr --auto

	# emacs --daemon & # Emacs Daemon


	picom & # Xorg compositor
	dunst & # Notification manager
	redshift-gtk & # Caring for my eyes
	flameshot & # Prinscreen software
	workrave & # Caring for my body and eyes health

	i3
fi

