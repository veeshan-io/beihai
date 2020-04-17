#!env fish

if not test -d $HOME/.config/fish/conf.d
  mkdir -p $HOME/.config/fish/conf.d
end

set __SHARE $HOME/.local/share
if not test -d $__SHARE
  mkdir -p $__SHARE
end

if test -d $HOME/.local/share/ashe
  git -C $__SHARE add * && git -C $__SHARE stash && git -C $__SHARE pull --rebase &&  git -C $__SHARE stash apply
else
  git -C $__SHARE clone https://gitee.com/veeshan/ashe.git
end

if test -f $HOME/.config/fish/conf.d/play.fish
  rm $HOME/.config/fish/conf.d/play.fish
end
ln -s $HOME/.local/share/ashe/play.fish $HOME/.config/fish/conf.d/play.fish
fish -l
