#!/bin/sh
# Print the path of a worktree chosen interactively. Used by the `git wp` alias;
# the fish `git` wrapper (functions/git.fish) cds into the printed path.
# Inside a Rex session it uses Rex's picker (the git_wp action in
# ~/.config/rex/init.lua); otherwise, or if Rex can't show it, it falls back to fzf.
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

if [ -n "$REX_SESSION" ] && command -v rex >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
  if out=$(printf '%s' "$rows" | jq -Rs --arg q "$*" '{rows: ., query: $q}' \
    | rex do git_wp --args - --json --timeout 10m 2>/dev/null); then
    printf '%s\n' "$out" | jq -r 'select(. != null and . != "")'
    exit 0
  fi
fi

command -v fzf >/dev/null || { echo "git wp: fzf not found" >&2; exit 127; }
printf '%s\n' "$rows" | fzf --delimiter='\t' --with-nth=1,2 --tabstop=30 \
  --prompt='worktree> ' --height=40% --reverse --select-1 \
  --header="current: $(git rev-parse --show-toplevel)" --query="$*" \
  --preview='git -C {2} -c color.status=always status -sb' --preview-window=down,5 \
  | cut -f2
