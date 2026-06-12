-- See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
-- See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

hl.window_rule({
	match = {
		fullscreen = true,
	},
	immediate = true,
	opacity = 1,
})
hl.window_rule({
	match = {
		class = "org.freedesktop.impl.portal.desktop.kde",
	},
	float = true,
	opacity = 0.85,
})

hl.layer_rule({
	match = { namespace = "caelestia-drawers" },
	blur = true,
	ignore_alpha = 0.5,
})
hl.layer_rule({
	match = { namespace = "caelestia-background" },
	blur = true,
	ignore_alpha = 0.5,
})

local function opacity_rule(class, value)
	hl.window_rule({ match = { class = class }, opacity = value })
end

local function float_rule(class, title)
	local match = {}
	if class then
		match.class = class
	end
	if title then
		match.title = title
	end
	hl.window_rule({ match = match, float = true })
end

float_rule("com.nextcloud.desktopclient.nextcloud")
float_rule("org.pulseaudio.pavucontrol")
float_rule("AmneziaVPN")
float_rule(nil, "Picture-in-Picture")
float_rule(nil, "Steam Settings")

opacity_rule("steam", 0.85)
opacity_rule("org.kde.dolphin", 0.85)
opacity_rule("spotify", 0.80)
opacity_rule("org.telegram.desktop", 0.85)

for _, match in ipairs({
	{ class = "Bitwarden" },
	{ class = "zen", title = "^(.*)Extension:(.*)Bitwarden(.*)$" },
}) do
	hl.window_rule({ match = match, float = true, no_screen_share = true })
end

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})
