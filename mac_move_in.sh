#!/bin/sh

set -e

if ! ls ~/Library/Messages >/dev/null 2>&1; then
	printf '%s: %s\n%s\n\n\t%s\n' \
		"$(basename "$0")" \
		'You must enable Full Disk Access for Terminal.app before running this ' \
		'script. See:' \
		'System Settings > Privacy & Security > Full Disk Access' >&2
	exit 1
fi

"${HOME}/.dotfiles/macos_defaults.sh"

if ! command -v xcode-select >/dev/null; then
	printf '%s\n%s\n' \
	       'You need to install Xcode from the Mac App Store and then '
	       're-run this script.'
	exit 1
fi

printf '%s' 'Checking for Xcode Command Line Tools...'
if ! xcode-select --install 2>/dev/null; then
	printf '%s\n' ' done.'
else
	printf '%s\n' ' installing. Press enter to continue when finished'
	read
fi

"${HOME}/.dotfiles/macports.sh"
