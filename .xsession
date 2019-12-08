#!/bin/sh

set -x

. ~/.profile

pids=
cleanup() {
	kill -9 ${pids}
	rm -f ~/.Xauthority
}
trap cleanup INT TERM QUIT

xrdb < ~/.Xdefaults

# caps lock to ctrl, right alt to compose
xmodmap ~/.xmodmaprc
# turn off the system beep
xset b 0 0 0
# change the autorepeat delay and interval
xset r rate 350 35
# change the speed of the mouse acceleration and threshold
xset m 3/1 4

compton -b

if [ -x /usr/local/bin/dbus-launch -a -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
	eval `dbus-launch --sh-syntax --exit-with-x11`
fi

xbanish &
pids="${pids} $!"

xdimmer -s 5 -t 300 &
pids="${pids} $!"

dunst &
pids="${pids} $!"

dwmstatus &
pids="${pids} $!"

xconsole -geometry 960x260-10-10 -daemon -notify -exitOnFail

dwm
cleanup
