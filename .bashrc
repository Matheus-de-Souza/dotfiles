#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#===================#
#=== Git Aliases ===#
#===================#
alias bashrc='vim ~/.bashrc'
alias reload='source ~/.bashrc'

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

alias gmv='git mv'
alias grm='git rm'

alias gb='git branch'
alias gco='git checkout'
alias gl="git shortlog -sn"
alias gll='git log --graph --pretty=oneline --abbrev-commit'
alias glg="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
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

#==============================#
#=== Directory/File Aliases ===#
#==============================#

alias ls='ls --color=auto'
alias lsa='ls -la --color=auto' # Use a long listing format

alias ~='cd ~/'          # Go to home
alias .='pwd'            # Print current directory
alias .='ls'             # Go up one directory
alias ..='cd ..'         # Go up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up three directories
alias -- -='cd -'        # Go back

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'

#==================================#
#=== System Maintenance Aliases ===#
#==================================#

alias pacman='pacman --color=auto'
alias df='df --human-readable' # Show Filesystem Size

#================================#
#=== Stop Terminal Annoyances ===#
#================================#

# Stop Ctrl+S freezing on terminal
stty -ixon

# Stop beeping on tabs
if [ command -v setterm >/dev/null 2>&1 ]; then
  setterm -bfreq 0
fi

#===============#
#=== Helpers ===#
#===============#
alias tb="nc termbin.com 9999" 

# Set up Node Version Manager
NVM_INIT=/usr/share/nvm/init-nvm.sh
if test -e $NVM_INIT; then
    source $NVM_INIT
fi

#===================#
#=== PS1 Hacking ===#
#===================#

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

#export PS1="\`parse_git_branch\` "

#if [ command -v tput >/dev/null 2>&1 ]; then
  PS1="\A \[$(tput sgr0)\]\[\033[38;5;11m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\h \[$(tput sgr0)\]\[\033[38;5;6m\][\w]\[$(tput sgr0)\]\[\033[38;5;15m\]\n\$ "
#else
  #PS1='\A \u@\h [\w]\n\$ '
#fi

if [ "$(hostname)" == "arch" ]; then
  source $HOME/.oh-my-git/prompt.sh
fi
