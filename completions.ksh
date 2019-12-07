#!/bin/ksh

# pass

prefix=${PASSWORD_STORE_DIR:-${HOME}/.password-store}

set -A password_files "${prefix}"/**/*.gpg
i=0; while [ $i -lt ${#password_files[@]} ]; do
	password_files[$i]="${password_files[$i]#"${prefix}/"}"
	password_files[$i]="${password_files[$i]%.gpg}"
	i=$((i+1))
done

set -A complete_pass -- "${password_files[@]}" init ls list grep find search show insert edit generate rm mv cp git help version

# mbsync

OLD_IFS=${IFS}
IFS='
'
set -A complete_mbsync -- $(grep -E '^(Channel|Group)' "${HOME}/.mbsyncrc" | cut -d\  -f 2-)
IFS=${OLD_IFS}

set -A complete_git_1 -- add bl blr branch checkout cherry-pick clean clone commit config diff diff-base fetch files log merge plog prlog pull push rebase reflog reset revert stash status

# __refresh_completions() {
# 	if git rev-parse --is-inside-work-tree 2>/dev/null; then
# 		notify-send "${PWD}"
# 		set -A complete_git -- $(git for-each-ref --sort='committerdate:iso8601' --format="%(refname:short)")
# 		notify-send "${complete_git}"
# 	fi
# }
