LN=${LN:-ln -sh}              # Default link command

BASEDIR=$(pwd)/$(dirname $0)  # Link to the right place
BASEDIR=${BASEDIR#$HOME/}     # Saner links

${LN} $BASEDIR/zsh    $HOME/.zsh
${LN} $BASEDIR/zshrc  $HOME/.zshrc
${LN} $BASEDIR/zshenv $HOME/.zshenv
