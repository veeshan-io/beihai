# Always provide completions for command line utilities.
#
# Check Fish documentation about completions:
# http://fishshell.com/docs/current/commands.html#complete
#
# If your package doesn't provide any command line utility,
# feel free to remove completions directory from the project.
complete -c beihai -x -d "Command" -a (_beihai.command) -n "__koi_no_subcommand_from build-image upload-image"

# build-image
set -l majors
set -l minors
set -l major
set -l minor
for repos in $image_dockerfile_repos
  for path in (string split ' ' (echo $repos/*))
    if not test -d $path
      continue
    end

    set major (string match -r '([^\/]+)$' $path)[2]
    # 跳过 _ 开头目录
    if not test -z (string match -r '^_.*$' $major)
      continue
    end

    set majors $majors $major
    set minors
    for subpath in (string split ' ' (echo $path/*))
      if not test -d $subpath
        continue
      end

      set minor (string match -r '([^\/]+)$' $subpath)[2]
      # 跳过 _ 开头目录
      if not test -z (string match -r '^_.*$' $minor)
        continue
      end

      set minors $minors $minor
    end
    if test (count $minors) -gt 0
      # complete -c beihai -c build-image -c $major -x -d "Minor" -a "$minors"
      complete -c beihai -n "__koi_subcommand_flow build-image $major" -x -d "Minor" -a "$minors"
    end
  end
end

if test (count $majors) -gt 0
  # complete -c beihai -c build-image -x -d "Major" -a "$majors"
  complete -c beihai -n "__koi_subcommand_flow build-image" -x -d "Major" -a "$majors"
end

# upload-image
set -l from_tags
for line in (docker images)[2..-1]
  set from_tags (echo $line | awk '{ print $1 ":" $2 }') $from_tags
end
complete -c beihai -n "__koi_subcommand_flow upload-image" -x -d "From Tag" -a "$from_tags"

complete -c beihai -n "__koi_subcommand_flow upload-image %" -x -d "Image Repos" -a "$image_repos_list"
