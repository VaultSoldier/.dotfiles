-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
-- https://wiki.hyprland.org/Configuring/Variables/#general

hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 6,
		border_size = 2,

		col = {
			active_border = { colors = { "rgba(616bc9ee)", "rgba(9376c2ee)", "rgba(c197dbee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = true,
		layout = "dwindle",
	},

	decoration = {
		rounding = 9,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 1,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 6,
			passes = 3,
			vibrancy = -40,
		},
	},

	-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
	dwindle = {
		preserve_split = true, -- You probably want this
	},

	-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
	master = {
		new_status = "master",
	},

	-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
	scrolling = {
		fullscreen_on_one_column = true,
		column_width = 0.5,
		wrap_swapcol = false,
	},

	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
	},

	animations = {
		enabled = true,
	},
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 150, dampening = 22 })
hl.curve("snap", { type = "bezier", points = { { 0.2, 0.9 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })

hl.animation({ leaf = "windows", enabled = true, speed = 8.2, bezier = "snap" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 8.2, bezier = "snap", style = "popin 90%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 6.6, bezier = "snap", style = "popin 90%" })

hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.5, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.5, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 2.6, bezier = "quick" })

hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })

hl.animation({ leaf = "workspaces", enabled = true, speed = 1.2, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.2, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 1.2, bezier = "snap", style = "fade" })
hl.animation({ leaf = "specialWorkspaceIn", enabled = true, speed = 1.2, bezier = "snap", style = "fade" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 1.2, bezier = "snap", style = "fade" })

hl.animation({ leaf = "zoomFactor", enabled = true, speed = 3, bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
