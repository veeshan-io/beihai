function _beihai.invs -a name -d "Show Beihai inventories"
  set -l items
  for path in $bh_inv_path
    for file in (string split ' ' (echo $path/*.inv))
      set -l item (string match -r '([^\/]+)\.inv$' $file)[2]
      if test -z "$name"; and test "$item" = "$name"
        echo $file
        return 0
      end

      set items $items $item
    end
  end

  echo $items
end