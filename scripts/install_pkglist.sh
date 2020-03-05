#!/bin/bash
command_exists () {
    type "$1" &> /dev/null ;
}

AUR_PROGRAM="yay"
DEFAULT_DIR="${HOME}/scripts"

echo 'Tell me what installation is (Ex. arch, arch_vm):'; read INSTALL_TYPE;

sudo pacman -S --needed - < pkglist.txt

yay -S --needed - < pkglist.txt

sudo pacman -S --needed - < "${DEFAULT_DIR}/pkglist_${INSTALL_TYPE}.txt"

if  command_exists $AUR_PROGRAM ; then
    yay -S --needed - < "${DEFAULT_DIR}/pkglist_${INSTALL_TYPE}_${AUR_PROGRAM}.txt"
fi
