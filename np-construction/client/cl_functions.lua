local tool = nil

function givePlayerHammer(ped)
	tool = CreateObject(GetHashKey("prop_tool_hammer"), 0, 0, 0, true, true, true) 
	AttachEntityToEntity(tool, ped, GetPedBoneIndex(ped, 28422), 0.0, -0.06, -0.04, -102.0, 177.0, -12.0, true, true, false, true, false, true)
end

function givePlayerHandSaw(ped)
	tool = CreateObject(GetHashKey("prop_tool_consaw"), 0, 0, 0, true, true, true) 
	AttachEntityToEntity(tool, ped, GetPedBoneIndex(ped, 28422), 0.0, -0.06, -0.04, -102.0, 177.0, -12.0, true, true, false, true, false, true)
end

function givePlayerBroom(ped)
	tool = CreateObject(GetHashKey("prop_tool_broom"), 0, 0, 0, true, true, true) 
	AttachEntityToEntity(tool, ped, GetPedBoneIndex(ped, 28422), 0.0, -0.06, -0.04, -102.0, 177.0, -12.0, true, true, false, true, false, true)
end

function givePlayerTorch(ped)
	tool = CreateObject(GetHashKey("prop_tool_blowtorch"), 0, 0, 0, true, true, true) 
	AttachEntityToEntity(tool, ped, GetPedBoneIndex(ped, 28422), 0.0, -0.06, -0.04, -102.0, 177.0, -12.0, true, true, false, true, false, true)
end

function givePlayerDrill(ped)
	tool = CreateObject(GetHashKey("prop_tool_drill"), 0, 0, 0, true, true, true) 
	AttachEntityToEntity(tool, ped, GetPedBoneIndex(ped, 28422), 0.0, -0.06, -0.04, -102.0, 177.0, -12.0, true, true, false, true, false, true)
end

function givePlayerNailgun(ped)
	tool = CreateObject(GetHashKey("prop_tool_nailgun"), 0, 0, 0, true, true, true) 
	AttachEntityToEntity(tool, ped, GetPedBoneIndex(ped, 28422), 0.0, -0.06, -0.04, -102.0, 177.0, -12.0, true, true, false, true, false, true)
end

function givePlayerJackhammer(ped)
	tool = CreateObject(GetHashKey("prop_tool_jackham"), 0, 0, 0, true, true, true) 
	AttachEntityToEntity(tool, ped, GetPedBoneIndex(ped, 28422), 0.0, -0.06, -0.04, -102.0, 177.0, -12.0, true, true, false, true, false, true)
end

function givePlayerPliers(ped)
	tool = CreateObject(GetHashKey("prop_tool_pliers"), 0, 0, 0, true, true, true) 
	AttachEntityToEntity(tool, ped, GetPedBoneIndex(ped, 28422), 0.0, -0.06, -0.04, -102.0, 177.0, -12.0, true, true, false, true, false, true)
end

function givePlayerPickaxe(ped)
	tool = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true) 
	AttachEntityToEntity(tool, ped, GetPedBoneIndex(ped, 28422), 0.0, -0.06, -0.04, -102.0, 177.0, -12.0, true, true, false, true, false, true)
end

function createZone(zone)
	local area = nil

	if zone.type == 'circle' then
		area = CircleZone:Create(zone.coords, zone.radius, {
			name = zone.id,
			debugPoly = zone.debug,
		})
	elseif zone.type == 'box' then
		area = BoxZone:Create(zone.coords, zone.length, zone.width, {
			name = zone.id,
			heading = zone.heading,
			debugPoly = zone.debug,
			minZ = zone.minZ,
			maxZ = zone.maxZ
		})
	elseif zone.type == 'poly' then
		area = PolyZone:Create(zone.coords, {
			name = zone.id,
			--minZ = 22.859148025513,
			--maxZ = 29.39026260376
		})
	elseif zone.type == 'combo' then
		-- TODO: create combo box
	else
		-- TODO: throw error for invalid types & get new zone?
		print('^3ERROR:^7 Invalid zone type specified in the config!')
	end

	return area
end