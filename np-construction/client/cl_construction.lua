local activityName = Config.activityName
local assignedZone = nil
local isInZone = false
local constructionStatus = 'Waiting for a job assignment...'
local isCurrentlyConstructing = false
local jobBlip = 0

-- NOTE: For debug only
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(1)
-- 		exports["functions"]:showText(constructionStatus)
-- 	end
-- end)

RegisterNetEvent("np-construction:attemptTask")
AddEventHandler("np-construction:attemptTask", function(zone)
	if not isInZone then
		return print('Player is not in a zone!')
	end

	if assignedZone == nil then
		return print('Player is not assigned a zone!')
	end

	local hasRequiredTools = false
	local playerServerId = GetPlayerServerId(PlayerId())

	if Config.useNoPixelExports then
		hasRequiredTools = exports["np-activities"]:hasInventoryItem(playerServerId, Config.requiredItem)
	else
		-- NOTE: This is for dev testing only, comment out or add better check here in production
		hasRequiredTools = true
	end

	if hasRequiredTools then
		local ped = PlayerPedId()
		local playerCoord = GetEntityCoords(ped)
		local target = GetOffsetFromEntityInWorldCoords(ped, vector3(0,2,-3))
		local testRay = CastRayPointToPoint(playerCoord, target, 26, ped, 7)
		local _, hit, hitLocation, surfaceNormal, taskObj, _ = GetRaycastResult(testRay)
		model = GetEntityModel(taskObj)

		-- NOTE: Debugging Only, comment out for production
		print('Task Object:' .. taskObj .. ' || Object Model' .. model)

		for _, task in pairs(assignedZone.tasks) do
			if task.model == model then
				TriggerServerEvent("np-construction:attemptTask", assignedZone, task)
			end
		end
	else
		if Config.useNoPixelExports then
			exports["np-activities"]:notifyPlayer(playerServerId, '~r~You don\'t have the item to do this task.')
		else
			exports["functions"]:sendNotification('~r~You don\'t have the item to do this task.', playerServerId)
		end
	end
end)

-- Called when the player gets assigned to a zone
RegisterNetEvent("np-construction:assignedZone")
AddEventHandler("np-construction:assignedZone", function(zone)
	local playerServerId = GetPlayerServerId(PlayerId())
	
	-- Create the polyzone
	zone.area = createZone(zone)
	if zone.area ~= nil then
		zone.area:onPlayerInOut(handlePlayerEnteringZone)
		assignedZone = zone
		constructionStatus = "Assigned to zone - " .. assignedZone.name

		if Config.useNopixelExports then
			exports["np-activities"]:activityInProgress(activityName, playerServerId, Config.timeToComplete)
		else
			exports["functions"]:sendNotification('~b~Assigned to: ' .. assignedZone.name, playerServerId, Config.useNoPixelExports)
		end
	end
	-- clear any existing job blips
	if (jobBlip ~= 0) then
		removeActivityDestination(zone)
	end
	-- Finish by creating zone destination blips
	if (jobBlip ~= 0) then
		if Config.useNopixelExports then
			exports["np-activities"]:setActivityDestination(zone)
		else
			setActivityDestination(zone)
		end
	end
end)

-- Called when the player completes first assigned zone
RegisterNetEvent("np-construction:clearAssignedZone")
AddEventHandler("np-construction:clearAssignedZone", function(zone)
	local playerServerId = GetPlayerServerId(PlayerId())
	local wait = Config.getZoneAssignmentDelay() -- (integer) wait random amount of time based on config settings before assigning next zone

	Citizen.CreateThread(function()
		constructionStatus = 'Waiting for a job assignment...'
		assignedZone.area:destroy()
		assignedZone = nil
		isInZone = false
		-- get next zone
		Citizen.Wait(wait)
		TriggerServerEvent("np-construction:assignZone")
		-- exports["functions"]:sendNotification('~g~New Zone Assigned', playerServerId, Config.useNoPixelExports)
	end)
end)

-- Called when we are interacting with a valid task model
RegisterNetEvent("np-construction:beginTask")
AddEventHandler("np-construction:beginTask", function(zone, task, requiredHits, source)
	local playerServerId = GetPlayerServerId(PlayerId())
	isCurrentlyConstructing = true

	-- print('^6BEGIN: ' .. task.id)
	if Config.useNoPixelExports then
		exports["np-activities"]:taskInProgress(activityName, playerServerId, task.id, task.name)
	else
		exports["functions"]:sendNotification('~b~Started Task: '..task.name, playerServerId, Config.useNoPixelExports)
	end

	-- TODO: Check task and get proper animation based on object model being interacted with???
	startTaskAnimation(zone, GetPlayerPed(-1), task, requiredHits, source)
end)

-- Called when we are done with a task
RegisterNetEvent("np-construction:completeTask")
AddEventHandler("np-construction:completeTask", function(zone, task)
	local playerServerId = GetPlayerServerId(PlayerId())
	isCurrentlyConstructing = false

	if Config.useNoPixelExports then
		exports["np-activities"]:taskCompleted(activityName, playerServerId, 'Completed Task: ' .. task.id, true, 'Construction Complete!')
	else
		exports["functions"]:sendNotification('~p~Completed Task: ' .. task.id, playerServerId, Config.useNoPixelExports)
	end
end)

-- Called when user wants to stop construction
RegisterNetEvent("np-construction:stopJob")
AddEventHandler("np-construction:stopJob", function(successful)
	local playerServerId = GetPlayerServerId(PlayerId())
	
	if assignedZone ~= nil then
		assignedZone.area:destroy() -- Lets delete poly zone now
	end

	assignedZone = nil
	constructionStatus = "No Job Assigned"
	isInZone = false
	isCurrentlyConstructing = false
	-- was the job was completed or cancelled?
	if successful then
		if Config.useNopixelExports then
			exports["np-activities"]:activityCompleted(activityName, playerServerId, successful, 'Player completed the job!')
		else
			exports["functions"]:sendNotification('~p~Job Completed!', playerServerId, Config.useNoPixelExports)
		end
	else
		if Config.useNopixelExports then
			exports["np-activities"]:activityCompleted(activityName, playerServerId, successful, 'Player cancelled the job!')
		else
			exports["functions"]:sendNotification('~r~Job Cancelled!', playerServerId, Config.useNoPixelExports)
		end
	end
	-- Finish by removing any existing destination blips
	if (jobBlip ~= 0) then
		if Config.useNopixelExports then
			exports["np-activities"]:removeActivityDestination(jobBlip)
		else
			removeActivityDestination(jobBlip)
		end
	end
end)

-- Called when the server needs to issue a client side notification
RegisterNetEvent("np-construction:sendNotification")
AddEventHandler("np-construction:sendNotification", function(message)
	local playerServerId = GetPlayerServerId(PlayerId())
	if Config.useNoPixelExports then
		exports["np-activities"]:notifyPlayer(playerServerId, message)
	else
		exports["functions"]:sendNotification(message, playerServerId, Config.useNoPixelExports)
	end
end)

-- Called when the server needs to issue a client side notification
RegisterNetEvent("np-construction:giveInventoryItem")
AddEventHandler("np-construction:giveInventoryItem", function(item)
	local playerServerId = GetPlayerServerId(PlayerId())

	if item ~= nil then
		exports["np-activities"]:giveInventoryItem(playerServerId, item.id, item.amount)
	else
		print('No item(s) to give!')
	end
end)

-- Update a player's job blips
function setActivityDestination(zone)
	-- Start by removing any existing destination
	if (jobBlip ~= 0) then
		removeActivityDestination(zone)
	end

	if (zone ~= nil) then
		-- Add a blip and store its ID
		jobBlip = createBlipWithText(zone.blip.coords, 469, 7, 65, false, zone.id, zone.name)
	end

	-- Add a minimap route
	SetBlipRoute(jobBlip, true)
	SetBlipRouteColour(jobBlip, 7)
end

-- This script only activates a single destination blip at once || NOTE: zone is not needed, but it should be defined in the export
function removeActivityDestination(zone)
	if (jobBlip ~= 0) then
		RemoveBlip(jobBlip)
		jobBlip = 0
	end

	ClearAllBlipRoutes()
end

-- Called when the player is assigned to a zone
function handlePlayerEnteringZone(isPointInside, point)
	if assignedZone then
		if isPointInside then
			-- Notify Player
			if Config.useNopixelExports then
				exports["np-activities"]:notifyPlayer(playerServerId, '~b~Complete Tasks!')
			else
				exports["functions"]:sendNotification('~b~Complete Tasks!', playerServerId, Config.useNoPixelExports)
			end

			generateTaskObjs(assignedZone.tasks, assignedZone.prop)
			isInZone = true
			constructionStatus = 'Complete tasks!'
		else
			-- Notify Player
			if Config.useNopixelExports then
				exports["np-activities"]:notifyPlayer(playerServerId, '~y~Return to your assigned zone!')
			else
				exports["functions"]:sendNotification('~y~Return to your assigned zone!', playerServerId, Config.useNoPixelExports)
			end

			removeTaskObjs(assignedZone.tasks)
			isInZone = false
			constructionStatus = "Go to the job site - " .. assignedZone.name
		end
	end
end

-- Called when player enters a job zone and needs to generate the task objects
function generateTaskObjs(tasks, prop)
	local newTasks = tasks

	for i, task in pairs(newTasks) do
		local unused, objectZ = GetGroundZFor_3dCoord(task.coords["x"], task.coords["y"], 99999.0, 1)
		task.object = CreateObject(GetHashKey(prop), task.coords["x"], task.coords["y"], objectZ - 0.2, false, true, false)
		FreezeEntityPosition(task.object, true)
		-- Maybe you want to create a PolyZone here so that you can "peak" to start mining
	end

	assignedZone.tasks = newTasks
end
  
-- Used to remove task objects when the player leaves the zone
function removeTaskObjs(tasks)
	for i, task in pairs(tasks) do
		if task.object ~= nil then
			DetachEntity(task.object, 1, true)
			DeleteEntity(task.object)
			DeleteObject(task.object)
		end
	end
end