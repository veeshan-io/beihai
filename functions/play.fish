function play -d "Play Beihai book"
  set -l inventory $argv[1]
  set -l books $argv[2..-1]
  echo $inventory
  echo $books

  if test -z "$inventory"; or test -z "$books"
    echo Usage: play \<inventory\>[ \<...extra\>]
    echo - Books:
    ___show-book $__DIR
    return $OMF_UNKNOWN_OPT
  end

  # set book $__DIR/$book.yml
  # if not test -f $book
  #   echo The book [ $book ] is not exists.
  #   return $OMF_UNKNOWN_OPT
  # end

  # ansible-playbook -i $inventory $book $argv[4..-1]
end
