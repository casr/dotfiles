#!/bin/sh

set -e

if [ -d "${HOME}/.dotfiles" ]; then
	cd "${HOME}/.dotfiles"
	git pull --ff-only
else
	git clone https://github.com/casr/dotfiles.git "${HOME}/.dotfiles"
fi

mkdir -p "${HOME}/.config"
for f in \
.Xdefaults .compton.conf .config/git .config/nvim .exrc .fonts.conf .kshrc \
.mailcap .npmrc .profile .sqliterc .tmux.conf .vim .xmodmaprc .xsession \
.zprofile .zshrc
do
	rm -f "${HOME}/$f"
	ln -s "${HOME}/.dotfiles/$f" "${HOME}/$f"
done
