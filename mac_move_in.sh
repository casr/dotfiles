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

printf '%s' 'Downloading and building MacPorts'

MACPORTS_DISTFILES=https://github.com/macports/macports-base/releases/download/
MACPORTS_VERSION=2.8.0
MACPORTS_ARCHIVE="MacPorts-${MACPORTS_VERSION}.tar.bz2"
MACPORTS_ARCHIVE_RIPEMD160=9e19c206cfb43b9f3368696297f969e0415b5c4b
MACPORTS_ARCHIVE_SHA256=9988f093007fc12e5b7059144706cbb509e4e8d0277b2c27213c1f5340cd2cef

if [ -d /opt/local ]; then
	printf '%s\n' '... skipped.'
else
	cd "$(mktemp -d)"
	curl -sLo "${MACPORTS_ARCHIVE}" "${MACPORTS_DISTFILES}/v${MACPORTS_VERSION}/${MACPORTS_ARCHIVE}"
	if [ "z${MACPORTS_ARCHIVE_RIPEMD160}" != "z$(cat "${MACPORTS_ARCHIVE}" | openssl dgst -ripemd160)" ]; then
		printf '%s\n' 'RIPEMD160 digest does not match record'
		exit 1
	fi

	if [ "z${MACPORTS_ARCHIVE_SHA256}" != "z$(cat "${MACPORTS_ARCHIVE}" | openssl dgst -sha256)" ]; then
		printf '%s\n' 'SHA256 digest does not match record'
		exit 1
	fi

	tar xjf "${MACPORTS_ARCHIVE}"
	cd "MacPorts-${MACPORTS_VERSION}/"
	if ! ./configure >/dev/null; then
		printf '%s\n' '... FAILED.'
		exit 1
	else
		printf '%s' '.'
	fi

	# MacPorts' build process currently spits out a lot of warnings...
	if ! make >/dev/null 2>&1; then
		printf '%s\n' '.. FAILED.'
		exit 1
	else
		printf '%s' '.'
	fi

	printf '%s\n' ' done.'

fi

printf '%s %s\n' 'Ready to install MacPorts and ports. Root permission must' \
              'be given.'

# Remember to escape when in a heredoc
sudo -- /bin/sh -e <<EOM
if [ ! -d /opt/local ]; then
	make install >/dev/null 2>&1
fi

# Prepend and remove any repeats
sed -i '' '1i\\
\\/opt\\/local\\/bin\\
\\/opt\\/local\\/sbin\\

/^\\/opt\\/local\\/s\\{0,1\\}bin$/d' /etc/paths

sed -i '' '1i\\
\\/opt\\/local\\/share\\/man\\

/^\\/opt\\/local\\/share\\/man$/d' /etc/manpaths

/opt/local/bin/port -cq selfupdate
/opt/local/bin/port -cq install 7zip entr fzy git jq miller neovim \
                                par pass pinentry the_silver_searcher \
                                tmux unrar vim zsh-completions
EOM
