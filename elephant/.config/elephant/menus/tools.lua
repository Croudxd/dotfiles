Name = "tools"
NamePretty = "tools"
FixedOrder = true
HideFromProviderlist = true
Icon = ""
Parent = "menu"

function GetEntries()
	return {
		{
			Text = "ISO to usb",
			Icon = "",
			Actions = {
				["write-iso"] = "ghostty --class=local.floating -e write-iso",
			},
		},
	}
end
