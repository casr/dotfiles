# Prefer vi shortcuts
bindkey -v
DEFAULT_VI_MODE=viins
KEYTIMEOUT=1

bindkey '^p' up-history
bindkey '^n' down-history

bindkey '^f' forward-char
bindkey '^b' backward-char
bindkey '^d' delete-char
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

bindkey '^[f' forward-word
bindkey '^[b' backward-word
bindkey '^[d' kill-word
bindkey '^w' backward-kill-word

bindkey '^r' history-incremental-search-backward

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

bindkey '^k' kill-line
bindkey '^u' backward-kill-line

bindkey '\e.' insert-last-word

__set_cursor() {
    local style
    case $1 in
        reset) style=0;; # The terminal emulator's default
        blink-block) style=1;;
        block) style=2;;
        blink-underline) style=3;;
        underline) style=4;;
        blink-vertical-line) style=5;;
        vertical-line) style=6;;
    esac

    [ $style -ge 0 ] && print -n -- "\e[${style} q"
}

__set_vi_mode_cursor() {
    case $KEYMAP in
        vicmd)
          __set_cursor block
          ;;
        main|viins)
          __set_cursor vertical-line
          ;;
    esac
}

__get_vi_mode() {
    local mode
    case $KEYMAP in
        vicmd)
          mode='NORMAL'
          ;;
        main|viins)
          mode=
          ;;
    esac
    print -n -- $mode
}

zle-keymap-select() {
    __set_vi_mode_cursor
    zle reset-prompt
}

zle-line-init() {
    zle -K $DEFAULT_VI_MODE
}

zle-line-finish() {
    # Let applications manage their own cursor
    __set_cursor reset
}

zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-finish
