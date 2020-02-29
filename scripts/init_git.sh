#!/bin/bash

git config --global user.name "Matheus de Souza"
git config --global user.email "mws.souza@gmail.com"

git config --global core.editor "vim"

echo 'Git configuration done!'

# Installing oh-my-git
git clone https://github.com/arialdomartini/oh-my-git.git ~/.oh-my-git && echo source ~/.oh-my-git/prompt.sh >> ~/.bashrc

# Copy the awesome fonts to ~/.fonts
git clone http://github.com/gabrielelana/awesome-terminal-fonts /tmp/awesome-terminal-fonts
cd /tmp/awesome-terminal-fonts
git checkout patching-strategy
mkdir -p ~/.fonts/oh-my-git
cp patched/*.ttf ~/.fonts/oh-my-git
cd -

# update the font-info cache
sudo fc-cache -fv ~/.fonts


echo 'Git terminal configuration done!'
