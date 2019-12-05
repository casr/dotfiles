alias mv='mv -i' cp='cp -i' rm='rm -i'
alias ls='ls -GF' ll='ls -lAh'
alias c80='printf "%80s\n" |tr " " "#"' c84='printf "%84s\n" |tr " " "#"'
alias tree='LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:" tree --dirsfirst -FI node_modules'

# networking {{{
alias ip='netstat -n -t | awk "{print \$4}" | grep -o "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*" | grep -v 127.0.0.1 | sort -u'
alias eip='dig +short myip.opendns.com @resolver1.opendns.com'
# }}}

# node {{{
alias npkg='test -e package.json && jq --color-output "{ name: .name, devDependencies: .devDependencies, dependencies: .dependencies }" package.json | less -RXE'
alias nscr='test -e package.json && jq --color-output "{ name: .name, scripts: .scripts }" package.json | less -RXE'
# }}}

# pass {{{
gpass() {
  local PASSWORD_STORE_DIR="$HOME/.password-store"
  local PASSWORD="$(find "$PASSWORD_STORE_DIR" -type f -iname '*.gpg' | sed -e "s_^${PASSWORD_STORE_DIR}/__" -e 's/.gpg$//' | fzy)"
  echo pass $* "\"$PASSWORD\""
  pass $* "$PASSWORD"
}

gpassc() {
  gpass -c
}
# }}}

# git {{{
alias st='git status' d='git diff' dc='git diff --cached'

git-serve() {
  GIT_DIR="$(git rev-parse --show-toplevel)"
  if [ $? -eq 0 ]; then
    printf -- "On the other machine do:\n\n"
    printf -- "    git clone git://$(ip)/ $(basename $GIT_DIR)\n\n"
    printf -- "Note: slash is important!\n\n"
    git daemon --reuseaddr --verbose --base-path=. --export-all ./.git
  fi
}

git-pr() {
  BASE="${1:-origin/master}"
  COMPARE="${2:-HEAD}"
  ANCESTOR="$(git merge-base ${COMPARE} ${BASE})"
  if [ $? -eq 0 ]; then
    printf -- "base: $BASE\ncompare: $COMPARE\nancestor: $ANCESTOR\n\n"
    git --no-pager diff --name-status $ANCESTOR $COMPARE
    printf -- "\n"
    git --no-pager log --decorate=no --oneline --reverse $ANCESTOR..$COMPARE
  fi
}
# }}}
