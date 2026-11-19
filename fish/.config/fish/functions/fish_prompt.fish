function fish_prompt
    set -l __last_command_exit_status $status

    if not set -q -g __fish_arrow_functions_defined
        set -g __fish_arrow_functions_defined
        function _git_branch_name
            set -l branch (git symbolic-ref --quiet HEAD 2>/dev/null)
            if set -q branch[1]
                echo (string replace -r '^refs/heads/' '' $branch)
            else
                echo (git rev-parse --short HEAD 2>/dev/null)
            end
        end

        function _is_git_dirty
            not command git diff-index --cached --quiet HEAD -- &>/dev/null
            or not command git diff --no-ext-diff --quiet --exit-code &>/dev/null
        end

        function _is_git_repo
            type -q git
            or return 1
            git rev-parse --git-dir >/dev/null 2>&1
        end

        function _hg_branch_name
            echo (hg branch 2>/dev/null)
        end

        function _is_hg_dirty
            set -l stat (hg status -mard 2>/dev/null)
            test -n "$stat"
        end

        function _is_hg_repo
            fish_print_hg_root >/dev/null
        end

        function _repo_branch_name
            _$argv[1]_branch_name
        end

        function _is_repo_dirty
            _is_$argv[1]_dirty
        end

        function _jj_branch_name
            # Uses modern template syntax to fetch the first bookmark name, falling back to a short change ID
            set -l log_output (jj log --ignore-working-copy --no-graph --no-color -r '@' -T 'try(bookmarks.first().name(), change_id.short())' 2>/dev/null)
            if test -n "$log_output"
                echo "$log_output"
            else
                echo "jj"
            end
        end

        function _is_jj_dirty
            # In jj, the working copy itself is a commit. We check if there are any changes 
            # relative to its parent, or if the working copy is empty/modified.
            not jj diff --ignore-working-copy --quiet 2>/dev/null
            # Alternatively, if you want to catch uncommitted working copy changes:
            set -l stat (jj st --no-pager 2>/dev/null)
            test -n "$stat"
        end

        function _is_jj_repo
            type -q jj
            or return 1
            jj root --quiet >/dev/null 2>&1
        end

        function _repo_type
            if _is_hg_repo
                echo hg
                return 0
            else if _is_jj_repo
                echo jj
                return 0
            else if _is_git_repo
                echo git
                return 0
            end
            return 1
        end
    end

    set -l cyan (set_color -o cyan)
    set -l yellow (set_color -o yellow)
    set -l red (set_color -o red)
    set -l green (set_color -o green)
    set -l blue (set_color -o blue)
    set -l normal (set_color normal)

    set -l arrow_color "$green"
    if test $__last_command_exit_status != 0
        set arrow_color "$red"
    end

    set -l arrow "$arrow_color➜ "
    if fish_is_root_user
        set arrow "$arrow_color# "
    end

    set -l cwd $cyan(basename (prompt_pwd))

    set -l repo_info
    if set -l repo_type (_repo_type)
        set -l repo_branch $red(_repo_branch_name $repo_type)
        set repo_info "$blue $repo_type:($repo_branch$blue)"

        if _is_repo_dirty $repo_type
            set -l dirty "$yellow ✗"
            set repo_info "$repo_info$dirty"
        end
    end

    echo -n -s $arrow ' '$cwd $repo_info $normal ' '
end
