rex.bind("ctrl+b>ctrl+b", "pane.send_key", { key = "ctrl+b" })
rex.bind("ctrl+b>shift+s", "session.new")
rex.bind("ctrl+b>c", "client.tab.new")
rex.bind("ctrl+b>r", "client.config.reload")

-- tmux pane navigation (prefix ctrl+b)
rex.bind("ctrl+b>h", "pane.focus.left")
rex.bind("ctrl+b>j", "pane.focus.down")
rex.bind("ctrl+b>k", "pane.focus.up")
rex.bind("ctrl+b>l", "pane.focus.right")
rex.bind("ctrl+b>ctrl+h", "pane.focus.left")
rex.bind("ctrl+b>ctrl+j", "pane.focus.down")
rex.bind("ctrl+b>ctrl+k", "pane.focus.up")
rex.bind("ctrl+b>ctrl+l", "pane.focus.right")
rex.bind("ctrl+b>left", "pane.focus.left")
rex.bind("ctrl+b>down", "pane.focus.down")
rex.bind("ctrl+b>up", "pane.focus.up")
rex.bind("ctrl+b>right", "pane.focus.right")
rex.bind("ctrl+b>o", "pane.focus_next")
rex.bind("ctrl+b>;", "pane.focus_previous")

-- tmux splits: % = side by side, " and - = stacked (US layout)
rex.bind("ctrl+b>shift+'", "pane.split", { direction = "down" })

-- tmux tabs ("windows" in tmux). base-index is 1 in your tmux, so 1-9 match.
rex.bind("ctrl+b>n", "client.tab.next")
rex.bind("ctrl+b>p", "client.tab.previous")
rex.bind("ctrl+b>ctrl+n", "client.tab.next")
rex.bind("ctrl+b>ctrl+p", "client.tab.previous")
rex.bind("ctrl+b>,", "client.tab.rename")
rex.bind("ctrl+b>shift+7", "client.tab.close") -- &
rex.bind("ctrl+b>shift+,", "client.tab.move.backward") -- <
rex.bind("ctrl+b>shift+.", "client.tab.move.forward") -- >
for i = 1, 9 do
	rex.bind("ctrl+b>" .. i, "client.tab.goto", { index = i })
end

-- tmux sessions
rex.bind("ctrl+b>s", "session.switch")
rex.bind("ctrl+b>shift+9", "session.previous") -- (
rex.bind("ctrl+b>shift+0", "session.next") -- )
rex.bind("ctrl+b>shift+4", "session.rename") -- $

-- tmux panes
rex.bind("ctrl+b>x", "pane.close")
rex.bind("ctrl+b>z", "pane.zoom")
rex.bind("ctrl+b>shift+1", "pane.move_to_new_tab") -- !
rex.bind("ctrl+b>space", "pane.balance")
rex.bind("ctrl+b>shift+\\", "pane.split", { direction = "right" }) -- |
rex.bind("ctrl+b>]", "pane.paste")
rex.bind("ctrl+b>w", "pane.go_to")
rex.bind("ctrl+b>f", "pane.float")
rex.bind("ctrl+b>u", "session.undo_close")

-- tmux resize: ctrl+b then H/J/K/L resizes once and stays in resize mode,
-- so H/J/K/L (or h/j/k/l) keep resizing until Escape or Enter.
-- Each step restarts a 0.6s timer; when it fires with no new step, resize mode exits.
local resize_timer
rex.action({
	name = "resize_exit",
	title = "Exit Resize Mode",
	run = function(ctx, args)
		rex.client.queue("client.mode.exit")
	end,
})
rex.action({
	name = "resize_step",
	title = "Resize Pane (repeatable)",
	args = { direction = "string" },
	run = function(ctx, args)
		rex.client.queue("pane.resize", { direction = args.direction })
		rex.client.queue("client.mode.enter", { name = "resize" })
		if resize_timer then
			resize_timer:kill()
		end
		resize_timer = rex.exec.start({
			"sh",
			"-c",
			'sleep 0.3 && exec "$0" do resize_exit',
			"~/Library/Application Support/com.superlogical.rex/RexServer/Versions/Current/Rex Server.app/Contents/MacOS/rex",
		}, { detach = true })
	end,
})
rex.mode("resize", { exclusive = true })
for key, dir in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
	rex.bind("ctrl+b>shift+" .. key, "resize_step", { direction = dir })
	rex.bind("resize/" .. key, "resize_step", { direction = dir })
	rex.bind("resize/shift+" .. key, "resize_step", { direction = dir })
end
rex.bind("ctrl+b>alt+left", "pane.resize", { direction = "left" })
rex.bind("ctrl+b>alt+down", "pane.resize", { direction = "down" })
rex.bind("ctrl+b>alt+up", "pane.resize", { direction = "up" })
rex.bind("ctrl+b>alt+right", "pane.resize", { direction = "right" })

-- tmux misc
rex.bind("ctrl+b>shift+;", "client.palette.toggle") -- :
rex.action({
	name = "keyhelp",
	title = "Show Prefix Keys",
	run = function(ctx)
		rex.exec.start({ "sh", os.getenv("HOME") .. "/.config/rex/keyhelp.sh", ctx.session_id }, { detach = true })
	end,
})
rex.bind("ctrl+b>shift+/", "keyhelp") -- ?

-- floating pane (like tmux popup)
rex.bind("ctrl+b>enter", "pane.new_floating")

-- Worktree picker for `git wp` (git/.config/git/wp.sh). `rows` is "label<TAB>path"
-- lines; the chosen path is the action's result, printed by `rex do`.
rex.action({
	name = "git_wp",
	title = "Git: Worktree…",
	args = { rows = "string", query = "string?" },
	run = function(ctx, args)
		if not rex.ui then
			error("rex.ui is not available; this needs a Rex server with API revision 17 or newer")
		end
		local items = {}
		for line in args.rows:gmatch("[^\n]+") do
			local label, path = line:match("^(.-)\t(.*)$")
			if path then
				items[#items + 1] = { id = path, title = label, subtitle = path, icon = "branch" }
			end
		end
		local path, why = rex.ui.pick({
			title = "Worktree",
			placeholder = "Filter worktrees",
			value = args.query or "",
			items = items,
		})
		if path ~= nil then
			return path
		end
		-- Cancelled or timed out: an empty result means "stay put". Any other
		-- reason (no_client, unsupported, busy, failed) is an error so the caller
		-- can fall back to fzf.
		if why == "cancelled" or why == "timeout" then
			return ""
		end
		error("rex.ui.pick: " .. tostring(why))
	end,
})
