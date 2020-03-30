export PATH="$PATH:~/Library/Android/sdk/platform-tools/"

export MYVIMRC="~/Workspace/dotfiles/.vimrc"
export VIMINIT=":source $MYVIMRC"

GREEN="\[$(tput setaf 2)\]"
GOLD="\[$(tput setaf 3)\]"
RESET="\[$(tput sgr0)\]"
get_branch_name() {
    git branch 2> /dev/null | grep '^*' | colrm 1 2
}
export PS1="${GOLD}\A${RESET} ${GREEN}\W${RESET} ${GOLD}($(get_branch_name))${RESET} > "

declare HISTCONTROL=ignoreboth:erasedups

# set VI mode
set -o vi

# Alias constructs
alias ls=ls\ -AF # list all entries except for . and ..
alias ll=ls\ -Gl # list all entries in long format
alias g=git
alias d=docker
alias lsnm="npm ls --depth=0" # list top level node modules
alias finder=open\ -a\ finder\ .
