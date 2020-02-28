#!/bin/bash

sudo pacman -Qqen | grep -v "virtualbox" > pkglist.txt
