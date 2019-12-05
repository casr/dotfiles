fpath=($HOME/.zsh/functions $fpath)

if [[ $__CUSTOM_ENVIRONMENT != yes ]]
then
  __CUSTOM_ENVIRONMENT=yes

  # TERMINFO=/opt/local/share/terminfo
  # TERM=nsterm-256color

  EDITOR=vis
  VISUAL=vis

  VIMINIT="let \$MYVIMRC='${XDG_CONFIG_HOME:-$HOME/.config}/nvim/init.vim' | source \$MYVIMRC"

  # export __CUSTOM_ENVIRONMENT TERMINFO TERM EDITOR VISUAL VIMINIT
  export __CUSTOM_ENVIRONMENT EDITOR VISUAL VIMINIT
fi
