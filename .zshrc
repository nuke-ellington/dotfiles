source ~/.profile

function get_branch_name() {
    branch=$(git branch 2> /dev/null | grep '^*' | colrm 1 2)
    if [ "$branch" ]
    then
	echo "[$branch]"
    fi
}

setopt prompt_subst

GREEN="$(tput setaf 2)"
GOLD="$(tput setaf 3)"
RESET="$(tput sgr0)"

prompt="${GOLD}%W %*${RESET} ${GREEN}%1~${RESET} ${GOLD}\$(get_branch_name)${RESET}> "


