Name = "themes"
NamePretty = "Themes"
FixedOrder = true
HideFromProviderlist = true
Icon = "󰸌"
Parent = "menu"

function GetEntries()
	return {
		{
			Text = "System theme",
			Icon = "󰸌",
			Actions = {
				["change-theme"] = "walker --theme menus -m menus:system-themes -N",
			},
		},
		{
			Text = "Waybar theme",
			Icon = "󰸌",
			Actions = {
				["change-waybar"] = "walker --theme menus -m menus:waybar-themes -N",
			},
		},
	}
end
