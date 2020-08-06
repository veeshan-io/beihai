# beihai initialization hook
#
# You can use the following variables in this file:
# * $package       package name
# * $path          package path
# * $dependencies  package dependencies

# Set vars
set -xg bh_root (dirname (status -f))
set -xg bh_book_path $bh_root/books
set -xg bh_inv_path $bh_root/books/inventories

# build-image 所用路径
# set -xg image_dockerfile_repos

# beihai renew 不再更新自己的库
# set -xg ops_repos_path $bh_root $ops_repos_path
# set -xg ops_repos_path

# Autoload
autoload $path/functions/beihai
