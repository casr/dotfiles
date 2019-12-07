. /etc/ksh.kshrc
. ${HOME}/.dotfiles/completions.ksh
. ${HOME}/.dotfiles/aliases.sh
. ${HOME}/.dotfiles/prompt.sh

# Clear the screen but remember current input
bind -m '^L'='^U 'clear'^J^Y'

if [ "${TERM}" = "vt220" ]; then
	PS1="\e]2;\${PWD}\a\n\w\$(__git_ps1 '  %s')\n\$(__subshell '(%s) ')\${__prompt_symbol}"
else
	PS1="\e]2;\${PWD}\a\n\e[34m\w\e[0m\e[35m\$(__git_ps1 ' %s')\e[0m\n\$(__subshell '(%s) ')\${__prompt_symbol}"
fi
