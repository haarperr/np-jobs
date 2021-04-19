-- Call event to assign you a mining zone
RegisterCommand("start_construction", function(source, args)
	local canDoActivity = false
	local playerServerId = GetPlayerServerId(PlayerId())
  
	if Config.useNoPixelExports then
		canDoActivity = exports["np-activities"]:canDoActivity("activity_construction", playerServerId)
	else
		canDoActivity = true
	end
  
	if canDoActivity then
		TriggerServerEvent("np-construction:assignZone")
	else
		sendNotification("You cant do this job at this time.", playerServerId)
	end
end, false)

-- Call event to remove you from the construction job
RegisterCommand("stop_construction", function(source, args)
	TriggerEvent("np-construction:stopConstruction")
end, false)
  
  
-- This is was here for testing to give me a pickaxe to mine (can remove this)
-- RegisterCommand("givepickaxe", function(source, args)
--   local playerServerId = GetPlayerServerId(PlayerId())
--   exports["np-activities"]:giveInventoryItem(playerServerId, Config.required_item, 5)
--   sendNotification("Gae item", playerServerId)
-- end, false)

-- RegisterCommand("genrock", function(source, args)
--   local playerPed = GetPlayerPed(-1)
--   TriggerServerEvent("np-mining:genRock", GetEntityCoords(playerPed))
-- end, false)