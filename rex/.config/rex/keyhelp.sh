#!/bin/sh
# Show prefix bindings in a floating pane; q closes it.
# shortcut: falls back to the first session when REX_SESSION is unset, fix if you run several.
R=${REX:-"/Users/MARELO/Library/Application Support/com.superlogical.rex/RexServer/Versions/Current/Rex Server.app/Contents/MacOS/rex"}
S=${REX_SESSION:-$("$R" ls --json | grep -o 'session:[^"]*' | head -1)}
id=$("$R" run --split=right --json -- sh -c "'$R' keymap | grep -E '^(KEY|ctrl\+b )' | less -S" | grep -A1 '"block_ids"' | grep -o 'block:[^"]*')
[ -n "$id" ] && "$R" api call session.float_block "{\"session_id\":\"$S\",\"block_id\":\"$id\",\"bounds\":[0.15,0.1,0.7,0.8]}"
