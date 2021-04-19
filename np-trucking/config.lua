Config = {}

Config.enabled = true -- show message
Config.jobName = 'Trucking'
Config.initMessage = 'Loading: Trucking' -- (string) text to print

-- Set required items for player to complete job tasks
Config.requireMultipleItems = false -- (boolean) does this job require multiple items?
if Config.requireMultipleItems do
	-- NOTE: REPLACE ITEM NAMES BELOW WITH PROPER NP ITEM NAMES
	Config.requiredItems = {
		'crowbar',
		'hammer',
		'heavydrill',
		'pickaxe',
		'heavyboltcutter'
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

-- Custom Function to generate activityLimit for each zone
Config.getActivityLimit = function()
	if Config.useRandActivityLimit do
		Config.activityLimit = random(Config.minActivityLimit, Config.maxActivityLimit) -- (integer) set random activityLimit between Config.minActivityLimit & Config.maxActivityLimit
	else
		Config.activityLimit = Config.minActivityLimit -- (integer) uses the minActivityLimit param above
	end
end

-- Job related zones
Config.zones = {
	{
		id = 'zone_1',
		zoneSize = 50,
		coords = vector3(0.0, 0.0, 0.0),
		activityLimit = Config.getActivityLimit(),
		activities = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
		},
	},
	{
		id = 'zone_2',
		zoneSize = 50,
		coords = vector3(0.0, 0.0, 0.0),
		activityLimit = Config.getActivityLimit(),
		activities = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
		},
	},
	{
		id = 'zone_3',
		zoneSize = 50,
		coords = vector3(0.0, 0.0, 0.0),
		activityLimit = Config.getActivityLimit(),
		activities = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
		},
	},
	{
		id = 'zone_4',
		zoneSize = 50,
		coords = vector3(0.0, 0.0, 0.0),
		activityLimit = Config.getActivityLimit(),
		activities = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
		},
	},
} 

--custonm print function
Config.print = function(text) 
	print("^3CONFIG^7", text)
end