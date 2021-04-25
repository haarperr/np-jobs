function ZoneConstructedRecently(targetZone, playerConstructedZones, source)
	if playerConstructedZones ~= nil then
		for _, zone in pairs(playerConstructedZones) do
			if zone == targetZone.id then
				return true
			end
		end
	else
		return false
	end

	return false
end


function resetZoneTasks()
	print('Checking if tasks need to be reset...')
	for _, zone in pairs(Config.zones) do
		for _, task in pairs(zone.tasks) do
			if not task.isBeingUsed and task.isUsed then
				task.isUsed = false
				task.beingUsedBy = nil
			end
		end
	end
end