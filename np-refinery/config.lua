Config = {}

Config.enabled = true -- show message
Config.jobName = 'Refinery'
Config.initMessage = 'Loading: Oil & Gas Refinery' -- (string) text to print

-- Set required items for player to complete job tasks
Config.requireMultipleItems = false -- (boolean) does this job require multiple items?
if Config.requireMultipleItems do
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
Config.useRandActivityLimit = true -- (boolean) Use a ranom activity limit at each job site?
Config.minActivityLimit = 2 -- (integer) Minimum number of activities required to complete a zone || NOTE: if useRandActivityLimit = false, this value becomes the default activityLimit for each zone
Config.maxActivityLimit = 5 -- (integer) Maximum number of activities required to complete a zone
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

-- Custom Function to generate activityLimit for each zone
Config.getActivityLimit = function()
	if Config.useRandActivityLimit do
		Config.activityLimit = random(Config.minActivityLimit, Config.maxActivityLimit) -- (integer) set random activityLimit between Config.minActivityLimit & Config.maxActivityLimit
	else
		Config.activityLimit = Config.minActivityLimit -- (integer) uses the minActivityLimit param defined above
	end
end

--
-- Zones
--

-- Task 0 : Job Pickup & Drop-off
Config.foreman = {
	id = 'foreman',
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
		type = 'box',
		length = 20,
		width = 20,
		coords = vector3(0.0, 0.0, 0.0),
		activityLimit = Config.getActivityLimit(),
		activities = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'zone_2',
		type = 'box',
		length = 20,
		width = 20,
		coords = vector3(0.0, 0.0, 0.0),
		activityLimit = Config.getActivityLimit(),
		activities = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'zone_3',
		type = 'box',
		length = 20,
		width = 20,
		coords = vector3(0.0, 0.0, 0.0),
		activityLimit = Config.getActivityLimit(),
		activities = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'zone4',
		type = 'poly',
		minZ = 41.063034057617,
		maxZ = 45.24654006958,
		coords = {
			vector2(196.32427978516, -355.64190673828),
			vector2(222.59237670898, -364.03707885742),
			vector2(242.06045532227, -370.16152954102),
			vector2(266.81866455078, -379.05453491211)
		},
		activityLimit = Config.getActivityLimit(),
		activities = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	}
} 

-- Task 2 : Return Calibration Notes To the Foreman 

--custonm print function
Config.print = function(text) 
	print("^3CONFIG^7", text)
end