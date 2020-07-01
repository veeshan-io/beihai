complete -c play -n "__koi_seen_--" -e
set -l invs (_beihai.invs)
complete -c play -n "__koi_no_subcommand_from $invs" -x -d "Inventory" -a $invs
complete -c play -n "__koi_seen_subcommand_from $invs" -x -d "Book" -a (_beihai.books)
