function _beihai.clean -d "Clean Beihai directory"
  for path in $ops_repos_path
    if test -z "$path"
      koi renew-repos $path
    end
  end
end