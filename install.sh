LN=${LN:-ln -sn}              # Default link command

BASEDIR=$(pwd)/$(dirname $0)  # Link to the right place
BASEDIR=${BASEDIR#$HOME/}     # Saner links

mkdir -p "${HOME}/.config/"
${LN} "../${BASEDIR}/nvim" "${HOME}/.config/nvim"
