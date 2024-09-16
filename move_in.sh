#!/bin/sh

set -e

base_dir="${HOME}/.dotfiles"

if [ ! -d "${base_dir}" ]; then
	git clone https://github.com/casr/dotfiles.git "${base_dir}"
fi

__link() {
	source_file="${base_dir}/$1"
	target_file="$2"
	if [ ! -e "${source_file}" ]; then
		printf '\e[07m[ FAIL ]\e[0m "%s" does not exist, cannot create link\n' "${source_file}"
		return
	fi

	if [ -h "${target_file}" ]; then
		current_link="$(/bin/ls -l "${target_file}" | sed 's_^.*-> __')"
		if [ "${current_link}" = "${source_file}" ]; then
			printf '[ SKIP ] "%s" already links to "%s"\n' "${target_file}" "${source_file}"
		else
			printf '\e[07m[ FAIL ]\e[0m link exists to "%s", expected "%s"\n' "${current_link}" "${source_file}"
		fi
		return
	fi

	if [ -e "${target_file}" ]; then
		printf '\e[07m[ FAIL ]\e[0m file exists, cannot link "%s"\n' "${target_file}"
		return
	fi

	ln -s "${source_file}" "${target_file}"
	printf '[ DONE ] "%s" linked to "%s"\n' "${target_file}" "${source_file}"
}

__link_x11() {
	__link .Xdefaults "${HOME}/.Xdefaults"
	__link .compton.conf "${HOME}/.compton.conf"
	__link .fonts.conf "${HOME}/.fonts.conf"
	__link .xmodmaprc "${HOME}/.xmodmaprc"
	__link .xsession "${HOME}/.xsession"
}

__link_config_dir() {
	mkdir -p "${HOME}/.config"
	__link .config/alacritty "${HOME}/.config/alacritty"
	__link .config/git "${HOME}/.config/git"
	__link .config/nvim "${HOME}/.config/nvim"
}

__link_base() {
	__link .exrc "${HOME}/.exrc"
	__link .kshrc "${HOME}/.kshrc"
	__link .mailcap "${HOME}/.mailcap"
	__link .npmrc "${HOME}/.npmrc"
	__link .profile "${HOME}/.profile"
	__link .sqliterc "${HOME}/.sqliterc"
	__link .tmux.conf "${HOME}/.tmux.conf"
	__link .vim "${HOME}/.vim"
	__link .zprofile "${HOME}/.zprofile"
	__link .zshrc "${HOME}/.zshrc"
}

__link_base
__link_config_dir

case "$(uname -s)" in
	Darwin)
		;;
	*)
		__link_x11
		;;
esac

# Sync interface changes (also creates Alacritty's theme.toml as a side-effect)
PATH="${base_dir}/bin:${PATH}" "${base_dir}/bin/set_appearance.sh"
