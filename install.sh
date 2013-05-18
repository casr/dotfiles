LN=${LN:-ln -sn}              # Default link command

BASEDIR=$(pwd)/$(dirname $0)  # Link to the right place
BASEDIR=${BASEDIR#$HOME/}     # Saner links

${LN} $BASEDIR/tmux.conf   $HOME/.tmux.conf
