#!/bin/sh

sys_name=$(uname -s)
sys_profile="${HOME}/.dotfiles/.profile.${sys_name}"
local_profile="${HOME}/.dotfiles/.profile.local"

test -f "${sys_profile}" && . "${sys_profile}"

LSCOLORS=exfxcxdxbxGxDxBxGxCxDx
export LSCOLORS

EDITOR=vim
FCEDIT=${EDITOR}
export EDITOR FCEDIT

PAGER=less
GIT_PAGER="less -eXF"
LESS=-SRi
export GIT_PAGER PAGER LESS

HISTCONTROL=ignoredups:ignorespace
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=${HOME}/.sh_history
export HISTCONTROL HISTFILE HISTSIZE SAVEHIST

PIPENV_HIDE_EMOJIS=1
PIPENV_SHELL_FANCY=1
VIRTUAL_ENV_DISABLE_PROMPT=1
WORKON_HOME=/usr/local/virtualenvs
export PIPENV_HIDE_EMOJIS PIPENV_SHELL_FANCY VIRTUAL_ENV_DISABLE_PROMPT WORKON_HOME

test -f "${local_profile}" && . "${local_profile}"
