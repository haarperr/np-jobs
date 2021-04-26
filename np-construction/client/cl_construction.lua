local assignedZone = nil
local isInZone = false
local constructionStatus = 'Waiting to be assigned a job...'
local isCurrentlyConstructing = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		-- For debug only
		if isInZone and assignedZone then
			if IsControlJustPressed(1, 86) then  -- is 'E' pressed?
				attemptTask() -- This can be changed to an event handler so if you want to call it when you use an item
			end
		end
		exports.functions:showText(constructionStatus)
	end
end)

function attemptTask()
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
		print('Task Object:' .. taskObj .. ' || Object Model' .. model) -- for debug only || NOTE: comment out for production
		for _, task in pairs(assignedZone.tasks) do
			if task.model == model then
				TriggerServerEvent("np-construction:attemptTask", assignedZone, task)
			end
		end
	else
		sendNotification("You don't have the item to do this task.", playerServerId)
	end
end

-- Called when the player gets assigned to a zone
RegisterNetEvent("np-construction:assignedZone")
AddEventHandler("np-construction:assignedZone", function(zone)
	local playerServerId = GetPlayerServerId(PlayerId())

	-- TODO: Replace this with a function to generate all types of zones based on the zoneType ('box', 'circle', 'poly')
	zone.area = createZone(zone)
	if zone.area ~= nil then
		zone.area:onPlayerInOut(handlePlayerEnteringZone)

		assignedZone = zone
		constructionStatus = "Assigned to zone - " .. zone.name
		exports.functions:sendNotification('~g~You have been assigned to a new zone ' .. zone.name, playerServerId, Config.useNoPixelExports)

		if Config.useNopixelExports then
			exports["np-activities"]:activityInProgress(Config.activityName, playerServerId, Config.timeToComplete)
		else
			exports.functions:sendNotification("~g~Activity in progress", playerServerId, Config.useNoPixelExports)
		end
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

-- Called when we are interacting with a valid task model
RegisterNetEvent("np-construction:beginTask")
AddEventHandler("np-construction:beginTask", function(zone, task, requiredHits, source)
	local playerServerId = GetPlayerServerId(PlayerId())

	isCurrentlyConstructing = true

	print('^6BEGIN: ' .. task.id)
	if Config.useNoPixelExports then
		exports["np-activities"]:taskInProgress(Config.activityName, playerServerId, 'started_task_' .. task.id, 'Started Task...')
	else
		exports.functions:sendNotification('~g~started_task_'..task.id, playerServerId, Config.useNoPixelExports)
	end

	-- TODO: Check task and get proper animation based on object model being interacted with???
	startTaskAnimation(zone, GetPlayerPed(-1), task, requiredHits, source)
end)

-- Called when we are done with a task
RegisterNetEvent("np-construction:completeTask")
AddEventHandler("np-construction:completeTask", function(zone, task, reward)
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
			generateTaskObjs(assignedZone.tasks, assignedZone.prop)
			isInZone = true
			constructionStatus = 'Complete tasks!'
		else
			print('player exited zone')
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