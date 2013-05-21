LN=${LN:-ln -sn}              # Default link command

BASEDIR=$(pwd)/$(dirname $0)  # Link to the right place
BASEDIR=${BASEDIR#$HOME/}     # Saner links

${LN} $BASEDIR/gitconfig $HOME/.gitconfig
${LN} $BASEDIR/gitignore_global $HOME/.gitignore_global
