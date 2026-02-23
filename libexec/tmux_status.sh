#!/bin/sh
set -eu

if [ "$(get_interface_style)" = dark ]; then
	base01=colour229
	base02=colour58
	base03=colour252
	base04=colour236
	base05=colour252
	base06=colour24
	base07=colour234
else
	base01=colour52
	base02=colour222
	base03=colour16
	base04=colour253
	base05=colour235
	base06=colour117
	base07=colour231
fi

tmux set-option -Fg message-style "fg=${base01},bg=${base02}"
tmux set-option -Fg status-style "fg=${base03},bg=${base04}"

tmux set-option -Fgw clock-mode-colour "${base03}"
tmux set-option -Fgw copy-mode-current-match-style "fg=${base01},bg=${base02}"
tmux set-option -Fgw mode-style "fg=${base05},bg=${base06}"
tmux set-option -Fgw pane-active-border-style "fg=${base03}"
tmux set-option -Fgw pane-border-style "fg=${base04}"
tmux set-option -Fgw window-status-current-style "fg=${base03},bg=${base07}"
