local home = os.getenv("HOME")
local scripts = home .. "/.config/hypr/scripts/"

hl.on("hyprland.start", function()
	hl.exec_cmd("mpris-proxy") -- Forward bluetooth media commands to MPRIS
	hl.exec_cmd("caelestia resizer -d")
	hl.exec_cmd("QT_QPA_PLATFORMTHEME=kde caelestia shell -d")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd(scripts .. "random_wallpaper.sh")
	hl.exec_cmd("bitwarden")
	hl.exec_cmd("trash-empty 30") -- Auto delete trash 30 days old
end)
