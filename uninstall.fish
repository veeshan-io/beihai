#!env fish
function ___uninstall-ashe
  rm -f $HOME/.config/fish/conf.d/play.fish
  rm -r $HOME/.local/share/ashe
  echo ashe is removed.
end

___uninstall-ashe
