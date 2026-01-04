local cntr = {
	['default'] = "Server Crashed Or You Have Lost Connection! Reconnect in %s sec.",
	['RU'] = "Переподключение через %s сек."
}

-- ======================
-- CLIENT
-- ======================
if CLIENT then
	local last_timeout
	local retry_time = 60
	local lpvalid = false
	local retried = false

	local lng = cntr[system.GetCountry()] or cntr['default']

	net.Receive("TIMEOUT", function()
		last_timeout = CurTime()
		retry_time = net.ReadUInt(16)
		retried = false
	end)

	hook.Add("InitPostEntity", "Timeout_PlayerReady", function()
		lpvalid = true
	end)

	hook.Add("HUDPaint", "TIMEOUT_Display", function()
		if not lpvalid or not last_timeout then return end
		if CurTime() - last_timeout <= 10 then return end

		local remaining = math.max(0, math.ceil((last_timeout + retry_time) - CurTime()))

		draw.SimpleText(
			lng:format(remaining),
			"Trebuchet24",
			ScrW() / 2,
			ScrH() / 2,
			Color(255, 0, 0),
			TEXT_ALIGN_CENTER,
			TEXT_ALIGN_TOP
		)

		if remaining <= 0 and not retried then
			retried = true
			RunConsoleCommand("retry")
		end
	end)

-- ======================
-- SERVER
-- ======================
else
	util.AddNetworkString("TIMEOUT")

	local RECONNECT_TIME = 60 -- seconds (FIXED)

	timer.Create("TIMEOUT", 5, 0, function()
		net.Start("TIMEOUT")
			net.WriteUInt(RECONNECT_TIME, 16)
		net.Broadcast()
	end)
end
