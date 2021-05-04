-- Call event when job is accepted and assigned to player
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
		notifyPlayer('~r~~You can\'t do this job at this time.' .. Config.requiredItem) -- Notify Player
	end
end, false)

-- Call event to remove you from the construction job
RegisterCommand("attempt_task", function(source, args)
	TriggerEvent("np-construction:attemptTask", false)
end, false)
-- map the command to a key
RegisterKeyMapping('attempt_task', 'Attempt to complete task at an object within an assigned zone', 'keyboard', 'e')

-- Call event to remove you from the construction job
RegisterCommand("stop_construction", function(source, args)
	TriggerEvent("np-construction:stopJob", false)
end, false)
  
-- NOTE: There are here for testing to give player a tool if needed
RegisterCommand("give_tool", function(source, args)
local playerServerId = GetPlayerServerId(PlayerId())
	if Config.useNoPixelExports then
		if Config.requireMultipleItems then
			for _, item in pairs(Config.requiredItems) do
				exports["np-activities"]:giveInventoryItem(playerServerId, item.id, 1)
			end
		else
			exports["np-activities"]:giveInventoryItem(playerServerId, Config.requiredItem, 1)
		end
	else
		if Config.requireMultipleItems then
			notifyPlayer('~y~Gave: ' .. json.encode(Config.requiredItems)) -- Notify Player
		else
			notifyPlayer('~y~Gave: ' .. Config.requiredItem) -- Notify Player
		end
	end
end, false)

RegisterCommand("gen_coords", function(source, args)
	local playerPed = GetPlayerPed(-1)
	TriggerServerEvent("np-construction:genCoords", GetEntityCoords(playerPed))
end, false)
-- NOTE: end note