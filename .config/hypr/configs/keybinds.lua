local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "dolphin"
local browser = "zen-twilight"
local editor = "kitty tmux new-session -s '|NVIM|pid_$$' 'nvim; exec zsh'"

local smw = require("plugins.split-monitor-workspaces")

local function layout_bind(bind_table)
	return function()
		local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()

		if not workspace then
			return
		end

		local layout = workspace.tiled_layout

		if bind_table[layout] then
			hl.dispatch(bind_table[layout])
		end
	end
end

hl.bind(mainMod .. " + tab", function()
	local layouts = { "dwindle", "scrolling" }
	local workspace = hl.get_active_workspace()
	local next_layout = "scrolling"

	if not workspace then
		return
	end

	for i = 1, #layouts do
		if layouts[i] == workspace.tiled_layout then
			local next_layout_idx = (i % #layouts) + 1
			next_layout = layouts[next_layout_idx]
			break
		end
	end

	local layout_icons = {
		dwindle = "window",
		scrolling = "view_carousel",
	}
	local icon = layout_icons[next_layout] or "info"
	local display_name = next_layout:sub(1, 1):upper() .. next_layout:sub(2)

	hl.dispatch(
		hl.dsp.exec_cmd(
			"caelestia shell toaster info 'Hyprland layout changed' 'Layout: " .. display_name .. "' '" .. icon .. "'"
		)
	)
	hl.workspace_rule({ workspace = workspace.name, layout = next_layout })
end)

hl.bind(mainMod .. " + CTRL + P", layout_bind({ dwindle = hl.dsp.window.pseudo() }))
hl.bind(mainMod .. " + CTRL + J", layout_bind({ dwindle = hl.dsp.layout("togglesplit") }))

-- Movement
hl.bind(
	mainMod .. " + h",
	layout_bind({ dwindle = hl.dsp.focus({ direction = "l" }), scrolling = hl.dsp.layout("move -col") })
)
hl.bind(
	mainMod .. " + l",
	layout_bind({ dwindle = hl.dsp.focus({ direction = "r" }), scrolling = hl.dsp.layout("move +col") })
)
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))

hl.bind(
	mainMod .. " + SHIFT + h",
	layout_bind({ dwindle = hl.dsp.window.move({ direction = "l" }), scrolling = hl.dsp.layout("swapcol l") })
)
hl.bind(
	mainMod .. " + SHIFT + l",
	layout_bind({ dwindle = hl.dsp.window.move({ direction = "r" }), scrolling = hl.dsp.layout("swapcol r") })
)
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "d" }))

-----------------------
----- MONITORS --------
-----------------------

-- Nearest monitor in a geometric direction (follows the layout in monitors.lua,
-- not monitor ids/order). Returns an HL.Monitor, which is a valid monitor selector.
local MONITOR_DIRS = {
	LEFT = { -1, 0 },
	RIGHT = { 1, 0 },
	UP = { 0, -1 },
	DOWN = { 0, 1 },
}

local function monitor_in_direction(key)
	local v = MONITOR_DIRS[key]
	local cur = hl.get_active_monitor()

	if not v or not cur then
		return nil
	end

	local best, best_dist = nil, nil

	for _, m in ipairs(hl.get_monitors()) do
		if m.name ~= cur.name then
			local dx = m.x + m.width / 2 - (cur.x + cur.width / 2)
			local dy = m.y + m.height / 2 - (cur.y + cur.height / 2)

			if dx * v[1] + dy * v[2] > 0 then
				local dist = dx * dx + dy * dy
				if not best_dist or dist < best_dist then
					best, best_dist = m, dist
				end
			end
		end
	end

	return best
end

for key in pairs(MONITOR_DIRS) do
	-- SUPER + arrow: focus the neighbouring monitor.
	hl.bind(mainMod .. " + " .. key, function()
		local m = monitor_in_direction(key)
		if m then
			hl.dispatch(hl.dsp.focus({ monitor = m }))
		end
	end)

	-- SUPER + SHIFT + arrow: move the window there and follow it.
	hl.bind(mainMod .. " + SHIFT + " .. key, function()
		local m = monitor_in_direction(key)
		if m then
			hl.dispatch(hl.dsp.window.move({ monitor = m }))
		end
	end)

	-- SUPER + CTRL + arrow: move the window there, stay put.
	hl.bind(mainMod .. " + CTRL + " .. key, function()
		local m = monitor_in_direction(key)
		if m then
			hl.dispatch(hl.dsp.window.move({ monitor = m, follow = false }))
		end
	end)
end

hl.bind(
	mainMod .. " + bracketright",
	layout_bind({
		dwindle = hl.dsp.window.resize({ x = 30, y = 0, relative = true }),
		scrolling = hl.dsp.layout("colresize +conf"),
	}),
	{ repeating = true }
)
hl.bind(
	mainMod .. " + bracketleft",
	layout_bind({
		dwindle = hl.dsp.window.resize({ x = -30, y = 0, relative = true }),
		scrolling = hl.dsp.layout("colresize -conf"),
	}),
	{ repeating = true }
)
hl.bind(mainMod .. " + W", layout_bind({ scrolling = hl.dsp.layout("fit active") }))

hl.bind(
	mainMod .. " + CTRL + R",
	layout_bind({ dwindle = hl.dsp.submap("resize"), scrolling = hl.dsp.submap("resize-scrolling") })
)

hl.define_submap("resize-scrolling", function()
	hl.bind("l", hl.dsp.layout("colresize +0.1"), { repeating = true })
	hl.bind("h", hl.dsp.layout("colresize -0.1"), { repeating = true })
	hl.bind("escape", hl.dsp.submap("reset")) -- Use `reset` to go back to the global submap
end)

hl.define_submap("resize", function()
	hl.bind("l", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
	hl.bind("h", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
	hl.bind("k", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
	hl.bind("j", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })
	hl.bind("escape", hl.dsp.submap("reset")) -- Use `reset` to go back to the global submap
end)

-- Launcher
hl.bind(mainMod .. " + R", hl.dsp.global("caelestia:launcher"), { submap_universal = true })

-- Window
hl.bind(mainMod .. " + Q", hl.dsp.window.close(), { submap_universal = true })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen(), { submap_universal = true })
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float(), { submap_universal = true })

-- Clipboard and emoji
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("caelestia clipboard"), { submap_universal = true })
hl.bind(mainMod .. " + ALT + V", hl.dsp.exec_cmd("caelestia clipboard -d"), { submap_universal = true })
hl.bind(mainMod .. " + PERIOD", hl.dsp.exec_cmd("caelestia emoji -p"), { submap_universal = true })

-- Apps
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("app2unit -- " .. fileManager), { submap_universal = true })
hl.bind(
	mainMod .. " + T",
	hl.dsp.exec_cmd(terminal .. " ~/.dotfiles/scripts/kitty-tmux.zsh"),
	{ submap_universal = true }
)
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("app2unit -- " .. browser), { submap_universal = true })
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("app2unit -- " .. editor), { submap_universal = true })
hl.bind("CTRL+ALT+V", hl.dsp.exec_cmd("app2unit -- pwvucontrol"), { submap_universal = true })

-- Utilities
hl.bind(mainMod .. " + CTRL+S", hl.dsp.global("caelestia:screenshotFreezeClip"), { submap_universal = true })
hl.bind("Print", hl.dsp.global("caelestia:screenshotFreezeClip"), { submap_universal = true })
hl.bind("CTRL + Print", hl.dsp.exec_cmd("caelestia screenshot"), { submap_universal = true, release = true })
hl.bind("CTRL + ALT + R", hl.dsp.exec_cmd("caelestia record -s"), { submap_universal = true }) -- with sound
hl.bind(mainMod .. " + ALT + R", hl.dsp.exec_cmd("caelestia record"), { submap_universal = true })
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("caelestia record -r"), { submap_universal = true })

local MAX_ZOOM = 6
local MIN_ZOOM = 1

local function zoom(offset)
	local current = hl.get_config("cursor.zoom_factor")
	current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current + offset))
	hl.config({ cursor = { zoom_factor = current } })
end

hl.bind(mainMod .. "+equal", function()
	zoom(0.1)
end, { submap_universal = true, repeating = true })

hl.bind(mainMod .. "+minus", function()
	zoom(-0.1)
end, { submap_universal = true, repeating = true })

hl.bind(mainMod .. "+0", function()
	hl.config({ cursor = { zoom_factor = 1 } })
end, { submap_universal = true })

hl.bind(mainMod .. "+BACKSPACE", hl.dsp.global("caelestia:lock"), { submap_universal = true })
hl.bind(mainMod .. "+P", hl.dsp.global("caelestia:session"), { submap_universal = true })
hl.bind(mainMod .. "+A", hl.dsp.global("caelestia:sidebar"), { submap_universal = true })

-- Move/resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { submap_universal = true, mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { submap_universal = true, mouse = true })

-- Brightness
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.global("caelestia:brightnessDown"),
	{ submap_universal = true, locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.global("caelestia:brightnessUp"),
	{ submap_universal = true, locked = true, repeating = true }
)
hl.bind(
	"ALT+F9",
	hl.dsp.global("caelestia:brightnessDown"),
	{ submap_universal = true, locked = true, repeating = true }
)
hl.bind(
	"ALT+F10",
	hl.dsp.global("caelestia:brightnessUp"),
	{ submap_universal = true, locked = true, repeating = true }
)

-- Media
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ submap_universal = true, locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ submap_universal = true, locked = true, repeating = true }
)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ submap_universal = true, locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ submap_universal = true, locked = true, repeating = true }
)

hl.bind(
	"ALT+F1",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ submap_universal = true, locked = true, repeating = true }
)
hl.bind(
	"ALT+F2",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ submap_universal = true, locked = true, repeating = true }
)
hl.bind(
	"ALT+F3",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ submap_universal = true, locked = true, repeating = true }
)
hl.bind(
	"ALT+F5",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ submap_universal = true, locked = true, repeating = true }
)

hl.bind(mainMod .. " + F1", hl.dsp.global("caelestia:mediaToggle"), { submap_universal = true, locked = true })
hl.bind(mainMod .. " + F2", hl.dsp.global("caelestia:mediaPrev"), { submap_universal = true, locked = true })
hl.bind(mainMod .. " + F3", hl.dsp.global("caelestia:mediaNext"), { submap_universal = true, locked = true })
hl.bind("XF86AudioPlay", hl.dsp.global("caelestia:mediaToggle"), { submap_universal = true, locked = true })
hl.bind("XF86AudioPause", hl.dsp.global("caelestia:mediaToggle"), { submap_universal = true, locked = true })
hl.bind("XF86AudioPrev", hl.dsp.global("caelestia:mediaPrev"), { submap_universal = true, locked = true })
hl.bind("XF86AudioNext", hl.dsp.global("caelestia:mediaNext"), { submap_universal = true, locked = true })
hl.bind("XF86AudioStop", hl.dsp.global("caelestia:mediaStop"), { submap_universal = true, locked = true })

-- Special workspaces
hl.bind("CTRL + SHIFT + ESCAPE", hl.dsp.exec_cmd("caelestia toggle sysmon"), { submap_universal = true })
hl.bind(mainMod .. " +D", hl.dsp.exec_cmd("caelestia toggle communication"), { submap_universal = true })
hl.bind(mainMod .. " +N", hl.dsp.exec_cmd("caelestia toggle notes"), { submap_universal = true })
hl.bind(mainMod .. " +M", hl.dsp.exec_cmd("caelestia toggle music"), { submap_universal = true })
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("special"), { submap_universal = true })
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:special" }), { submap_universal = true })

-- Workspace switching: per-monitor ranges (split-monitor-workspaces), so on a
-- multi-monitor setup SUPER+1 jumps to workspace 1 of *this* monitor.
for i = 1, smw.get_amount_of_workspaces() do
	local key = tostring(i)
	if key == "10" then
		key = "0"
	end
	hl.bind(mainMod .. " + " .. key, smw.workspace(key), { submap_universal = true })
	hl.bind(mainMod .. " + SHIFT + " .. key, smw.move_to_workspace(key), { submap_universal = true })
	hl.bind(mainMod .. " + CTRL + " .. key, smw.move_to_workspace_silent(key), { submap_universal = true })
end

-- First empty workspace on the current monitor (SUPER+E is the file manager).
hl.bind(mainMod .. " + SHIFT + E", smw.move_to_workspace("empty"), { submap_universal = true })
hl.bind(mainMod .. " + CTRL + E", smw.workspace("empty"), { submap_universal = true })

-- Scroll through existing workspaces with mainMod + scroll (current monitor only)
hl.bind(mainMod .. " + mouse_down", smw.cycle_workspaces("next"), { submap_universal = true })
hl.bind(mainMod .. " + mouse_up", smw.cycle_workspaces("prev"), { submap_universal = true })
