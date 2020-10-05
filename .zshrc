. ${HOME}/.dotfiles/aliases.sh
. ${HOME}/.dotfiles/prompt.sh

bindkey -e

setopt INC_APPEND_HISTORY HIST_IGNORE_DUPS
unsetopt FLOW_CONTROL

zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
autoload -Uz compinit && compinit

WORDCHARS=${WORDCHARS//\/}

setopt PROMPT_SUBST
if [ "${TERM}" = "vt220" ]; then
	PS1=$'\e]2;%d\a\n%~$(__git_ps1 \'  %s\')\n\$(__subshell \'(%s) \')${__prompt_symbol}'
else
	PS1=$'\e]2;%d\a\n\e[34m%~\e[0m\e[35m$(__git_ps1 \' %s\')\e[0m\n\$(__subshell \'(%s) \')${__prompt_symbol}'
fi
