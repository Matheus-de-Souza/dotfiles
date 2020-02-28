#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#====================#
#=== Arch Aliases ===#
#====================#
alias pacman='pacman --color=auto'

#===================#
#=== Git Aliases ===#
#===================#

alias gc='git clone'
alias ga='git add'
alias gs='git status'
alias gsu='git submodule update --init --recursive'
alias gF='git pull'
alias gp='git push'
alias gd='git diff'
alias gc='git commit -v'
alias gcm='git commit -v -m'
alias gca='git commit --amend --no-edit-message'

alias gb='git branch'
alias gco='git checkout'
alias gll='git log --graph --pretty=oneline --abbrev-commit'
alias gg="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
alias gsl="git shortlog -sn"
alias gwc="git whatchanged"

#==========================#
#=== Copy/Paste Aliases ===#
#==========================#

case $OSTYPE in
  linux*)
    XCLIP=$(command -v xclip)
    [[ $XCLIP ]] && \
    alias pbcopy="$XCLIP -selection clipboard" && \
    alias pbpaste="$XCLIP -selection clipboard -o"
    ;;   
esac

# to use it just install xclip on your distribution and it would work like:
# $ echo "hello" | pbcopy
# $ pbpaste
# hello

# very useful for things like:
# cat ~/.ssh/id_rsa.pub | pbcopy
# have fun!

#=========================#
#=== Directory Aliases ===#
#=========================#

alias ls='ls --color=auto'
alias .='ls'             # Go up one directory
alias ..='cd ..'         # Go up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up three directories
alias -- -='cd -'        # Go back

# PS1='[\u@\h \W]\$ '

#================================#
#=== Stop Terminal Annoyances ===#
#================================#

# Stop Ctrl+S freezing on terminal
stty -ixon

# Stop beeping on tabs
setterm -bfreq 0

