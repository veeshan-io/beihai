function play -d "Play Beihai book"

  set -l inventory $argv[1]

  set -l books
  set -l extra
  set -l is_extra 0
  for param in $argv[2..-1]
    if test "$param" = "--"
      set is_extra 1
      continue
    end

    if test $is_extra -eq 1
      set extra $extra $param
    else
      set books $books $param
    end
  end

  if test -z "$inventory"; or test -z "$books"
    echo Usage: play \<inventory\> \<...books\> [-- \<...extra\>]
    return $OMF_UNKNOWN_OPT
  end

  for book in $books
    koi debug "RUN: ansible-playbook -i "(beihai invs $inventory)" "(beihai books $book)" $extra"
    ansible-playbook -i (beihai invs $inventory) (beihai books $book) $extra
  end
end
