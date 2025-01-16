local cntr = {
	['default'] = "Server Crashed Or You Have Lost Connection! Reconnect in %s sec.",
	["RU"] = "Переподключение через %s сек."
}

if CLIENT then
	local last_timeout = nil
	local retry_time = 120

	local lpvalid = false
	net.Receive("TIMEOUT", function()
		last_timeout = CurTime()
		retry_time = net.ReadInt(11)
	end)
	local lng = cntr[system.GetCountry()] or cntr['default']

	timer.Create("check_load", 1, 0, function()
		if !LocalPlayer() or !LocalPlayer():IsValid() then return end
		timer.Simple(10, function()
			lpvalid = true
		end)
		timer.Remove("check_load")
	end)
	hook.Add("HUDPaint", "TIMEOUT", function()
		if not lpvalid then return end
		if not last_timeout then return end
		if CurTime() - last_timeout <= 10 then return end
		draw.SimpleText(lng:format(math.Round(((last_timeout + retry_time) - CurTime()))), "Trebuchet24", ScrW() / 2, ScrH() / 2, Color(255, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

		if (CurTime() - last_timeout) > retry_time then
			RunConsoleCommand("retry")
		end
	end)
else
	local addons = 60
	util.AddNetworkString("TIMEOUT")
	local time = addons
	timer.Create("TIMEOUT", 5, 0, function()
		net.Start("TIMEOUT")
			net.WriteInt(time, 11)
		net.Broadcast()

		time = #player.GetAll()/3.77777777776 + addons
	end)

	local files, dirs = file.Find("garrysmod/addons/*", "BASE_PATH")
	addons = #dirs
end