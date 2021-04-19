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


function resetZoneActivities()
	print("Checking if any activities need to be reset...")
	for _, zone in pairs(Config.zones) do
		for _, activity in pairs(zone.activities) do

			if not activity.isBeingConstructed and activity.isConstructed then
				activity.isConstructed = false
				activity.beingConstructedBy = nil
			end

		end
	end
end