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

function removePlayerTool()
	DetachEntity(tool, 1, true)
	DeleteEntity(tool)
	DeleteObject(tool)
end

-- Used to create PolyZones of all types
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
		-- do nothing
		print('^3ERROR:^7 Invalid zone type specified in the construction config!')
	end

	return area
end

-- Called when a task is started and an animation is needed
function startTaskAnimation(zone, ped, task, requiredHits, source)
	local hitsDone = 0
	local hitsRequired = requiredHits
  
	Citizen.CreateThread(function()
		while hitsDone < hitsRequired do
			Citizen.Wait(1)
	
			-- Lets request animation dict first
			RequestAnimDict("anim@heists@box_carry@")
			RequestAnimDict("melee@large_wpn@streamed_core")
	
			while not HasAnimDictLoaded("melee@large_wpn@streamed_core") and not HasAnimDictLoaded("anim@heists@box_carry@") do
				Citizen.Wait(1)
			end
			
			TaskPlayAnim(ped, "melee@large_wpn@streamed_core", "ground_attack_on_spot", 8.0, 8.0, -1, 80, 0, 0, 0, 0)
	
			
			-- Just started animation so give the player the tool
			if hitsDone == 0 then
				-- TODO: Check task and get proper tool based on task???
				givePlayerPickaxe(ped)
			end
	
			Citizen.Wait(2500)
			ClearPedTasks(ped)
			hitsDone = hitsDone + 1
	
			if hitsDone >= requiredHits then
				removePlayerTool()
				Citizen.Wait(250)
				TriggerServerEvent("np-construction:completedTask", zone, task, source)
				break
			end  
		end
	end)
end

-- Create notification for the player
function notifyPlayer(message)
	local playerServerId = GetPlayerServerId(PlayerId())

	if message ~= nil then
		if Config.useNoPixelExports then
			exports["np-activities"]:notifyPlayer(playerServerId, message)
		else
			SetNotificationTextEntry("STRING")
			AddTextComponentString(message)
			DrawNotification(true, false)
		end
	else
		return print('nil message found! skipping notification...')
	end
end
