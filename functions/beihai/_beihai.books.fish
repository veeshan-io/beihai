function _beihai.books -d "Show Beihai books"
  set -l items
  for path in $bh_book_path
    for file in (string split ' ' (echo $path/*.yml))
      set items $items (string match -r '([^\/]+)\.yml$' $file)[2]
    end
  end

  echo $items
end