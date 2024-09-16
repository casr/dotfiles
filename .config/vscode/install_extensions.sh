#!/bin/sh

set -e

# get currently installed extensions:
#
#     code --list-extensions

for ext in \
	dbaeumer.vscode-eslint \
	github.github-vscode-theme \
	esbenp.prettier-vscode \
	vscodevim.vim \
	ms-vsliveshare.vsliveshare \
; do
	code --install-extension "${ext}" --force
done
