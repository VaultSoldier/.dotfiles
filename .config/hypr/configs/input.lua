-- https://wiki.hyprland.org/Configuring/Variables/#input
hl.config({
	input = {
		kb_layout = "us,ru",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:alt_shift_toggle",
		kb_rules = "",

		accel_profile = "flat",
		follow_mouse = 1,
		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			disable_while_typing = false,
			natural_scroll = false,
		},
	},

	-- https://wiki.hyprland.org/Configuring/Variables/#gestures
	hl.gesture({
		fingers = 4,
		direction = "horizontal",
		action = "workspace",
	}),
	-- hl.gesture({
	-- 	fingers = 3,
	-- 	direction = "right",
	-- 	action = "dispatcher layoutmsg focus left",
	-- }),
	-- hl.gesture({
	-- 	fingers = 3,
	-- 	direction = "left",
	-- 	action = "dispatcher, layoutmsg, focus right",
	-- }),
	hl.gesture({
		fingers = 3,
		direction = "up",
		action = function()
			hl.dsp.layout("colresize +2conf")
		end,
	}),
	hl.gesture({
		fingers = 3,
		direction = "down",
		action = function()
			hl.dsp.layout("colresize -conf")
		end,
	}),

	-- Example per-device config
	-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
	hl.device({
		name = "mosart-semi.-msi-forge-k200-wireless-combo-mouse",
		accel_profile = "flat",
		sensitivity = -0.5,
	}),
})
