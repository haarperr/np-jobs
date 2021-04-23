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
	print("Checking if any activities need to be reset...")
	for _, zone in pairs(Config.zones) do
		for _, task in pairs(zone.tasks) do
			if not task.isBeingConstructed and task.isConstructed then
				task.isConstructed = false
				task.beingConstructedBy = nil
			end
		end
	end
end