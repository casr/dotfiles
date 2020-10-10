#!/bin/sh

set -e

__dock_item() {
	app_path="$(mdfind "kMDItemKind=Application \
	                    && kMDItemDisplayName=\"$1\"")"
	printf '%s%s%s%s%s' \
	       '<dict><key>tile-data</key><dict><key>file-data</key><dict>' \
	       '<key>_CFURLString</key><string>' \
	       "${app_path}" \
	       '</string><key>_CFURLStringType</key><integer>0</integer>' \
	       '</dict></dict></dict>'
}

printf '%s' 'Setting up Dock...'
defaults write com.apple.dock \
               persistent-apps -array "$(__dock_item Terminal)" \
                                      "$(__dock_item Safari)"
defaults write com.apple.dock show-recents -bool no
defaults write com.apple.dock tilesize -int 40
defaults write com.apple.dock size-immutable -bool yes
defaults write com.apple.dock contents-immutable -bool yes
killall Dock
printf '%s\n' ' done.'

printf '%s' 'Removing copy style from Terminal.app...'
defaults write com.apple.Terminal \
               CopyAttributesProfile com.apple.Terminal.no-attributes
printf '%s\n' ' done.'

printf '%s' 'Removing shadow from screenshots...'
defaults write com.apple.screencapture disable-shadow -bool true
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
MACPORTS_VERSION=2.6.3
MACPORTS_ARCHIVE="MacPorts-${MACPORTS_VERSION}.tar.bz2"
MACPORTS_ARCHIVE_RIPEMD160=c4009fc935603377867af1ab09ad34f980695ca4
MACPORTS_ARCHIVE_SHA256=c784f0556102bf7947b1cb8f4607bfa76351a4da8cbdab0dcc89c56f18834f01

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
/opt/local/bin/port -cq install entr fzy git jq miller neovim openssh par pass \
                                pinentry the_silver_searcher tig tmux \
                                tmux-pasteboard vim zsh-completions
EOM
