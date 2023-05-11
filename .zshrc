. ${HOME}/.dotfiles/aliases.sh
. ${HOME}/.dotfiles/fzy.zsh

bindkey -e

setopt INC_APPEND_HISTORY HIST_IGNORE_DUPS
unsetopt FLOW_CONTROL

zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*:git-*:heads-local' matcher 'r:|?=**'

WORDCHARS=${WORDCHARS//\//}

precmd() {
	# set OSC7 for current working directory
	print -Pn "\e]2;%/\a"
}

fpath=(~/.dotfiles/zsh/functions $fpath)
autoload -Uz promptinit && promptinit
prompt corrupt

local_zshrc="${HOME}/.dotfiles/.zshrc.local"
test -f "${local_zshrc}" && . "${local_zshrc}"

autoload -Uz compinit && compinit
