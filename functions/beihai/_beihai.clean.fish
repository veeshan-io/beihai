function _beihai.clean -d "Clean Beihai directory"
  koi renew-repos $bh_root
  for path in $ops_repos_path
    if test -z "$path"
      koi renew-repos $path
    end
  end
end