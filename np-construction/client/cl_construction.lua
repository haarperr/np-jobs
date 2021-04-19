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
		showText(constructionStatus)
	end
end)

-- Called when the player gets assigned to a zone
RegisterNetEvent("np-construction:zoneAssigned")
AddEventHandler("np-construction:zoneAssigned", function(zone)
	local playerServerId = GetPlayerServerId(PlayerId())

	zone.area = CircleZone:Create(zone.coords, zone.circleSize, {
		name=zone.id,
		debugPoly=true,
	})

	zone.area:onPlayerInOut(handlePlayerEntering)

	assignedZone = zone
	constructionStatus = "Assigned to zone - " .. zone.id
	sendNotification("You have been assigned to a new zone " .. zone.id, playerServerId)

	if Config.useNopixelExports then
		exports["np-activities"]:activityInProgress("activity_construction", playerServerId)
	else
		sendNotification("Activity in progress", playerServerId)
	end
end)

-- Called when the player completes first assigned zone
RegisterNetEvent("np-construction:clearAssignedZone")
AddEventHandler("np-construction:clearAssignedZone", function(zone)
	local playerServerId = GetPlayerServerId(PlayerId())

	Citizen.CreateThread(function()
		constructionStatus = "Looking for a new zone"
		assignedZone.area:destroy()
		assignedZone = nil
		isInZone = false

		Citizen.Wait(5000)
		
		TriggerServerEvent("np-construction:assignZone")
		sendNotification("Looking for a new zone...", playerServerId)
	end)
end)

-- Called when user wants to stop construction
RegisterNetEvent("np-construction:stopConstruction")
AddEventHandler("np-construction:stopConstruction", function(zone, activity)
	local playerServerId = GetPlayerServerId(PlayerId())

	if assignedZone ~= nil then
		assignedZone.area:destroy() -- Lets delete poly zone now
	end

	assignedZone = nil
	constructionStatus = "No Activity Assigned"
	isInZone = false
	isCurrentlyConstructing = false

	if Config.useNopixelExports then
		exports["np-activities"]:activityCompleted("activity_construction", playerServerId, true, "Player either quit or completed their activity")
	else
		sendNotification("activity either completed or disbanded", playerServerId)
	end

end)