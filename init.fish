function ___show-book -a path
  for name in (string split ' ' (string replace -a '.yml' '' (echo $path/*.yml)))
    echo (string split '/' $name)[-1]
  end
end

function ___play-book -a book inventory subject
  if not test -f $book
    echo The book [ $book ] is not exists.
    return $OMF_UNKNOWN_OPT
  end

  ansible-playbook -i $inventory -l $subject $book $argv[4..-1]
end

function ashe-update
  set -l DIR $HOME/.local/share/ashe
  git -C $DIR add \*
  git -C $DIR stash
  git -C $DIR pull --rebase
  git -C $DIR stash drop
  # git -C $DIR stash pop
end
# ansible-playbook -i inv-main/inventories/plane/hosts.inv --list-hosts --limit=plane .local/share/ashe/plane/ping.yml
function play-plane -a book inventory subject
  set -l __DIR $HOME/.local/share/ashe/plane
  if not test -d $__DIR
    echo ashe is removed.
  end

  if test -z "$inventory"; or test -z "$subject"; or test -z "$book"
    echo Usage: ./play-plane \<book\> \<inventory\> \<subject\>[ \<...extra\>]
    echo - Books:
    ___show-book $__DIR
    return $OMF_UNKNOWN_OPT
  end

  set book $__DIR/$book.yml
  ___play-book $book $inventory $subject $argv[4..-1]
end

complete -c play-plane -a "(___show-book $HOME/.local/share/ashe/plane)"

function play-escort -a book inventory subject
  set -l __DIR $HOME/.local/share/ashe/escort
  if not test -d $__DIR
    echo ashe is removed.
  end

  if test -z "$inventory"; or test -z "$subject"; or test -z "$book"
    echo Usage: ./play-escort \<book\> \<inventory\> \<subject\>[ \<...extra\>]
    echo - Books:
    ___show-book $__DIR
    return $OMF_UNKNOWN_OPT
  end

  set book $__DIR/$book.yml
  ___play-book $book $inventory $subject $argv[4..-1]
end

complete -c play-escort -a "(___show-book $HOME/.local/share/ashe/escort)"

function play-node -a book inventory subject
  set -l __DIR $HOME/.local/share/ashe/node
  if not test -d $__DIR
    echo ashe is removed.
  end

  if test -z "$inventory"; or test -z "$subject"; or test -z "$book"
    echo Usage: ./play-node \<book\> \<inventory\> \<subject\>[ \<...extra\>]
    echo - Books:
    ___show-book $__DIR
    return $OMF_UNKNOWN_OPT
  end

  set book $__DIR/$book.yml
  ___play-book $book $inventory $subject $argv[4..-1]
end

complete -c play-node -a "(___show-book $HOME/.local/share/ashe/node)"
