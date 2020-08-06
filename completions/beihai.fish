# Always provide completions for command line utilities.
#
# Check Fish documentation about completions:
# http://fishshell.com/docs/current/commands.html#complete
#
# If your package doesn't provide any command line utility,
# feel free to remove completions directory from the project.
complete -c beihai -x -d "Command" -a (_beihai.command) -n "__koi_no_subcommand_from 'build-image'"

# build-image
set -l majors
set -l minors
set -l major
for repos in $image_dockerfile_repos
  for path in (echo $repos/*)
    if not test -d $path
      continue
    end

    set major (string match -r '([^\/]+)$' $path)[2]
    set majors $majors $major
    set minors
    for subpaths in (echo $path/*)
      for subpath in $subpaths
        if not test -d $subpath
          continue
        end
        set minors $minors (string match -r '([^\/]+)$' $subpath)[2]
      end
    end
    if test (count $minors) -gt 0
      complete -c beihai -n "__koi_subcommand_flow 'build-image' $major" -x -d "Minor" -a $minors
    end
  end
end

if test (count $majors) -gt 0
  complete -c beihai -n "__koi_subcommand_flow 'build-image'" -x -d "Major" -a $majors
end
