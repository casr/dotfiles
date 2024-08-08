#!/bin/sh

# Terminal emulators declare themselves using the TERM environment variable.
# Programmes may then use the value of the TERM env to look up what features
# that emulator supports from the terminfo database (e.g. how to clear the
# screen, number of colours supported, etc).
#
# Unfortunately, the terminfo database is very old on stock macOS. It lacks
# definitions for emulators like tmux as well as many other modern emulators.
# Package managers like MacPorts are able to use a newer terminfo database for
# its programmes and therefore leverage the more recent definitions for
# whatever TERM is set. Because original macOS-compiled programmes only know of
# the older terminfo database, setting TERM to something newer 'corrupts' these
# programmes from working. Conversely, setting TERM to something that's in the
# old and new database means the emulator's features are misreported and not
# used.
#
# The below creates a workaround for this. The system terminfo database can be
# augmented with a user database in the HOME directory. We export definitions
# from the newer database and compile them into the current user's database.
# Unfortunately, this database is also picked up by the newer terminfo database
# as well and an old compiled version of a emulator definition does not play
# well with a new version. We get around this by using the TERMINFO_DIRS
# environment variable which we set to fallback on the user database only if it
# is missing in the main one.

macports_infocmp=/opt/local/bin/infocmp
system_tic=/usr/bin/tic

terms="alacritty alacritty-direct tmux tmux-256color tmux-direct"
terminfo_src="$(mktemp)"

# Explicitly setting `TERMINFO` will force this directory to be preferred over
# anything in `$HOME/.terminfo`. This is necessary as we'll be writing to
# `$HOME/.terminfo` eventually so we do not want any previous values to
# interfere.
export TERMINFO=/opt/local/share/terminfo

for term in ${terms}; do
	# Later versions of terminfo can define `pairs` to a higher value than
	# ncurses <6.1 supported but we have to remain compatible with ncurses
	# 6.0 because that is what macOS ships with.
	"${macports_infocmp}" -x "${term}" | sed -e 's/pairs#0x10000/pairs#32767/'
done > "${terminfo_src}"

# Compile the new definition with the old tic
"${system_tic}" -xe "$(printf '%s\n' "${terms}" | tr ' ' ,)" -o "$HOME/.terminfo" "${terminfo_src}"

rm -f "${terminfo_src}"
