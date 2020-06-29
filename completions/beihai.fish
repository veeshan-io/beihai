# Always provide completions for command line utilities.
#
# Check Fish documentation about completions:
# http://fishshell.com/docs/current/commands.html#complete
#
# If your package doesn't provide any command line utility,
# feel free to remove completions directory from the project.

# complete -c play -a "(___show-book $HOME/.local/share/ashe)"

complete -c beihai -x -d "Command" -a (_beihai.command) -n "__fish_use_subcommand"

# complete -c play -e
# complete -c play -n "__koi_no_subcommand_from (_beihai.invs)" -x -d "Inventory" -a (_beihai.invs)
# complete -c play -n "__fish_seen_subcommand_from (_beihai.invs)" -x -d "Book" -a (_beihai.books)

# for inventory in (_beihai.invs)
#   complete -c play -c $inventory -x -d "Book" -a (_beihai.books)
# end
