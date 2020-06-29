function _beihai.invs -d "Show Beihai inventories"
  set -l items
  for path in $bh_inv_path
    for file in (string split ' ' (echo $path/*.inv))
      set items $items (string match -r '([^\/]+)\.inv$' $file)[2]
    end
  end

  echo $items
end