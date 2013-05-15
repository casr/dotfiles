LN=${LN:-ln -sh}              # Default link command

BASEDIR=$(pwd)/$(dirname $0)  # Link to the right place
BASEDIR=${BASEDIR#$HOME/}     # Saner links

${LN} $BASEDIR/vim   $HOME/.vim
${LN} $BASEDIR/vimrc $HOME/.vimrc
