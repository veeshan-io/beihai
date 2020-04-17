function play-book -a book inventory subject
  set -l __DIR $HOME/.local/share/ashe
  if not test -d $__DIR
    echo ashe is removed.
  end

  if test -z "$inventory"; or test -z "$subject"; or test -z "$book"
    echo Usage: ./play \<book\> \<inventory\> \<subject\>[ \<extra\>]
    echo (string replace '.yml' '' (echo $__DIR/*.yml))
    return $OMF_UNKNOWN_OPT
  end

  ansible-playbook -i $inventory -l $subject $book $argv[4..-1]
end
