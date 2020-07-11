# beihai initialization hook
#
# You can use the following variables in this file:
# * $package       package name
# * $path          package path
# * $dependencies  package dependencies

# Set vars
set -xg bh_root (dirname (status -f))
set -xg ops_repos_path $bh_root $ops_repos_path
set -xg bh_book_path $bh_root/books
set -xg bh_inv_path $bh_root/books/inventories

# Autoload
autoload $path/functions/beihai
