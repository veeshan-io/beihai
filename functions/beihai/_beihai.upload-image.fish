function _beihai.upload-image -d "Upload your image" -a from_tag repos to_tag
  if test -z "$from_tag"; or test -z "$repos"; or test -z "$to_tag"
    echo Usage: beihai upload-image \<from_tag\> \<repos\> \<to_tag\>
    return $OMF_UNKNOWN_OPT
  end

  docker tag $from_tag $repos/$to_tag
  docker push $repos/$to_tag
end