. ${HOME}/.dotfiles/aliases.sh
. ${HOME}/.dotfiles/prompt.sh

bindkey -e

setopt INC_APPEND_HISTORY HIST_IGNORE_DUPS
unsetopt FLOW_CONTROL

zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
autoload -Uz compinit && compinit

WORDCHARS=${WORDCHARS//\/}

setopt PROMPT_SUBST

# man zshcontrib /GATHERING INFORMATION FROM VERSION CONTROL SYSTEMS
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats "  %b"
zstyle ':vcs_info:*' actionformats "  %b (%a)"
precmd() { vcs_info }

# man zshmisc /EXPANSION OF PROMPT SEQUENCES
PS1=
# a gap between the last command's output is nice
PS1+=$'\n'
# the current path
PS1+=%~
# show branch info
PS1+='${vcs_info_msg_0_}'
PS1+=$'\n'
# indicate if user is running with privileges. i.e. root
PS1+=%(!.# .$ )
