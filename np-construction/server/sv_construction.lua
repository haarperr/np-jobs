if Config.enabled then
	Config.print(Config.initMessage)
end

local playersTasksTotal = {}
local playersZonesCompleted = {}

AddEventHandler("playerDropped", function()
	for _, zone in pairs(Config.zones) do
		for _, activity in pairs(zone.activities) do
			if activity.beingConstructedBy == source and not constructed then
				activity.isBeingConstructed = false
				activity.beingConstructedBy = nil
				print('Player dropped & didn\'t finish tasks, reset it!')
			end
		end
	end
end)

-- Called when player joins job to assign them a zone
RegisterServerEvent("np-construction:assignZone")
AddEventHandler("np-construction:assignZone", function()
	local zoneList = Config.zones -- Stored so I can remove any zones if the person already did it and choose from that list

	-- Let me check if player hit zone limit during this run?
	if playersZonesCompleted[source] ~= nil and #playersZonesCompleted[source] >= Config.zone_limit then
		TriggerEvent("np-construction:completeRun", source)
		return print('You have completed max amount of zones this run')	 -- Notify User with UI
	end

	-- Loop through our zones and remove the ones theyve done
	if playersZonesCompleted[source] ~= nil then
		for index, zone in pairs(zoneList) do
			for _, playerZoneDone in pairs (playersZonesCompleted[source]) do
				if zone.id == playerZoneDone then
					table.remove(zoneList, index)
					print('Removing this zone because player has done it already')
				end
			end
		end
	end

	-- Check if their is any zones the player can do (edge case)
	if #zoneList == 0 then
		TriggerEvent("np-construction:completeRun")
		return print('You have no more zones you can work at this time.') -- Notify User with UI
	end

	local randomZoneIndex = math.random(#zoneList)
	local randomZone = zoneList[randomZoneIndex]

	playersTasksTotal[source] = nil -- Set to nil again once we move to another zone so then we can track that zones tasks
	TriggerClientEvent("np-construction:assignedZone", source, randomZone)
end)

-- Called when the player completed their assigned amount of zones
RegisterServerEvent("np-construction:completeRun")
AddEventHandler("np-construction:completeRun", function(src)
	playersTasksTotal[src] = nil -- Remove how many tasks they completed
	playersZonesCompleted[src] = nil -- Remove them from zones completed so when they strart the job again after a "cooldown" its backto default
	TriggerClientEvent("np-construction:stopConstruction", src) -- Now lets tell client theyre not assigned a zone and reset their variables
end)

-- NOTE: Debug event used to generate rock coords, comment out before using in production
-- RegisterServerEvent("np-construction:genCoords")
-- AddEventHandler("np-construction:genCoords", function(coords)
-- 	print(coords)
-- 	file = io.open("construction-coords.txt", "a")
-- 	if file then
-- 		file:write(coords)
-- 		file:write("\n")
-- 	end
-- 	file:close()
-- end)
-- NOTE END

RegisterServerEvent("np-construction:resetTask")
AddEventHandler("np-construction:resetTask", function()
	resetZoneTasks()
end)