function ___show-book -a path
  for name in (string split ' ' (string replace -a '.yml' '' (echo $path/*.yml)))
    echo (string split '/' $name)[-1]
  end
end

function play-book -d "play ashe book" -a kind book inventory subject

  echo $argv

  if not test -d $HOME/.local/share/ashe
    echo ashe is removed.
  end

  if test -z "$kind";
    echo Usage: ./play-$kind \<book\> \<inventory\> \<subject\>[ \<...extra\>]
    return $OMF_UNKNOWN_OPT
  end

  set -l __DIR $HOME/.local/share/ashe/$kind
  if not test -d $__DIR
    echo The kind [ $kine ] is not exists.
    return $OMF_UNKNOWN_OPT
  end
  if test -z "$inventory"; or test -z "$subject"; or test -z "$book"
    echo Usage: ./play-$kind \<book\> \<inventory\> \<subject\>[ \<...extra\>]
    echo - Books:
    ___show-book $__DIR
    return $OMF_UNKNOWN_OPT
  end

  set book $__DIR/$book.yml
  if not test -f $book
    echo The book [ $book ] is not exists.
    return $OMF_UNKNOWN_OPT
  end

  ansible-playbook -i $inventory -l $subject $book $argv[5..-1]
end

alias play-common "play-book common $argv"
alias play-plane "play-book plane $argv"
alias play-node "play-book node $argv"
alias play-escort "play-book escort $argv"

# complete -c play-book -f -a "common plane node escort"
complete -c 'play-common' -a "(___show-book $HOME/.local/share/ashe/common)"
complete -c 'play-plane' -a "(___show-book $HOME/.local/share/ashe/plane)"
complete -c 'play-node' -a "(___show-book $HOME/.local/share/ashe/node)"
complete -c 'play-escort' -a "(___show-book $HOME/.local/share/ashe/escort)"


function ashe-update
  set -l DIR $HOME/.local/share/ashe
  git -C $DIR add \*
  git -C $DIR stash
  git -C $DIR pull --rebase
  git -C $DIR stash drop
  # git -C $DIR stash pop
end
# ansible-playbook -i inv-main/inventories/plane/hosts.inv --list-hosts --limit=plane .local/share/ashe/plane/ping.yml
