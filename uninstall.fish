#!env fish

function play-book
  echo ashe is removed.
end

function ___uninstall-ashe
  if test -f $HOME/.config/fish/conf.d/play.fish
    rm -f $HOME/.config/fish/conf.d/play.fish
  end
  if test -d $HOME/.local/share/ashe
    rm -r $HOME/.local/share/ashe
  end
  play-book
end

___uninstall-ashe
