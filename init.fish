function ___show-book -a path
  for name in (string split ' ' (string replace -a '.yml' '' (echo $path/*.yml)))
    echo (string split '/' $name)[-1]
  end
end

function play-plane -a book inventory subject
  set -l __DIR $HOME/.local/share/ashe/plane
  if not test -d $__DIR
    echo ashe is removed.
  end

  if test -z "$inventory"; or test -z "$subject"; or test -z "$book"
    echo Usage: ./play \<book\> \<inventory\> \<subject\>[ \<...extra\>]
    echo - Books:
    ___show-book $__DIR
    return $OMF_UNKNOWN_OPT
  end

  ansible-playbook -i $inventory -l $subject $book $argv[4..-1]
end

complete -c play-plane -a "(___show-book $HOME/.local/share/ashe/plane)"

function play-escort -a book inventory subject
  set -l __DIR $HOME/.local/share/ashe/escort
  if not test -d $__DIR
    echo ashe is removed.
  end

  if test -z "$inventory"; or test -z "$subject"; or test -z "$book"
    echo Usage: ./play \<book\> \<inventory\> \<subject\>[ \<...extra\>]
    echo - Books:
    ___show-book $__DIR
    return $OMF_UNKNOWN_OPT
  end

  ansible-playbook -i $inventory -l $subject $book $argv[4..-1]
end

complete -c play-escort -a "(___show-book $HOME/.local/share/ashe/escort)"

function play-node -a book inventory subject
  set -l __DIR $HOME/.local/share/ashe/node
  if not test -d $__DIR
    echo ashe is removed.
  end

  if test -z "$inventory"; or test -z "$subject"; or test -z "$book"
    echo Usage: ./play \<book\> \<inventory\> \<subject\>[ \<...extra\>]
    echo - Books:
    ___show-book $__DIR
    return $OMF_UNKNOWN_OPT
  end

  ansible-playbook -i $inventory -l $subject $book $argv[4..-1]
end

complete -c play-node -a "(___show-book $HOME/.local/share/ashe/node)"
