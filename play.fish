function ___show-book -a path
  echo - Books:
  for name in string split ' ' (string replace '.yml' '' (echo $path/*.yml))
    echo $name
  end
end

function play-plane -a book inventory subject
  set -l __DIR $HOME/.local/share/ashe/plane
  if not test -d $__DIR
    echo ashe is removed.
  end

  if test -z "$inventory"; or test -z "$subject"; or test -z "$book"
    echo Usage: ./play \<book\> \<inventory\> \<subject\>[ \<...extra\>]
    ___show-book $__DIR
    return $OMF_UNKNOWN_OPT
  end

  ansible-playbook -i $inventory -l $subject $book $argv[4..-1]
end

function play-escort -a book inventory subject
  set -l __DIR $HOME/.local/share/ashe/escort
  if not test -d $__DIR
    echo ashe is removed.
  end

  if test -z "$inventory"; or test -z "$subject"; or test -z "$book"
    echo Usage: ./play \<book\> \<inventory\> \<subject\>[ \<...extra\>]
    ___show-book $__DIR
    return $OMF_UNKNOWN_OPT
  end

  ansible-playbook -i $inventory -l $subject $book $argv[4..-1]
end

function play-node -a book inventory subject
  set -l __DIR $HOME/.local/share/ashe/node
  if not test -d $__DIR
    echo ashe is removed.
  end

  if test -z "$inventory"; or test -z "$subject"; or test -z "$book"
    echo Usage: ./play \<book\> \<inventory\> \<subject\>[ \<...extra\>]
    ___show-book $__DIR
    return $OMF_UNKNOWN_OPT
  end

  ansible-playbook -i $inventory -l $subject $book $argv[4..-1]
end
