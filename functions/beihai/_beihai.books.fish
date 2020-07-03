function _beihai.books -a name -d "Show Beihai books"
  set -l items
  for path in $bh_book_path
    for file in (string split ' ' (echo $path/*.yml))
      set -l item (string match -r '([^\/]+)\.yml$' $file)[2]
      if not test -z "$name"; and test "$item" = "$name"
        echo $file
        return 0
      end

      set items $items $item
    end
  end

  if test -z "$name"
    echo $items
  end
end