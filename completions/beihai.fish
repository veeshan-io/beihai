# Always provide completions for command line utilities.
#
# Check Fish documentation about completions:
# http://fishshell.com/docs/current/commands.html#complete
#
# If your package doesn't provide any command line utility,
# feel free to remove completions directory from the project.

# complete -c play -a "(___show-book $HOME/.local/share/ashe)"

complete -c beihai -x -a (_beihai.command) -n "__fish_use_subcommand"

# for book in (_beihai.books)
#   complete -c beihai -x -a $book -d
# end
