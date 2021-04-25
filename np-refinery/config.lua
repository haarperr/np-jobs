Config = {}

Config.enabled = true -- show message
Config.actviityName = 'activity_refinery'
Config.jobName = 'Refinery'
Config.initMessage = 'Loading: Oil & Gas Refinery' -- (string) text to print

-- Enable NoPixel Exports
Config.useNoPixelExports = false

-- Set required items for player to complete job tasks
Config.requireMultipleItems = false -- (boolean) does this job require multiple items?
if Config.requireMultipleItems then
	-- NOTE: REPLACE ITEM NAMES BELOW WITH PROPER NP ITEM NAMES
	Config.requiredItems = {
		'crowbar',
		'hammer',
	}
else
	Config.requiredItems = {
		'toolbelt'
	}
end

--
-- Variables
--
Config.maxGroupSize = 2 -- (integer) Maximum players allowed in the job center group for this job
Config.zoneLimit = 2 -- (integer) Number of zones to complete before the "task" is flagged as "completed"
Config.useRandTaskLimit = true -- (boolean) Use a ranom task limit at each job site?
Config.minTaskLimit = 2 -- (integer) Minimum number of tasks required to complete a zone || NOTE: if useRandTaskLimit = false, this value becomes the default taskLimit for each zone
Config.maxTaskLimit = 5 -- (integer) Maximum number of tasks required to complete a zone
Config.payment = { -- job completion payment settings
	cash = {
		minPayment = 100, -- (integer) min amount of cash the job can pay out to each player
		maxPayment = 200, -- (integer) max amount of cash the job can pay out to each player
	},
	material = {
		minPayment = 30, -- (integer) min amount of material items the job can pay out to each player
		maxPayment = 60, -- (integer) max amount of material items the job can pay out to each player
	},
}

-- Custom Function to generate taskLimit for each zone
Config.getTaskLimit = function()
	if Config.useRandTaskLimit then
		Config.taskLimit = math.random(Config.minTaskLimit, Config.maxTaskLimit) -- (integer) set random taskLimit between Config.minTaskLimit & Config.maxTaskLimit
	else
		Config.taskLimit = Config.minTaskLimit -- (integer) uses the minTaskLimit param above
	end
end

---
-- Polyzones
---

-- debug options
Config.debugZones = true

-- Task 0 : Job Pickup & Drop-off
Config.foreman = {
	id = 'foreman',
	name = 'Foreman',
	active = true,
	type = 'circle',
	radius = 25,
	object = nil,
	coords = vector3(0.0, 0.0, 0.0),
	-- activities = {
	-- 	{ id = 'get_truck', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 	{ id = 'return_truck', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- },
}

-- Task 1 : Job Sites
Config.zones = {
	{
		id = 'zone_1',
		name = 'Zone #1',
		active = true,
		type = 'box',
		length = 20,
		width = 20,
		coords = vector3(0.0, 0.0, 0.0),
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
		blip = {
			icon = 0,
			coords = vector3(0.0, 0.0, 0.0),
		},
	},
	{
		id = 'zone_2',
		name = 'Zone #2',
		active = true,
		type = 'box',
		length = 20,
		width = 20,
		coords = vector3(0.0, 0.0, 0.0),
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
		blip = {
			icon = 0,
			coords = vector3(0.0, 0.0, 0.0),
		},
	},
	{
		id = 'zone_3',
		name = 'Zone #3',
		active = true,
		type = 'box',
		length = 20,
		width = 20,
		coords = vector3(0.0, 0.0, 0.0),
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
		blip = {
			icon = 0,
			coords = vector3(0.0, 0.0, 0.0),
		},
	},
	{
		id = 'zone4',
		name = 'Zone #4',
		active = true,
		type = 'poly',
		minZ = 41.063034057617,
		maxZ = 45.24654006958,
		coords = {
			vector2(196.32427978516, -355.64190673828),
			vector2(222.59237670898, -364.03707885742),
			vector2(242.06045532227, -370.16152954102),
			vector2(266.81866455078, -379.05453491211)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
		blip = {
			icon = 0,
			coords = vector3(0.0, 0.0, 0.0),
		},
	}
} 

-- Task 2 : Return Calibration Notes To the Foreman 

--custonm print function
Config.print = function(text) 
	print("^3JOBS^7", text)
end