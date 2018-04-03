LN=${LN:-ln -sn}              # Default link command

# Link to the right place
if [ "$(dirname $0)" = '.' ]; then
  BASEDIR="$(pwd)"
else
  BASEDIR="$(pwd)/$(dirname $0)"
fi
BASEDIR=${BASEDIR#$HOME/}     # Saner links

check_backup() {
  local filename
  local backup
  filename="$1"
  if [ -e $filename ]; then
    printf -- "$filename already exists. Making backup and removing...\n"
    if [ -d $filename ]; then
      backup="$(mktemp -d $filename.backup.XXXXXX)" || exit 1
      cp -R $filename $backup && rm -rf $filename
    else
      backup="$(mktemp $filename.backup.XXXXXX)" || exit 2
      cp $filename $backup && rm -f $filename
    fi
    printf -- "created $backup\n"
  fi
}

check_backup $HOME/.zsh && $LN $BASEDIR/zsh $HOME/.zsh
check_backup $HOME/.zshrc && {
  printf -- "source \"\${HOME}/$BASEDIR/zshrc\"\n" >$HOME/.zshrc
}
check_backup $HOME/.zshenv && {
  printf -- "source \"\${HOME}/$BASEDIR/zshenv\"\n" >$HOME/.zshenv
}
