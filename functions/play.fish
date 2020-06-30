function play -d "Play Beihai book"
  if not test -d $HOME/.local/share/beihai
    echo beihai is removed.
  end

  set -l __DIR $HOME/.local/share/beihai

  if test -z "$inventory"; or test -z "$book"
    echo Usage: ./play-book \<book\> \<inventory\>[ \<...extra\>]
    echo - Books:
    ___show-book $__DIR
    return $OMF_UNKNOWN_OPT
  end

  set book $__DIR/$book.yml
  if not test -f $book
    echo The book [ $book ] is not exists.
    return $OMF_UNKNOWN_OPT
  end

  ansible-playbook -i $inventory $book $argv[4..-1]
end
