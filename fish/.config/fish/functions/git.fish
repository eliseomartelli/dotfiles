# `git wp` prints a worktree path (see git/.config/git/wp.sh); cd into it.
# Everything else is passed straight through to git.
function git --wraps git --description 'git, where `git wp` also changes directory'
    if test "$argv[1]" = wp
        set -l dir (command git $argv)
        or return
        if test -n "$dir" -a -d "$dir"
            cd $dir
        end
    else
        command git $argv
    end
end
