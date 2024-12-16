function fish_prompt
    # Colors
    set_color normal
    set bold_cyan (set_color -o cyan)
    set bold_red (set_color -o red)

    # Current directory in bold cyan
    echo -n -s $bold_cyan (basename (pwd))

    # Git branch if in a Git repository
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set branch (git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD)
        echo -n -s " $bold_red($branch)"
    end

    # Prompt symbol: `$` for regular users, `#` for root
    set prompt_symbol '$'
    if test (id -u) -eq 0
        set prompt_symbol '#'
    end

    # Reset color and print prompt symbol
    set_color normal
    echo -n " $prompt_symbol "
end
