# beihai initialization hook
#
# You can use the following variables in this file:
# * $package       package name
# * $path          package path
# * $dependencies  package dependencies

# Set vas
set -xg bh_root (dirname (status -f))
set -xg bh_book_path $bh_root/books
set -xg bh_inv_path $bh_root/books/inventories

# Autoload
autoload $path/functions/beihai

# function ___show-book -a path
#   for name in (string split ' ' (string replace -a '.yml' '' (echo $path/*.yml)))
#     echo (string split '/' $name)[-1]
#   end
# end

# function play-book -d "play beihai book" -a book inventory
#   if not test -d $HOME/.local/share/beihai
#     echo beihai is removed.
#   end

#   set -l __DIR $HOME/.local/share/beihai

#   if test -z "$inventory"; or test -z "$book"
#     echo Usage: ./play-book \<book\> \<inventory\>[ \<...extra\>]
#     echo - Books:
#     ___show-book $__DIR
#     return $OMF_UNKNOWN_OPT
#   end

#   set book $__DIR/$book.yml
#   if not test -f $book
#     echo The book [ $book ] is not exists.
#     return $OMF_UNKNOWN_OPT
#   end

#   ansible-playbook -i $inventory $book $argv[4..-1]
# end

# complete -c play-book -a "(___show-book $HOME/.local/share/beihai)"

# function beihai-update
#   set -l DIR $HOME/.local/share/beihai
#   git -C $DIR add \*
#   git -C $DIR stash
#   git -C $DIR pull --rebase
#   git -C $DIR stash drop
#   # git -C $DIR stash pop
# end
