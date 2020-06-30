# Always provide completions for command line utilities.
#
# Check Fish documentation about completions:
# http://fishshell.com/docs/current/commands.html#complete
#
# If your package doesn't provide any command line utility,
# feel free to remove completions directory from the project.

complete -c beihai -x -d "Command" -a (_beihai.command) -n "__fish_use_subcommand"

set -l invs (_beihai.invs)
complete -c play -n "__koi_no_subcommand_from $invs" -x -d "Inventory" -a $invs
complete -c play -n "__fish_seen_subcommand_from $invs" -x -d "Book" -a (_beihai.books)
