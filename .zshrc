source "${HOME}/.zsh/aliases.zsh"
source "${HOME}/.zsh/vi.zsh"
source "${HOME}/.zsh/autoenv/autoenv.zsh"

# history {{{
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY HIST_IGNORE_ALL_DUPS
# }}}

# completions {{{
unsetopt FLOW_CONTROL

zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

autoload -U compinit && compinit
# }}}

WORDCHARS=${WORDCHARS//\/}

setopt TRANSIENT_RPROMPT
autoload -Uz promptinit && promptinit
prompt corrupt

# Pick up current directory. Useful for new tabs/windows of the terminal
# emulator
precmd() {
  print -Pn "\e]2; %~/ \a"
}
