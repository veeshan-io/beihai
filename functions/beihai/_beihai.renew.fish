function _beihai.renew -d "Renew beihai & ops-repos"
  if test (count $argv) -gt 0; and test $argv[1] = '--self'
    koi renew-repos $bh_root
  end

  if test (count $ops_repos_path) = 1
    koi renew-repos $ops_repos_path
  else
    for path in $ops_repos_path
      if not test -z "$path"
        koi renew-repos $path
      end
    end
  end
end