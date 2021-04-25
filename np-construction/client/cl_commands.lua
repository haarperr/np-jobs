-- Call event to assign you a mining zone
RegisterCommand("start_construction", function(source, args)
	local canDoActivity = false
	local playerServerId = GetPlayerServerId(PlayerId())
  
	if Config.useNoPixelExports then
		canDoActivity = exports["np-activities"]:canDoActivity(Config.activityName, playerServerId)
	else
		canDoActivity = true
	end
  
	if canDoActivity then
		TriggerServerEvent("np-construction:assignZone")
	else
		exports.functions:sendNotification("~r~You cant do this job at this time.", playerServerId, Config.useNoPixelExports)
	end
end, false)

-- Call event to remove you from the construction job
RegisterCommand("stop_construction", function(source, args)
	TriggerEvent("np-construction:stopConstruction")
end, false)
  
  
-- This is was here for testing to give player a tool to use (can remove this)
-- RegisterCommand("givepickaxe", function(source, args)
--   local playerServerId = GetPlayerServerId(PlayerId())
--   exports["np-activities"]:giveInventoryItem(playerServerId, Config.required_item, 5)
--   sendNotification("Gae item", playerServerId, Config.useNoPixelExports)
-- end, false)

-- RegisterCommand("genrock", function(source, args)
--   local playerPed = GetPlayerPed(-1)
--   TriggerServerEvent("np-mining:genRock", GetEntityCoords(playerPed))
-- end, false)