local hammer = nil

function givePlayerHammer(ped)
	hammer = CreateObject(GetHashKey("prop_tool_hammer"), 0, 0, 0, true, true, true) 
	AttachEntityToEntity(hammer, ped, GetPedBoneIndex(ped, 28422), 0.0, -0.06, -0.04, -102.0, 177.0, -12.0, true, true, false, true, false, true)
end
