# Function: `ta` for attaching to a tmux session
function ta
    if test -n "$argv[1]"
        tmux attach-session -t $argv[1]
    else
        echo "Please specify session to attach."
    end
end

# Autocomplete for `ta` (list tmux sessions)
function _ta
    tmux list-sessions | cut -d: -f1
end

# Function: `tm` for creating a new tmux session
function tm
    if test -n "$argv[1]"
        tmux new-session -s $argv[1]
    else
        echo "Please specify session name."
    end
end

# Function: `t` to either create or attach to a tmux session based on directory
function t
    if test -n "$argv[1]"
        set name "$argv[1]"
    else
        set name (pwd | awk -F / -v OFS=/ '{ print $(NF-1), $NF }')
    end
    tm "$name" > /dev/null 2>&1 || ta "$name"
end

complete -c ta -f -a "(_ta)"
complete -c t -f -a "(_ta)"
