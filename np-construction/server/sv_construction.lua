if Config.enabled then
	Config.print(Config.initMessage)
end

local playersTasksTotal = {}
local playersZonesCompleted = {}

AddEventHandler("playerDropped", function()
	for _, zone in pairs(Config.zones) do
		for _, task in pairs(zone.tasks) do
			if task.beingUsedBy == source and not constructed then
				task.isBeingUsed = false
				-- task.isUsed = false
				task.beingUsedBy = nil
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
	if playersZonesCompleted[source] ~= nil and #playersZonesCompleted[source] >= Config.zoneLimit then
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

-- Called when player tries to do a task
RegisterServerEvent("np-construction:attemptTask")
AddEventHandler("np-construction:attemptTask", function(assignedZone, attemptedTask)
	-- Look for which zone they are in
	for _, zone in pairs(Config.zones) do
		for _, task in pairs(zone.tasks) do

			if task.id == attemptedTask.id then
				if task.isUsed then
					return print("Task has already been completed") -- Notify User with UI
				end

				if task.isBeingUsed then
					return print("Object is currently being used") -- Notify User with UI
				end

				if zone.id == assignedZone.id then
					-- If the user doesnt exist in table create one with default number of mines set to 0
					if playersTasksTotal[source] == nil then
						print("im nil so should be logging")
						playersTasksTotal[source] = { zone = assignedZone.id, amount = 0 }
					end

					if playersTasksTotal[source].zone == zone.id then
						if playersTasksTotal[source].amount >= zone.taskLimit then
							return print("You can no longer mine in this zone for now. " .. playersTasksTotal[source].zone)
						else
							playersTasksTotal[source].amount = playersTasksTotal[source].amount + 1
							print("Starting task " .. playersTasksTotal[source].amount)
							task.isBeingUsed = true
							task.beingUsedBy = source
							TriggerClientEvent("np-construction:beginTask", source, zone, task, Config.requiredHits, source)
							return
						end
					end
				end
			end
		end
	end
end)

-- Called when player is done with task
RegisterServerEvent("np-construction:completedTask")
AddEventHandler("np-construction:completedTask", function(assignedZone, attemptedTask, source)
	Citizen.CreateThread(function()
		for _, zone in pairs(Config.zones) do
			if assignedZone.id == zone.id then
				for _, task in pairs(zone.tasks) do
					if task.id == attemptedTask.id then
						task.isBeingUsed = false
						task.isUsed = true
						-- tell client the task is complete
						TriggerClientEvent("np-construction:completeTask", source, zone, task)
						-- Player completed enough tasks here needs to go to another zone
						if playersTasksTotal[source].zone == zone.id and playersTasksTotal[source].amount >= zone.taskLimit then
							if (playersZonesCompleted[source] == nil) then
								playersZonesCompleted[source] = {}
							end

							table.insert(playersZonesCompleted[source], assignedZone.id)

							print("Player is done in this zone move on. " .. playersZonesCompleted[source][1]) -- Notify User with UI
							TriggerClientEvent("np-construction:clearAssignedZone", source)
						elseif playersTasksTotal[source].zone == zone.id and playersTasksTotal[source].amount < zone.taskLimit then
							print('Task ' .. playersTasksTotal[source].amount .. '/' .. zone.taskLimit .. ' Completed')
						end
					end
				end
			end
		end
	end)
end)

-- Called when the player completed their assigned amount of zones
RegisterServerEvent("np-construction:completeRun")
AddEventHandler("np-construction:completeRun", function(src)
	local rewards = nil

	playersTasksTotal[src] = nil -- Remove how many tasks they completed
	playersZonesCompleted[src] = nil -- Remove them from zones completed so when they strart the job again after a "cooldown" its back to default
	
	-- Get rewards based on config values
	rewards = Config.getRewards()
	if rewards.cash ~= nil then
		-- TODO: replace with proper export to add cash to paystub at the foreman
		exports["np-activities"]:addCashToPaySlip(playerServerId, rewards.cash)
	end

	for _, item in pairs(rewards.items) do
		if Config.useNoPixelExports then
			exports["np-activities"]:giveInventoryItem(playerServerId, item.id, item.amount)
		else
			exports.functions:sendNotification('~y~Paid - ' .. item.amount .. item.id, playerServerId, Config.useNoPixelExports)
			print('~y~Paid - ' .. item.amount .. item.id) -- NOTE: Used for Debugging, comment out in production
		end
	end
	
	TriggerClientEvent("np-construction:stopConstruction", true) -- Now lets tell client theyre not assigned a job and reset their variables
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