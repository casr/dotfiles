#!/bin/sh

if command -v colorls >/dev/null; then
	alias ls='colorls -GF'
elif [ "$(uname -s)" = 'Darwin' ]; then
	alias ls='ls -GF'
else
	alias ls='ls -F'
fi
alias ll='ls -lAh'

alias mv='mv -i' rm='rm -i' cp='cp -i'
alias c80='printf "%80s\n" |tr " " "#"' c84='printf "%84s\n" |tr " " "#"'
alias gst='git st' gd='git diff' gdc='git diff --cached' glo='git log --oneline'
