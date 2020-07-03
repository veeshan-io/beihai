function _beihai.clean -d "Clean Beihai directory"
  if test (count $ops_repos_path) = 1
    koi renew-repos $ops_repos_path
  else
    for path in $ops_repos_path
      if test -z "$path"
        koi renew-repos $path
      end
    end
  end
end