#!/bin/sh

set -e

MACPORTS_DISTFILES=https://github.com/macports/macports-base/releases/download/
MACPORTS_VERSION=2.10.0
MACPORTS_ARCHIVE="MacPorts-${MACPORTS_VERSION}.tar.bz2"
MACPORTS_ARCHIVE_RIPEMD160=519ce841f8f5f0ba34b29e71c810b6b4bfdd650a
MACPORTS_ARCHIVE_SHA256=12e8c46bce785234922dec739af226fc26fa462b3020f91850a4f5a45f375278

if [ ! -d /opt/local ]; then
	printf '%s' 'Downloading and building MacPorts'

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

printf '%s %s\n' 'Ready to install ports. Root permission must be given.'

# Remember to escape when in a heredoc
sudo -- /bin/sh -e <<EOM
if [ ! -d /opt/local ]; then
	printf '%s' 'Installing MacPorts'
	make install >/dev/null 2>&1
	printf '%s\\n' ' done.'
fi

printf '%s' 'Ensuring MacPorts paths'
# Prepend and remove any repeats
sed -i '' '1i\\
\\/opt\\/local\\/bin\\
\\/opt\\/local\\/sbin\\

/^\\/opt\\/local\\/s\\{0,1\\}bin$/d' /etc/paths

sed -i '' '1i\\
\\/opt\\/local\\/share\\/man\\

/^\\/opt\\/local\\/share\\/man$/d' /etc/manpaths
printf '%s\\n' ' done.'

/opt/local/bin/port -cq selfupdate
/opt/local/bin/port -cq install \
	entr \
	fzy \
	jq \
	neovim \
	ripgrep \
	tmux \
	zsh-completions

# enable zsh-completions
[ ! -f ~/.zshenv ] && touch ~/.zshenv
sed -i '' '
/\\/opt\\/local\\/share\\/zsh\\/site-functions/b

$ a\\
fpath=(\\/opt\\/local\\/share\\/zsh\\/site-functions \$fpath)
' ~/.zshenv
EOM
