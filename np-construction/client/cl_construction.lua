local assignedZone = nil
local isInZone = false
local constructionStatus = 'Waiting to be assigned a job...'
local isCurrentlyConstructing = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		-- For debug only
		if isInZone and assignedZone then
			if IsControlJustPressed(1, 86) then 
				attempToConstruct() -- This can be changed to an event handler so if you want to call it when you use an item
			end
		end
		exports.functions:showText(constructionStatus)
	end
end)

-- Called when the player gets assigned to a zone
RegisterNetEvent("np-construction:assignedZone")
AddEventHandler("np-construction:assignedZone", function(zone)
	local playerServerId = GetPlayerServerId(PlayerId())

	-- TODO: Replace this with a function to generate all types of zones based on the zoneType ('box', 'circle', 'poly')
	zone.area = createZone(zone)
	zone.area:onPlayerInOut(handlePlayerEnteringZone)

	assignedZone = zone
	constructionStatus = "Assigned to zone - " .. zone.name
	exports.functions:sendNotification('~g~You have been assigned to a new zone ' .. zone.name, playerServerId, Config.useNoPixelExports)

	if Config.useNopixelExports then
		exports["np-activities"]:activityInProgress(Config.activityName, playerServerId)
	else
		exports.functions:sendNotification("~g~Activity in progress", playerServerId, Config.useNoPixelExports)
	end
end)

-- Called when the player completes first assigned zone
RegisterNetEvent("np-construction:clearAssignedZone")
AddEventHandler("np-construction:clearAssignedZone", function(zone)
	local playerServerId = GetPlayerServerId(PlayerId())

	Citizen.CreateThread(function()
		constructionStatus = 'Looking for zone'
		assignedZone.area:destroy()
		assignedZone = nil
		isInZone = false

		
		exports.functions:sendNotification('~g~Assigned Zone Complete', playerServerId, Config.useNoPixelExports)

		-- TODO: possibly set this delay to a random number based on # of jobs completed so far (would need config setup)
		Citizen.Wait(5000)
		
		TriggerServerEvent("np-construction:assignZone")
		exports.functions:sendNotification('~g~New Zone Assigned', playerServerId, Config.useNoPixelExports)
	end)
end)

-- Called when we are mining a valid rock
RegisterNetEvent("np-mining:beginConstruction")
AddEventHandler("np-mining:beginConstruction", function(zone, task, hitsNeeded, source)
	local playerServerId = GetPlayerServerId(PlayerId())

	isCurrentlyConstructing = true

	if Config.useNoPixelExports then
		exports["np-activities"]:taskInProgress(Config.activityName, playerServerId, 'started_constructing_' .. task.id, 'Started Construction...')
	else
		exports.functions:sendNotification('~g~started_constructing_'..task.id, playerServerId, Config.useNoPixelExports)
	end

	startConstructionAnimation(zone, GetPlayerPed(-1), task, hitsNeeded, source)
end)

-- Called when we are done breaking the rock and going to collect it
RegisterNetEvent("np-mining:completeTask")
AddEventHandler("np-mining:completeTask", function(zone, task, reward)
	local playerServerId = GetPlayerServerId(PlayerId())
	isCurrentlyConstructing = false

	if Config.useNoPixelExports then
		exports["np-activities"]:giveInventoryItem(playerServerId, reward, 1)
		exports["np-activities"]:taskCompleted(Config.activityName, playerServerId, 'started_constructing_' .. task.id, true, 'Construction Complete!')
	else
		exports.functions:sendNotification("~g~finished_constructing_" .. task.id, playerServerId, Config.useNoPixelExports)
	end

	exports.functions:sendNotification("~g~Construction Completed and received a " .. reward, playerServerId, Config.useNoPixelExports)
end)

-- Called when user wants to stop construction
RegisterNetEvent("np-construction:stopConstruction")
AddEventHandler("np-construction:stopConstruction", function(zone, activity)
	local playerServerId = GetPlayerServerId(PlayerId())

	if assignedZone ~= nil then
		assignedZone.area:destroy() -- Lets delete poly zone now
	end

	assignedZone = nil
	constructionStatus = "No Task Assigned"
	isInZone = false
	isCurrentlyConstructing = false

	if Config.useNopixelExports then
		exports["np-activities"]:activityCompleted(Config.activityName, playerServerId, true, 'Player either completed or cancelled their task!')
	else
		exports.functions:sendNotification('~g~Activity was completed or cancelled', playerServerId, Config.useNoPixelExports)
	end

end)

-- Called when the player is assigned to a zone
function handlePlayerEnteringZone(isPointInside, point)
	if assignedZone then
		if isPointInside then
			print('Player entered zone')
			-- generateRockObjs(assignedZone.rocks, assignedZone.rockProp)
			isInZone = true
			constructionStatus = 'Complete tasks!'
		else
			print('player exited zone')
			-- removeRockObjs(assignedZone.rocks)
			isInZone = false
			constructionStatus = "Go to the job site - " .. assignedZone.name
		end
	end
end

-- Called when player enters a job zone and needs to generate the task objects
-- function generateRockObjs(rocks, prop)
-- 	local newRocks = rocks

-- 	for i, rock in pairs(newRocks) do
-- 		local unused, objectZ = GetGroundZFor_3dCoord(rock.coords["x"], rock.coords["y"], 99999.0, 1)
-- 		rock.object = CreateObject(GetHashKey(prop), rock.coords["x"], rock.coords["y"], objectZ - 0.2, false, true, false)
-- 		FreezeEntityPosition(rock.object, true)
-- 		-- Maybe you want to create a PolyZone here so that you can "peak" to start mining
-- 	end

-- 	assignedZone.rocks = newRocks
-- end
  
-- Used to remove rock objs when the player leaves the zone
-- function removeRockObjs(rocks)

-- 	for i, rock in pairs(rocks) do

-- 		if rock.object ~= nil then
-- 			DetachEntity(rock.object, 1, true)
-- 			DeleteEntity(rock.object)
-- 			DeleteObject(rock.object)
-- 		end
	
-- 	end
	
-- end