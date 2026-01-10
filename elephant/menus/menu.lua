Name = "menu"
NamePretty = "Menu"
FixedOrder = true
HideFromProviderlist = true
Description = "Menu"

function GetEntries()
	return {
		{
			Text = "Update",
			Icon = "",
			Actions = {
				["update"] = "ghostty --class=local.floating -e update-perform",
			},
		},
		{
			Text = "Capture",
			Icon = "",
			Actions = {
				["capture"] = "walker -t menus -m menus:capture -N",
			},
		},
		{
			Text = "Tools",
			Icon = "",
			Actions = {
				["tools"] = "walker -t menus -m menus:tools -N",
			},
		},
		{
			Text = "Keybindings",
			Icon = "",
			Actions = {
				["keybindings"] = "walker -t menus -m menus:keybindings -N",
			},
		},
		{
			Text = "System",
			Icon = "󰐥",
			Actions = {
				["system"] = "walker -t menus -m menus:system -N",
			},
		},
	}
end
