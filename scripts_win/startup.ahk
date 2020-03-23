Run, C:/Program Files (x86)/BraveSoftware/Brave-Browser/Application/brave.exe
Run, ../AppData/Roaming/Spotify/Spotify.exe

Run, C:/xampp/xampp-control.exe

Run, ../Documents/Apps/emacs/bin/emacs.exe --daemon
Sleep, 20000
Run, ../Documents/Apps/emacs/bin/emacsclient.exe -nc

#Include windows-i3.ahk