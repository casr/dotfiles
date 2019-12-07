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

sys_name=$(uname -s)
sys_profile=".profile.${sys_name}"

if [ -f "${sys_profile}" ]; then
        rm -f "${HOME}/.profile"
        ln -s "${HOME}/.dotfiles/${sys_profile}" "${HOME}/.profile"
fi

mkdir -p "${HOME}/.config"
for f in .config/git .config/nvim .kshrc .tmux.conf .vim .zprofile .zshrc
do
	rm -f "${HOME}/$f"
	ln -s "${HOME}/.dotfiles/$f" "${HOME}/$f"
done


printf "Finish Vim set up with:\n\n\t%s\n" "vim -c PackUpdate -c qall"
