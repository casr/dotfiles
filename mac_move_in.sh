#!/bin/sh

set -e

__dock_item() {
	printf '%s%s%s%s%s' \
	       '<dict><key>tile-data</key><dict><key>file-data</key><dict>' \
	       '<key>_CFURLString</key><string>' \
	       "$1" \
	       '</string><key>_CFURLStringType</key><integer>0</integer>' \
	       '</dict></dict></dict>'
}

printf '%s' 'Setting up Dock icons...'
defaults write com.apple.dock \
               persistent-apps -array "$(__dock_item /System/Applications/Utilities/Terminal.app)" \
                                      "$(__dock_item /Applications/Safari.app)"
killall Dock
printf '%s\n' ' done.'

printf '%s' 'Removing copy style from Terminal.app...'
defaults write com.apple.Terminal \
               CopyAttributesProfile com.apple.Terminal.no-attributes
printf '%s\n' ' done.'

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

MACPORTS_DISTFILES=https://distfiles.macports.org/MacPorts
MACPORTS_VERSION=2.6.2
MACPORTS_ARCHIVE="MacPorts-${MACPORTS_VERSION}.tar.bz2"
MACPORTS_ARCHIVE_RIPEMD160=1400db2449d50e77d5d30e5f0820bb339dc3b080
MACPORTS_ARCHIVE_SHA256=1b58ccbb1cd6c6fab5e1f15b959208ef5233802fc9ac9585037d21c8e42e2b70

if [ -d /opt/local ]; then
	printf '%s\n' '... skipped.'
else
	cd "$(mktemp -d)"
	curl -sLo "${MACPORTS_ARCHIVE}" "${MACPORTS_DISTFILES}/${MACPORTS_ARCHIVE}"
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
/opt/local/bin/port -cq install entr fzy git ledger neovim openssh par pass \
                        pinentry the_silver_searcher tmux tmux-pasteboard vim \
                        zsh

sed -i '' '\$a\\
\\/opt\\/local\\/bin\\/zsh\\

/^\\/opt\\/local\\/bin\\/zsh$/d' /etc/shells
# Grab the original username by NOT escaping
chsh -s /opt/local/bin/zsh "${USER}"
EOM
