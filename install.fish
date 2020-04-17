#!env fish

if test -d $HOME/.config/fish/conf.d
  mkdir -p $HOME/.config/fish/conf.d
end

if test -d $HOME/.local/share/
  mkdir -p $HOME/.local/share/
end

git clone https://gitee.com/veeshan/ashe.git $HOME/.local/share/ashe
ln -s $HOME/.local/share/ashe/play.fish $HOME/.config/fish/conf.d/play.fish
fish -l
