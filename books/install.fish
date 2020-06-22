#!env fish
function ___install-ashe
  if not test -d $HOME/.config/fish/conf.d
    mkdir -p $HOME/.config/fish/conf.d
  end

  set -l __SHARE $HOME/.local/share
  if not test -d $__SHARE
    mkdir -p $__SHARE
  end

  if test -d $__SHARE/ashe
    cd $__SHARE/ashe
    git add * && git stash && git pull --rebase && git stash pop
  else
    git -C $__SHARE clone https://gitee.com/veeshan/ashe.git
  end

  if test -f $HOME/.config/fish/conf.d/ashe-init.fish
    rm $HOME/.config/fish/conf.d/ashe-init.fish
  end
  ln -s $__SHARE/ashe/init.fish $HOME/.config/fish/conf.d/ashe-init.fish
  fish -l
end

___install-ashe
