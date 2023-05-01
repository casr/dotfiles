#!/usr/bin/env zsh

__fzy-find-files() {
	setopt localoptions pipefail no_aliases 2>/dev/null

	# In case this is run in a context with many files and directories we
	# limit the pipe size to 500,000 items at which point the pipe will
	# close and the return focus back to the user.
	local item
	command find -L . -mindepth 1 2>/dev/null | \
		cut -b3- | \
		head -500000 | \
		command fzy --prompt "… ${1}" | \
		while read -r item
	do
		# man zshexpn /Parameter Expansion Flags
		print -R "${(q)item} "
	done
	return $?
}

fzy-file-widget() {
	LBUFFER="${LBUFFER}$(__fzy-find-files "${LBUFFER}")"
	zle reset-prompt
	return $ret
}

zle -N fzy-file-widget
bindkey -M emacs '^T' fzy-file-widget

__fzy-git-branches() {
	setopt localoptions pipefail no_aliases 2>/dev/null

	local item
	command git for-each-ref --sort=-'committerdate:iso8601' --format='%(refname:short)' refs/heads | \
		command fzy --prompt "… ${1}" | \
		while read -r item
	do
		# man zshexpn /Parameter Expansion Flags
		print -R "${(q)item} "
	done
	return $?
}

fzy-branch-widget() {
	if ! command git rev-parse --show-toplevel >/dev/null 2>&1; then
		return
	fi
	LBUFFER="${LBUFFER}$(__fzy-git-branches "${LBUFFER}")"
	zle reset-prompt
	return $ret
}

zle -N fzy-branch-widget
bindkey -M emacs '^G' fzy-branch-widget

__fzy-find-projects() {
	setopt localoptions pipefail no_aliases 2>/dev/null

	# Find all the project-looking directories under ~/Projects by assuming
	# that relevant candidates have a top-level `.git` directory in them.
	local item
	command find -sL ~/Projects -mindepth 1 -maxdepth 4 -path '*/node_modules/*' -prune -o -type d -exec sh -c 'test -d "$0/.git" && echo "$0"' '{}' \; -prune | \
		command fzy --prompt "… ${1}" | \
		while read -r item
	do
		# man zshexpn /Parameter Expansion Flags
		print -R "${(q)item} "
	done
	return $?
}

fzy-project-widget() {
	LBUFFER="${LBUFFER}$(__fzy-find-projects "${LBUFFER}")"
	zle reset-prompt
	return $ret
}

zle -N fzy-project-widget
bindkey -M emacs '^O' fzy-project-widget
