. ${HOME}/.dotfiles/aliases.sh
. ${HOME}/.dotfiles/fzy.zsh
. ${HOME}/.dotfiles/prompt.sh

bindkey -e

setopt INC_APPEND_HISTORY HIST_IGNORE_DUPS
unsetopt FLOW_CONTROL

zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

WORDCHARS=${WORDCHARS//\/}

precmd() {
	print -Pn "\e]2;%/\a"
}

fpath=(~/.dotfiles/zsh/functions $fpath)
autoload -Uz promptinit && promptinit
prompt corrupt

local_zshrc="${HOME}/.dotfiles/.zshrc.local"
test -f "${local_zshrc}" && . "${local_zshrc}"

autoload -Uz compinit && compinit
