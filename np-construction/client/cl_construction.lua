local activityName = Config.activityName
local assignedZone = nil
local isInZone = false
local jobStatus = 'Waiting for a job assignment...'
local isCurrentlyWorking = false
local jobBlip = nil

-- NOTE: For debug only
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(1)
-- 		exports["functions"]:showText(jobStatus)
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
		notifyPlayer('~r~You don\'t have the item to do this task.') -- Notify Player
	end
end)

-- Called when the player gets assigned to a zone
RegisterNetEvent("np-construction:assignedZone")
AddEventHandler("np-construction:assignedZone", function(zone)
	local playerServerId = GetPlayerServerId(PlayerId())
	local timeToComplete = Config.getTimeToComplete()

	-- Create the polyzone
	zone.area = createZone(zone)
	if zone.area ~= nil then
		zone.area:onPlayerInOut(handlePlayerEnteringZone)
		assignedZone = zone
		jobStatus = "Assigned to zone - " .. assignedZone.name

		if Config.useNoPixelExports then
			exports["np-activities"]:activityInProgress(activityName, playerServerId, timeToComplete)
		else
			notifyPlayer(jobStatus) -- Notify Player
		end
	end
	
	if jobBlip ~= nil then
		-- clear any existing job blips
		if Config.useNoPixelExports then
			exports["np-activities"]:removeActivityDestination(jobBlip)
		else
			removeBlip()
		end
	end 

	-- Finish by creating zone destination blips
	if Config.useNoPixelExports then
		exports["np-activities"]:setActivityDestination(jobBlip)
	else
		setBlip(assignedZone)
	end
end)

-- Called when the player completes first assigned zone
RegisterNetEvent("np-construction:clearAssignedZone")
AddEventHandler("np-construction:clearAssignedZone", function()
	local playerServerId = GetPlayerServerId(PlayerId())
	local wait = Config.getZoneAssignmentDelay() -- (integer) wait random amount of time based on config settings before assigning next zone

	Citizen.CreateThread(function()
		jobStatus = 'Waiting for a job assignment...'
		assignedZone.area:destroy()
		removeZoneObjects() -- clear task objects from the zone
		assignedZone = nil
		isInZone = false
		-- clear any existing job blips
		if (jobBlip ~= nil) then
			if Config.useNoPixelExports then
				exports["np-activities"]:removeActivityDestination(jobBlip)
			else
				removeBlip()
			end
		end
		-- get next zone
		Citizen.Wait(wait)
		TriggerServerEvent("np-construction:assignZone")
		-- notifyPlayer('~g~New Zone Assigned') -- Notify Player
	end)
end)

-- Called when we are interacting with a valid task model
RegisterNetEvent("np-construction:beginTask")
AddEventHandler("np-construction:beginTask", function(zone, task, requiredHits, source)
	local playerServerId = GetPlayerServerId(PlayerId())
	isCurrentlyWorking = true

	if Config.useNoPixelExports then
		exports["np-activities"]:taskInProgress(activityName, playerServerId, task.id, task.name)
	else
		notifyPlayer('~b~Started Task: '..task.name) -- Notify Player
	end
	-- TODO: Check task and get proper animation based on object model being interacted with???
	startTaskAnimation(zone, GetPlayerPed(-1), task, requiredHits, source)
end)

-- Called when we are done with a task
RegisterNetEvent("np-construction:completeTask")
AddEventHandler("np-construction:completeTask", function(zone, task)
	local playerServerId = GetPlayerServerId(PlayerId())
	isCurrentlyWorking = false

	if Config.useNoPixelExports then
		exports["np-activities"]:taskCompleted(activityName, playerServerId, 'Completed Task: ' .. task.id, true, 'Construction Complete!')
	else
		notifyPlayer('~p~Completed Task: ' .. task.id) -- Notify Player
	end
end)

-- Called when user wants to stop construction
RegisterNetEvent("np-construction:stopJob")
AddEventHandler("np-construction:stopJob", function(successful)
	local playerServerId = GetPlayerServerId(PlayerId())
	
	if assignedZone ~= nil then
		assignedZone.area:destroy() -- Lets delete poly zone now
		removeZoneObjects() -- clear task objects from the zone
	end
	assignedZone = nil
	jobStatus = "No Job Assigned"
	isInZone = false
	isCurrentlyWorking = false
	-- was the job was completed or cancelled?
	if successful then
		if Config.useNoPixelExports then
			exports["np-activities"]:activityCompleted(activityName, playerServerId, successful, 'Player completed the job!')
		else
			notifyPlayer('~p~Job Completed!') -- Notify Player
		end
	else
		if Config.useNoPixelExports then
			exports["np-activities"]:activityCompleted(activityName, playerServerId, successful, 'Player cancelled the job!')
		else
			notifyPlayer('~r~Job Cancelled!') -- Notify Player
		end
		
	end
	-- Finish by removing any existing destination blips
	if (jobBlip ~= nil) then
		if Config.useNoPixelExports then
			exports["np-activities"]:removeBlip(jobBlip)
		else
			removeBlip()
		end
	end
end)

-- Called when the server needs to issue a client side notification
RegisterNetEvent("np-construction:sendNotification")
AddEventHandler("np-construction:sendNotification", function(message)
	notifyPlayer(message) -- Notify Player
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
function setBlip(zone)
	-- Start by removing any existing destination
	if (jobBlip ~= nil) then
		removeBlip()
	end

	if (zone ~= nil) then
		-- Add a blip and store its ID
		createBlipWithText(zone.blip.coords, zone.blip.icon, zone.blip.color, zone.blip.alpha, false, zone.id, zone.name)
	end

	-- Add a minimap route
	SetBlipRoute(jobBlip, true)
	SetBlipRouteColour(jobBlip, 7)
end

-- Create a Blip on the map with text
function createBlipWithText(blipPosVector, blipSprite, blipColor, blipAlpha, isShortRange, blipTextName, blipTextDescription)
	jobBlip = AddBlipForCoord(blipPosVector.x, blipPosVector.y, blipPosVector.z)

	SetBlipSprite(jobBlip, blipSprite)
	SetBlipColour(jobBlip, blipColor)
	SetBlipAlpha(jobBlip, blipAlpha)
	SetBlipAsShortRange(jobBlip, isShortRange)

	AddTextEntry(blipTextName, blipTextDescription)
	BeginTextCommandSetBlipName(blipTextName)
	EndTextCommandSetBlipName(jobBlip)
end

-- Remove player's job blip
function removeBlip()
	if DoesBlipExist(jobBlip) then
		SetBlipAsMissionCreatorBlip(jobBlip, false)
		RemoveBlip(jobBlip)
		jobBlip = nil
	else
		print('No blip found!')
	end
	-- clear waypoints
	ClearAllBlipRoutes()
end

-- Called when the player is assigned to a zone
function handlePlayerEnteringZone(isPointInside, point)
	if assignedZone then
		if isPointInside then
			isInZone = true
			jobStatus = '~b~Complete tasks!'
			createZoneObjects()
			notifyPlayer(jobStatus) -- Notify Player
		else
			isInZone = false
			jobStatus = '~y~Go to your assigned zone!' .. assignedZone.name
			notifyPlayer(jobStatus) -- Notify Player
			removeZoneObjects() -- clear task objects from the zone
			notifyPlayer(jobStatus) -- Notify Player
		end
	end
end

-- Called when player enters a job zone that needs to generate additional task objects
function createZoneObjects()
	if assignedZone then
		if not assignedZone.objectsSpawned then
			for i, obj in pairs(assignedZone.objects) do
				local unused, objZ = GetGroundZFor_3dCoord(obj.coords["x"], obj.coords["y"], 99999.0, 1)
				obj.object = CreateObject(GetHashKey(obj.prop), obj.coords["x"], obj.coords["y"], objZ - 0.2, false, true, false)
				FreezeEntityPosition(obj.object, true)
			end
			assignedZone.objectsSpawned = true
		else
			print('Objects have already been spawned!')
		end
	else
		print('No zone assigned!')
	end
end

-- Used to remove task objects when the player leaves the zone
function removeZoneObjects()
	if assignedZone then
		if assignedZone.objectsSpawned then
			for i, obj in pairs(assignedZone.objects) do
				if obj.object ~= nil then
					DetachEntity(obj.object, 1, true)
					DeleteEntity(obj.object)
					DeleteObject(obj.object)
					obj.object = nil
				end
			end
			assignedZone.objectsSpawned = false
		else
			print('No objects to remove!')
		end
	else
		print('No zone assigned!')
	end
end