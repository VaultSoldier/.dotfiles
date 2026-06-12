local hostname = os.getenv("HOSTNAME")

-- See https://wiki.hyprland.org/Configuring/Monitors/
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

if hostname == "desktop" then
	hl.monitor({
		output = "desc:Xiaomi Corporation Mi Monitor 5598910068340",
		mode = "2560x1440@180",
		position = "0x0",
		scale = 1,
	})
	hl.monitor({
		output = "desc:LG Electronics LG FULL HD 503NDFV8J979",
		mode = "1920x1080@60",
		position = "2560x200",
		scale = 1,
	})
	hl.monitor({
		output = "desc:XMD Mi TV 0x00000001",
		mode = "3840x2160@60",
		position = "auto",
		scale = 2,
	})
end

if hostname == "agentsmith" then
	hl.monitor({
		output = "desc:AOC Q32P2WG5B PPNM6HA016359",
		mode = "2560x1440@74.97",
		position = "0x0",
		scale = 1,
	})
	hl.monitor({
		output = "desc:ChangHong Electric Co.Ltd SUN-M32BF101 0000000000001",
		mode = "2560x1440@59.95",
		position = "2560x0",
		scale = 1,
	})
	hl.monitor({
		output = "desc:ASUSTek COMPUTER INC VG32AQA1A T3LMQS058494",
		mode = "2560x1440@60",
		position = "2560x0",
		scale = 1,
	})
	hl.monitor({
		output = "desc:Samsung Display Corp. 0x4171",
		mode = "2880x1800@90",
		position = "320x1440",
		scale = 1.5,
	})
end
