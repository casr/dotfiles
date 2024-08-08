#!/bin/sh

style=$(get_interface_style)

ln -fs chromatine_${style}.toml ~/.dotfiles/.config/alacritty/theme.toml \
	&& touch ~/.config/alacritty/alacritty.toml

tmux source-file ~/.dotfiles/.tmux.conf 2>/dev/null || true
