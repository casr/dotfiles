#!/bin/sh

set -e

if [ -d "${HOME}/.dotfiles" ]; then
	cd "${HOME}/.dotfiles"
	git pull --ff-only
else
	git clone https://github.com/casr/dotfiles.git "${HOME}/.dotfiles"
fi

sys_name=$(uname -s)
sys_profile="${HOME}/.dotfiles/.profile.${sys_name}"

if [ -f "${sys_profile}" ]; then
	rm -f "${HOME}/.profile"
	ln -s "${sys_profile}" "${HOME}/.profile"
fi

mkdir -p "${HOME}/.config"
for f in \
.Xdefaults .compton.conf .config/git .config/nvim .exrc .fonts.conf .kshrc \
.mailcap .npmrc .sqliterc .tmux.conf .vim .xmodmaprc .xsession .zprofile \
.zshrc bin
do
	rm -f "${HOME}/$f"
	ln -s "${HOME}/.dotfiles/$f" "${HOME}/$f"
done

if [ -d "${HOME}/.dotfiles/.vim/pack/minpac/opt/minpac" ]; then
	git clone https://github.com/k-takata/minpac.git \
		"${HOME}/.dotfiles/.vim/pack/minpac/opt/minpac"
fi


printf 'Finish Vim set up with:\n\n\t%s\n' 'vim -c PackUpdate -c qall'
