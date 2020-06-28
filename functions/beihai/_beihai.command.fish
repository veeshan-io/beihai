function _beihai.command -a name -d "Show Beihai command"
  set -l commands
  for func in (functions -a)
    set -l tmp (string match -r '^_beihai\.(.+)' $func)
    if test (count $tmp) -gt 0
      set commands $commands $tmp[2]
    end
  end

  if not test -z "$name"
    for command in $commands
      if test "$name" = "$command"
        echo $command
        break
      end
    end
  else
    echo $commands
  end
end
