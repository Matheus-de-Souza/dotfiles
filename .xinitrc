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

#xrandr --output Virtual-1 --auto &
#xrandr --output HDMI1 --auto --right-of eDP1 &

xrandr --auto

safeeyes &

i3

