function ___show-book -a path
  for name in (string split ' ' (string replace -a '.yml' '' (echo $path/*.yml)))
    echo (string split '/' $name)[-1]
  end
end

function play-book -d "play ashe book" -a book inventory subject
  if not test -d $HOME/.local/share/ashe
    echo ashe is removed.
  end

  set -l __DIR $HOME/.local/share/ashe

  if test -z "$inventory"; or test -z "$subject"; or test -z "$book"
    echo Usage: ./play-book \<book\> \<inventory\> \<subject\>[ \<...extra\>]
    echo - Books:
    ___show-book $__DIR
    return $OMF_UNKNOWN_OPT
  end

  set book $__DIR/$book.yml
  if not test -f $book
    echo The book [ $book ] is not exists.
    return $OMF_UNKNOWN_OPT
  end

  ansible-playbook -i $inventory -l $subject $book $argv[4..-1]
end

complete -c play-book -a "(___show-book $HOME/.local/share/ashe)"

function ashe-update
  set -l DIR $HOME/.local/share/ashe
  git -C $DIR add \*
  git -C $DIR stash
  git -C $DIR pull --rebase
  git -C $DIR stash drop
  # git -C $DIR stash pop
end
