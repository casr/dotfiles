#!/bin/sh

set -e

if [ -d "${HOME}/.dotfiles" ]; then
	cd "${HOME}/.dotfiles"
	git pull --ff-only
else
	git clone https://github.com/casr/dotfiles.git "${HOME}/.dotfiles"
	git clone https://github.com/k-takata/minpac.git \
		"${HOME}/.dotfiles/.vim/pack/minpac/opt/minpac"
fi

mkdir -p "${HOME}/.config"
for f in .config/git .config/nvim .tmux.conf .vim .zsh .zshenv .zshrc
do
	rm -f "${HOME}/$f"
	ln -s "${HOME}/.dotfiles/$f" "${HOME}/$f"
done


printf "Finish Vim set up with:\n\n\t%s\n" "vim -c PackUpdate -c qall"
