# venus initialization hook
#
# You can use the following variables in this file:
# * $package       package name
# * $path          package path
# * $dependencies  package dependencies

# Set vars
set -xg venus_root (dirname (status -f))
set -xg bh_book_path (dirname (status -f))/books $bh_book_path
set -xg bh_inv_path (dirname (status -f))/inventories $bh_inv_path
