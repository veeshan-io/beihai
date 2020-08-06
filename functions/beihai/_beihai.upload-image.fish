function _beihai.upload-image -d "Upload your image" -a major minor
  if test -z "$inventory"; or test -z "$books"
    echo Usage: play \<inventory\> \<...books\> [-- \<...extra\>]
    return $OMF_UNKNOWN_OPT
  end
end