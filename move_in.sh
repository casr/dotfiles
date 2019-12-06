#!/bin/sh

set -e

if [ -d "${HOME}/.dotfiles" ]; then
	cd "${HOME}/.dotfiles"
	git pull --ff-only
	git submodule update
else
	git clone https://github.com/casr/dotfiles.git "${HOME}/.dotfiles"
	cd "${HOME}/.dotfiles" && git submodule update --init
fi

mkdir -p "${HOME}/.config"
for f in .config/git .config/nvim .tmux.conf .vim .zsh .zshenv .zshrc
do
	rm -f "${HOME}/$f"
	ln -s "${HOME}/.dotfiles/$f" "${HOME}/$f"
done
