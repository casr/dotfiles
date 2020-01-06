__subshell() {
	if [ "z${PIPENV_ACTIVE}" = "z1" ]; then
		# Set this so that the shell is not super slow...
		if [ -z "${PIPENV_NAME}" ]; then
			s="$(pipenv --where)"
			printf "$1" "${s##*/}"
		else
			printf "$1" "${PIPENV_NAME}"
		fi
	fi
}

# Might need to disect the below for a better experience...
# https://github.com/git/git/blob/041fe8f/contrib/completion/git-prompt.sh#L393-L460
__git_ps1() {
	local branch_name=$(git -C "${PWD}" symbolic-ref --short HEAD 2>/dev/null)
	if [ -z "${branch_name}" ]; then
		branch_name=$(git -C "${PWD}" describe --contains --all HEAD 2>/dev/null)
		if [ ! -z "${branch_name}" ]; then
			printf "$1" "${branch_name}"
		fi
	else
		printf "$1" "${branch_name}"
	fi
}

__prompt_symbol='$ '
[ $(id -u) -eq 0 ] && __prompt_symbol='# '
