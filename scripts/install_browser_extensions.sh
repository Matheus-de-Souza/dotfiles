#!/bin/bash

open_link () {
	unameOut="$(uname -s)"
	case "${unameOut}" in
	    Linux*)     xdg-open $1;;
	    MINGW*)     start $1;;
	    *)          echo "I don't know how to open it...";;
	esac
	echo ${machine}

}
open_link https://chrome.google.com/webstore/detail/pro-for-trello-free-trell/hcjkfaengbcfeckhjgjdldmhjpoglecc # Pro For Trello
open_link https://chrome.google.com/webstore/detail/lastpass-free-password-ma/hdokiejnpimakedhajhdlcegeplioahd # Last Pass
open_link https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb # Vimium
open_link https://chrome.google.com/webstore/detail/spreed-speed-read-the-web/ipikiaejjblmdopojhpejjmbedhlibno # Spreed (read articles faster)
