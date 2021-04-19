Config = {}

Config.enabled = true -- show message
Config.jobName = 'Slaughterhouse'
Config.initMessage = 'Loading: Slaughterhouse' -- (string) text to print

-- Set required items for player to complete job tasks
Config.requireMultipleItems = false -- (boolean) does this job require multiple items?
if Config.requireMultipleItems do
	-- NOTE: REPLACE ITEM NAMES BELOW WITH PROPER NP ITEM NAMES
	Config.requiredItems = {
		'hatchet',
		'hunting_knife',
	}
else
	Config.requiredItems = {
		'hunting_knife'
	}
end

--
-- Variables
--
Config.maxGroupSize = 4 -- (integer) Maximum players allowed in the job center group for this job
Config.zoneLimit = 1 -- (integer) Number of zones to complete before the "task" is flagged as "completed"
Config.useRandActivityLimit = false -- (boolean) Use a ranom activity limit at each job site?
Config.minActivityLimit = 1 -- (integer) Minimum number of activities required to complete a zone || NOTE: if useRandActivityLimit = false, this value becomes the default activityLimit for each zone
Config.maxActivityLimit = 1 -- (integer) Maximum number of activities required to complete a zone

-- Custom Function to generate activityLimit for each zone
Config.getActivityLimit = function()
	if Config.useRandActivityLimit do
		Config.activityLimit = random(Config.minActivityLimit, Config.maxActivityLimit) -- (integer) set random activityLimit between Config.minActivityLimit & Config.maxActivityLimit
	else
		Config.activityLimit = Config.minActivityLimit -- (integer) uses the minActivityLimit param above
	end
end

--
-- Zones
--

-- Task 0 : Job Pickup & Drop-off
Config.foreman = {
	id = 'foreman',
	zoneSize = 25,
	object = nil,
	coords = vector3(0.0, 0.0, 0.0),
	activities = {
		{ id = 'get_truck', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
		{ id = 'return_truck', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	},
}
-- Task 1 : Animal Collection
Config.farms = {
	{
		id = 'farm_1',
		zoneSize = 50,
		zoneType = 'farm',
		coords = vector3(0.0, 0.0, 0.0),
		activityLimit = Config.getActivityLimit(),
		activities = {
			{ id = 'catch_chickens', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'cluck_n_bell', activityId = 'butcher_chickens' },
			{ id = 'catch_pigs', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'slaughter_house', activityId = 'butcher_pigs' },
			{ id = 'catch_cows', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'slaughter_house', activityId = 'butcher_cows' },
		},
	},
	{
		id = 'farm_2',
		zoneSize = 50,
		zoneType = 'farm',
		coords = vector3(0.0, 0.0, 0.0),
		activityLimit = Config.getActivityLimit(),
		activities = {
			{ id = 'catch_chickens', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'cluck_n_bell', activityId = 'butcher_chickens' },
			{ id = 'catch_pigs', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'slaughter_house', activityId = 'butcher_pigs' },
			{ id = 'catch_cows', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'slaughter_house', activityId = 'butcher_cows' },
		},
	},
	{
		id = 'farm_3',
		zoneSize = 50,
		zoneType = 'farm',
		coords = vector3(0.0, 0.0, 0.0),
		activityLimit = Config.getActivityLimit(),
		activities = {
			{ id = 'catch_chickens', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'cluck_n_bell', activityId = 'butcher_chickens' },
			{ id = 'catch_pigs', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'slaughter_house', activityId = 'butcher_pigs' },
			{ id = 'catch_cows', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'slaughter_house', activityId = 'butcher_cows' },
		},
	},
	{
		id = 'farm_4',
		zoneSize = 50,
		zoneType = 'farm',
		coords = vector3(0.0, 0.0, 0.0),
		activityLimit = Config.getActivityLimit(),
		activities = {
			{ id = 'catch_chickens', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'cluck_n_bell', activityId = 'butcher_chickens' },
			{ id = 'catch_pigs', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'slaughter_house', activityId = 'butcher_pigs' },
			{ id = 'catch_cows', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'slaughter_house', activityId = 'butcher_cows' },
		},
	}
} 
-- Task 2 : Animal Butchering
Config.butchers = {
	{
		id = 'slaughter_house',
		zoneSize = 25,
		zoneType = 'butcher',
		coords = vector3(0.0, 0.0, 0.0),
		activityLimit = Config.getActivityLimit(),
		activities = {
			{ id = 'butcher_pigs', object = nil, coords = vector3(0.0, 0.0, 0.0) },
			{ id = 'butcher_cows', object = nil, coords = vector3(0.0, 0.0, 0.0) },
		},
	},
	{
		id = 'cluck_n_bell',
		zoneSize = 25,
		zoneType = 'butcher',
		coords = vector3(0.0, 0.0, 0.0),
		activityLimit = Config.getActivityLimit(),
		activities = {
			{ id = 'butcher_chickens', object = nil, coords = vector3(0.0, 0.0, 0.0) },
		},
	}
} 

--custonm print function
Config.print = function(text) 
	print("^3CONFIG^7", text)
end