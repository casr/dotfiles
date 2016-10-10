if command -v npm >/dev/null 2>&1; then
  path=($(npm -g bin 2>/dev/null) $path)
fi
if command -v python >/dev/null 2>&1; then
  path=($(python -c "from distutils.sysconfig import PREFIX; print(PREFIX+'/bin')") $path)
fi

# Mac Aliases
alias vu='osascript -e "set volume output volume (output volume of (get volume settings) + 7)"'
alias vd='osascript -e "set volume output volume (output volume of (get volume settings) - 7)"'
alias mute='osascript -e "set volume output muted not (output muted of (get volume settings))"'
alias lockscreen='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

# Aliases
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'
alias ls='ls -GF'
alias ll='ls -lAh'
alias l.='ls -d .[^.]*'
alias cd..='cd ../'
alias st='git status'
alias d='git diff'
alias view='tmux split-window -h -l 84 nvim -R -u ~/.config/nvim/readonly.vim'

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Open new (tab/window) in same directory (OS X)
precmd  () {print -Pn "\e]2; %~/ \a"}
preexec () {print -Pn "\e]2; %~/ \a"}

# Set up history
setopt HIST_IGNORE_DUPS
HISTFILE=~/.zhistory
HISTSIZE=5000
SAVEHIST=1000
setopt appendhistory autocd extendedglob

# Use / as a word break
WORDCHARS=${WORDCHARS//\/}

# Rebind HOME and END to do the decent thing:
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# And DEL too, as well as PGDN and INSERT:
bindkey '^[[3~' delete-char
bindkey '^[[6~' end-of-history

autoload -U compinit colors promptinit
compinit -C
colors
promptinit
prompt pure

export FZF_DEFAULT_COMMAND='
    ( git ls-files . --cached --others --exclude-standard ||
      find . -type f -print -o -type l -print ) 2>/dev/null'
export FZF_CTRL_T_COMMAND='locate ${PWD}'
export FZF_CTRL_R_OPTS='--sort'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
