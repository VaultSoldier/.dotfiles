-- https://wiki.hyprland.org/Configuring/
require("monitors")

----------------------
----- SMW PLUGIN -----
----------------------

local cfg_dir = os.getenv("HOME") .. "/.config/hypr"
package.path = package.path
	.. ";./plugins/?.lua;./plugins/?/init.lua"
	.. ";"
	.. cfg_dir
	.. "/plugins/?.lua;"
	.. cfg_dir
	.. "/plugins/?/init.lua"

local smw = require("plugins.split-monitor-workspaces")

smw.setup({
	-- Workspaces per monitor: SUPER+3 always means "the 3rd workspace of the
	-- monitor I am on", regardless of the absolute workspace id.
	workspace_count = 9,
	keep_focused = true,
	enable_persistent_workspaces = true,

	-- Who owns the lowest ids; unlisted monitors keep the order Hyprland reports them
	-- (names as shown by `hyprctl monitors`).
	-- monitor_priority = { "desc:AOC Q32P2WG5B PPNM6HA016359", "desc:XMD Mi TV 0x00000001" },

	-- Smaller range for a specific monitor:
	-- max_workspaces = { ["desc:XMD Mi TV 0x00000001"] = 4 },

	-- Keep ranges across hotplug (useful for the TV / docking setups):
	-- restore_workspaces_on_monitor_reconnect = true,
})

require("configs.keybinds")
require("configs.autostart")
require("configs.env")
require("configs.input")
require("configs.style")
require("configs.windowrules")

hl.config({
	render = {
		-- Hyprland >= 0.57 offers an HDR "preferred image description" to whatever window is
		-- fullscreen on an EDID-HDR-capable output. Chromium/CEF follows it and drags the output
		-- into a wide-gamut 10-bit pipeline even for plain SDR content
		cm_auto_hdr = 0,
	},

	binds = {
		window_direction_monitor_fallback = false,
	},
})

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")
