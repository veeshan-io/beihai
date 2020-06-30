function play -d "Play Beihai book"
  echo $argv
  echo $argv[1]

  # set -l inventory $argv[1]
  # set -l book $argv[2]

  # if test -z "$inventory"; or test -z "$book"
  #   echo Usage: ./play-book \<book\> \<inventory\>[ \<...extra\>]
  #   echo - Books:
  #   ___show-book $__DIR
  #   return $OMF_UNKNOWN_OPT
  # end

  # set book $__DIR/$book.yml
  # if not test -f $book
  #   echo The book [ $book ] is not exists.
  #   return $OMF_UNKNOWN_OPT
  # end

  # ansible-playbook -i $inventory $book $argv[4..-1]
end
