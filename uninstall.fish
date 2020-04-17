#!env fish

function play-book
  echo ashe is removed.
end

function ___uninstall-ashe
  rm -f $HOME/.config/fish/conf.d/play.fish
  rm -r $HOME/.local/share/ashe
  play-book
end

___uninstall-ashe
