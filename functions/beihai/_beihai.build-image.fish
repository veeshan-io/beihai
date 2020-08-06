function _beihai.build-image -d "Build containerd image with docker" -a major minor tag
  if test -z "$major"; or test -z "$minor"; or test -z "$tag"
    echo Usage: beihai build-image \<major\> \<minor\> \<tag\>
    return $OMF_UNKNOWN_OPT
  end

  for path in $image_dockerfiles
    if test -f $path/$major/$minor/Dockerfile
      docker build -t $tag $path/$major/$minor
      break
    end
  end
end