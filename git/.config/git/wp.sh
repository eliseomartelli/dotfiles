#!/bin/sh
# Print the path of a worktree chosen with fzf. Used by the `git wp` alias;
# the fish `git` wrapper (functions/git.fish) cds into the printed path.
command -v fzf >/dev/null || { echo "git wp: fzf not found" >&2; exit 127; }
git rev-parse --git-dir >/dev/null 2>&1 || { echo "git wp: not inside a git repository" >&2; exit 128; }

rows=$(git worktree list --porcelain | awk -v RS= -F'\n' '
  { p = substr($1, 10); l = "(unknown)"
    for (i = 2; i <= NF; i++) {
      if ($i ~ /^branch /) { l = $i; sub(/^branch refs\/heads\//, "", l) }
      else if ($i == "detached") l = "(detached)"
      else if ($i == "bare") l = "(bare)"
    }
    if (l != "(bare)") printf "%s\t%s\n", l, p }')
[ -n "$rows" ] || { echo "git wp: no worktrees found" >&2; exit 1; }

printf '%s\n' "$rows" | fzf --delimiter='\t' --with-nth=1,2 --tabstop=30 \
  --prompt='worktree> ' --height=40% --reverse --select-1 \
  --header="current: $(git rev-parse --show-toplevel)" --query="$*" \
  --preview='git -C {2} -c color.status=always status -sb' --preview-window=down,5 \
  | cut -f2
