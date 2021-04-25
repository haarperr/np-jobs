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

-- Called when player tries to do a task
RegisterServerEvent("np-construction:attemptTask")
AddEventHandler("np-construction:attemptTask", function(assignedZone, attemptedTask)

	-- Look for which zone theyre in
	for _, zone in pairs(Config.zones) do
		for _, task in pairs(zone.tasks) do

			if task.id == attemptedTask.id then
				if task.isUsed then
					return print("Task has already been completed") -- Notify User with UI
				end

				if task.isBeingUsed then
					return print("Rock is currently being used") -- Notify User with UI
				end

				if zone.id == assignedZone.id then
					-- If the user doesnt exist in table create one with default number of mines set to 0
					if playersTasksTotal[source] == nil then
						print("im nil so should be logging")
						playersTasksTotal[source] = { zone = assignedZone.id, amount = 0 }
					end

					if playersTasksTotal[source].zone == zone.id then
						if playersTasksTotal[source].amount >= zone.maxMineAmount then
							return print("You can no longer mine in this zone for now. " .. playersTasksTotal[source].zone)
						else
							playersTasksTotal[source].amount = playersTasksTotal[source].amount + 1
							print("Starting task " .. playersTasksTotal[source].amount)
							rock.isBeingUsed = true
							rock.beingUsedBy = source
							TriggerClientEvent("np-construction:beginTask", source, zone, task, Config.requiredRockHits, source)
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
			
						-- Figure out what they got (Could either do check here or give them just a rock and when they go to NPC it chooses randomly there.)
						-- local chance = math.random(0, 100)
						-- if chance < 50 then
						-- 	TriggerClientEvent("np-construction:collectRock", source, zone, rock, "gem") -- Notify User with UI
						-- else
						-- 	TriggerClientEvent("np-construction:collectRock", source, zone, rock, "rock") -- Notify User with UI
						-- end

						TriggerClientEvent("np-construction:collectRock", source, zone, task, "rock")
	
						-- Player completed enough tasks here needs to go to another zone
						if playersTasksTotal[source].zone == zone.id and playersTasksTotal[source].amount >= zone.maxMineAmount then
							-- Todo

							if (playersZonesCompleted[source] == nil) then
								playersZonesCompleted[source] = {}
							end

							table.insert(playersZonesCompleted[source], assignedZone.id)

							print("Player is done in this zone move on. " .. playersZonesCompleted[source][1]) -- Notify User with UI
							TriggerClientEvent("np-construction:unassignZone", source)
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