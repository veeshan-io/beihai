set -l OMF_SETUP_DIR (dirname (status -f))
if not test -f $OMF_SETUP_DIR/omf.fish
  curl -sfL https://gitee.com/andares/installers/raw/master/fish/install-omf | fish
  omf install https://github.com/veeshan-io/koi
end
