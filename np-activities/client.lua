PlayerIsWorkingActivity = false
PlayerCurrentActivity = nil
PlayerCurrentTimeToComplete = 0

PlayerIsWorkingTask = false
PlayerCurrentTaskName = nil
PlayercurrentTaskDescription = nil

-- Track basic inventory
PlayerInventory = {}

-- Call this before starting the activity on the client to ensure they can start.
-- returns bool
function canDoActivity(activityName, playerServerId)
	return not PlayerIsWorkingActivity
end

-- Call this when activity in progress
-- returns bool
function activityInProgress(activityName, playerServerId, timeToComplete)
	PlayerIsWorkingActivity = true
	PlayerCurrentActivity = activityName
	PlayerCurrentTimeToComplete = timeToComplete

	notifyPlayer(playerServerId, "[ACTIVITY] Started activity " .. activityName .. " for server Id " .. playerServerId .. " with time limit " .. timeToComplete)
end

-- Call this when an activity completes, fails, or is abandoned
-- returns void
function activityCompleted(activityName, playerServerId, success, reason)
	PlayerIsWorkingActivity = false
	PlayerCurrentActivity = nil

	notifyPlayer(
		playerServerId,
		"[ACTIVITY] Completed activity " ..
			activityName ..
				" for server Id " .. playerServerId .. " with success " .. tostring(success) .. " and reason " .. reason
	)
end

-- Call this before starting the task
-- returns bool
function canDoTask(activityName, playerServerId, taskName)
	return not PlayerIsWorkingTask and PlayerCurrentActivity == activityName
end

-- Call this when a task is in progress
-- returns void
function taskInProgress(activityName, playerServerId, taskName, taskDescription)
	PlayerIsWorkingTask = true
	PlayerCurrentTaskName = taskName
	PlayercurrentTaskDescription = taskDescription

	notifyPlayer(
		playerServerId,
		"[TASK] Started task " ..
			activityName ..
				":" ..
					taskName ..
						" for server Id " .. playerServerId .. " with taskName " .. taskName .. " and taskDescription " .. taskDescription
	)
end

-- Call this when a task is completed, failed, or abandoned
-- returns void
function taskCompleted(activityName, playerServerId, taskName, success, reason)
	PlayerIsWorkingTask = false
	PlayerCurrentTaskName = nil
	PlayercurrentTaskDescription = nil

	notifyPlayer(
		playerServerId,
		"[TASK] Completed task " ..
			activityName ..
				":" ..
					taskName ..
						" for server Id " .. playerServerId .. " with success " .. tostring(success) .. " and reason " .. reason
	)
end

-- Call this to check if they have something in their inventory required for task
-- returns bool
function hasInventoryItem(playerServerId, name)
	for i = 1, #PlayerInventory do
		if (PlayerInventory[i]["Name"] == name) then
			return PlayerInventory[i]["Quantity"] > 0
		end
	end

	return false
end

-- Call this to give a player an inventory item
-- returns void,
function giveInventoryItem(playerServerId, name, quantity)
	notifyPlayer(playerServerId, "[INV] Added " .. quantity .. " of " .. name .. " to inventory.")

	for i = 1, #PlayerInventory do
		if (PlayerInventory[i]["Name"] == name) then
			PlayerInventory[i]["Quantity"] = PlayerInventory[i]["Quantity"] + 1
			return
		end
	end

	PlayerInventory[#PlayerInventory + 1] = {
		["Name"] = name,
		["Quantity"] = quantity
	}
end

-- Call this to remove a player an inventory item
-- returns void
function removeInventoryItem(playerServerId, name, quantity)
	for i = 1, #PlayerInventory do
		if (PlayerInventory[i]["Name"] == name) then
			PlayerInventory[i]["Quantity"] = PlayerInventory[i]["Quantity"] - quantity

			notifyPlayer(playerServerId, "[INV] Removed " .. quantity .. " of " .. name .. " from inventory.")
			return
		end
	end
end

-- Call this to notify the player of something
-- returns void
function notifyPlayer(playerServerId, message)
	TriggerEvent(
		"chat:addMessage",
		{
			color = {0, 255, 0},
			multiline = true,
			args = {"NoPixel", message}
		}
	)
end
