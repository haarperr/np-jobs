Config = {}

Config.enabled = true -- (boolean) is the job enabled?
Config.activityName = 'activity_construction'
Config.jobName = 'Construction Worker'
Config.initMessage = 'Construction Loaded' -- (string) text to print

-- Enable NoPixel Exports
Config.useNoPixelExports = true

-- Set required items for player to complete job tasks
Config.requireMultipleItems = false -- (boolean) does this job require multiple items?
if Config.requireMultipleItems then
	-- NOTE: REPLACE ITEM NAMES BELOW WITH PROPER NP ITEM NAMES
	Config.requiredItems = {
		'crowbar',
		'hammer',
		'heavydrill',
		'pickaxe',
		'heavyboltcutter'
	}
else
	Config.requiredItem = 'toolbelt'
end

--
-- Variables
--
Config.useRandTimeToComplete = true -- (boolean) Use a ranom task limit at each job site?
Config.minTimeToComplete = 1800000 -- (integer) Minimum number of milliseconds the job offer is good for before expiring/failing || NOTE: 180000 = 30 minutes
Config.maxTimeToComplete = 3600000-- (integer) Maximum number of milliseconds the job offer is good for before expiring/failing || NOTE: 360000 = 60 minutes
Config.requiredHits = 3 -- (integer) Number of animation cycles required to complete the task
Config.maxGroupSize = 4 -- (integer) Maximum players allowed in the job center group for this job
Config.zoneLimit = 2 -- (integer) Number of zones to complete before the "task" is flagged as "completed"
Config.useRandTaskLimit = true -- (boolean) Use a ranom task limit at each job site?
Config.minTaskLimit = 2 -- (integer) Minimum number of tasks required to complete a zone || NOTE: if useRandTaskLimit = false, this value becomes the default taskLimit for each zone
Config.maxTaskLimit = 5 -- (integer) Maximum number of tasks required to complete a zone
Config.useRandRewards = true -- (boolean) Use a ranom payments?
Config.useRandZoneAssignmentDelay = false -- (boolean) Use a ranom zone assignment delay?
Config.minZoneAssignmentDelay = 5000 -- (integer) Minimum amount of time in ms to delay before assigning the next zone during a job
Config.maxZoneAssignmentDelay = 15000 -- (integer) Maximum amount of time in ms to delay before assigning the next zone during a job
Config.rewards = { -- Job completion payment settings
	cash = {
		min = 100, -- (integer) min amount of cash the job can pay out to each player
		max = 200, -- (integer) max amount of cash the job can pay out to each player
	},
	items = {
		{
			id = 'recycled_materials', -- (string) identifier name for material being rewarded || TODO: replace this name with proper item identifier
			min = 30, -- (integer) min amount of material items the job can pay out to each player
			max = 60, -- (integer) max amount of material items the job can pay out to each player
		},
	},
}

-- Custom Function to generate taskLimit for each zone
Config.getTaskLimit = function()
	if Config.useRandTaskLimit then
		return math.random(Config.minTaskLimit, Config.maxTaskLimit) -- (integer) set random taskLimit between Config.minTaskLimit & Config.maxTaskLimit
	else
		return Config.minTaskLimit -- (integer) uses the minTaskLimit param above
	end
end

-- Custom Function to generate timeToComplete for each zone
Config.getTimeToComplete = function()
	if Config.useRandTimeToComplete then
		Config.timeToComplete = math.random(Config.minTimeToComplete, Config.maxTimeToComplete) -- (integer) set random timeToComplete between Config.minTimeToComplete & Config.maxTimeToComplete
	else
		Config.timeToComplete = Config.minTimeToComplete -- (integer) default to minimum time to complete value
	end
end

-- Custom Fuction to generate random rewards using the Config.payment defined above
Config.getRewards = function()
	local items = Config.rewards.items
	local rewards = {}
	local cash = nil
	
	if Config.useRandRewards then	
		cash = math.random(Config.rewards.cash.min, Config.rewards.cash.max) -- (integer) set random cash payment reward based on Config.payment.cash.min & Config.payment.cash.max, 
	else
		cash = Config.rewards.cash.min
	end
	
	-- Build Rewards Table (object/array)
	rewards.cash = cash
	rewards.items = {}
	for _, item in pairs(items) do
		if Config.useRandRewards then	
			table.insert(rewards.items, { ['id'] = item.id, ['amount'] = math.random(item.min, item.max) })
		else
			table.insert(rewards.items, { ['id'] = item.id, ['amount'] = item.min })
		end
	end
	-- print(json.encode(rewards))
	return rewards
end

-- Custom Function to generate zone assignment delay for a job
Config.getZoneAssignmentDelay = function()
	if Config.useRandZoneAssignmentDelay then
		return math.random(Config.minZoneAssignmentDelay, Config.maxZoneAssignmentDelay) -- (integer) set random taskLimit between Config.minTaskLimit & Config.maxTaskLimit
	else
		return Config.minZoneAssignmentDelay -- (integer) uses the minTaskLimit param above
	end
end

---
-- Polyzones
---

-- debug options
Config.debugZones = true

-- job sites / locations
Config.zones = {
	{
		id = 'paleto_wholefoods',
		name = 'Paleto Wholefoods',
		active = true,
		type = 'box',
		heading = 44,
		length = 87,
		width = 90,
		minZ = 28.59,
		maxZ = 37.39,
		coords = vector3(74.04, 6535.2, 31.39),
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'open_cement_bags', name = 'Open Cement Bags', model = 1899123601, tool = 'prop_tool_pliers', coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'fix_generator', name = 'Fix Generator', model = -1591940045, tool = 'prop_tool_pliers', coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'fix_generator_2', name = 'Fix Generator 2', model = -57215983, tool = 'prop_tool_pliers', coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'collect_lumber', name = 'Collect Lumber', model = 1367246936, tool = 'prop_tool_consaw', coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'fix_caution_fence', name = 'Fix Caution Fence', model = 710800597, tool = 'prop_tool_hammer', coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'fix_caution_fence_2', name = 'Fix Caution Fence', model = 1469496946, tool = 'prop_tool_hammer', coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
			-- TODO: add support for polyzone based tasks for digging, hammering, sawing & cutting, etc.
		},
		blip = {
			icon = 0,
			coords = vector3(0.0, 0.0, 0.0),
		},
	},
	{
		id = 'paleto_house',
		name = 'Paleto House',
		active = true,
		type = 'box',
		heading = 45,
		length = 36.2,
		width = 45.6,
		minZ = 29.05,
		maxZ = 42.25,
		coords = vector3(-327.41, 6303.54, 35.65),
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'mix_cement', name = 'Mix Cement', model = -500221685, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'mix_cement_2', name = 'Mix Cement', model = -2113539824, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'open_cement_bags', name = 'Open Cement Bags', model = 1899123601, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'clean_potty', name = 'Clean Port-a-Potty', model = 682074297, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'collect_lumber', name = 'Collect Lumber', model = 1861370687, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'check_trash', name = 'Check Trash', model = -515278816, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
		blip = {
			icon = 0,
			coords = vector3(0.0, 0.0, 0.0),
		},
	},
	{
		id = 'paleto_house_2',
		name = 'Paleto House 2',
		active = true,
		type = 'box',
		heading = 46,
		length = 42.0,
		width = 19.2,
		minZ = 29.08,
		maxZ = 33.08,
		coords = vector3(-382.82, 6257.79, 30.08),
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'mix_cement_2', name = 'Mix Cement', model = -2113539824, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'prepare_cinder_blocks', name = 'Prepare Cinder Blocks', model = -1951226014, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'destroy_pallate', name = 'Destroy Pallate', model = 830159341, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'cut_wood', name = 'Cut Wood (2x4)', model = 31071109, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'repair_brick_wall', name = 'Repair Brick Wall', model = -1744550758, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
		blip = {
			icon = 0,
			coords = vector3(0.0, 0.0, 0.0),
		},
	},
	{
		id = 'paleto_clucking_bell',
		name = 'Paleto Clucking Bell',
		active = true,
		type = 'box',
		heading = 46,
		length = 55.0,
		width = 78.2,
		minZ = 30.2,
		maxZ = 43.4,
		coords = vector3(133.83, 6442.29, 31.2),
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'open_cement_bags', name = 'Open Cement Bags', model = 1899123601, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'prepare_cinder_blocks', name = 'Prepare Cinder Blocks', model = -1951226014, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'destroy_wood_spool', name = 'Destroy Wood Spool', model = 2111998691, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'cut_iron_beams', name = 'Cut Iron Beams', model = 1723816705, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'refuel_generator', name = 'Refuel Generator', model = -1775229459, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'refuel_generator_2', name = 'Refuel Generator', model = -57215983, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'clean_port_a_potty', name = 'Clean Port-a-Potty', model = 682074297, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
		},
		blip = {
			icon = 0,
			coords = vector3(0.0, 0.0, 0.0),
		},
	},
	-- {
	-- 	id = 'pdm_skyscraper',
	-- 	name = 'PDM Skyscraper',
	-- 	active = true,
	-- 	type = 'poly',
	-- 	-- minZ = 22.859148025513,
	-- 	-- maxZ = 29.39026260376,
	-- 	coords = {
	-- 		vector2(-81.278228759766, -1023.1381225586),
	-- 		vector2(-105.77919769287, -1085.3673095703),
	-- 		vector2(-120.01286315918, -1111.0174560547),
	-- 		vector2(-127.62714385986, -1116.4565429688),
	-- 		vector2(-155.97286987305, -1121.5473632812),
	-- 		vector2(-230.99276733398, -1121.9537353516),
	-- 		vector2(-218.39356994629, -1106.3304443359),
	-- 		vector2(-198.20851135254, -1032.4522705078),
	-- 		vector2(-187.41934204102, -1001.9202880859),
	-- 		vector2(-159.56045532227, -925.03851318359),
	-- 		vector2(-59.014083862305, -961.68048095703)
	-- 	},
	-- 	taskLimit = Config.getTaskLimit(),
	-- 	tasks = {
	-- 		{ id = 'activity_1', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'activity_2', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'activity_3', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
	-- 	},
	-- 	blip = {
	-- 		icon = 0,
	-- 		coords = vector3(0.0, 0.0, 0.0),
	-- 	},
	-- },
	-- {
	-- 	id = 'elburro_heights_house',
	-- 	name = 'El Burro Heights House',
	-- 	active = true,
	-- 	type = 'box',
	-- 	heading = 23,
	-- 	length = 62.8,
	-- 	width = 22.4,
	-- 	minZ = nil,
	-- 	maxZ = nil,
	-- 	coords = vector3(1285.75, -1765.23, 51.78),
	-- 	taskLimit = Config.getTaskLimit(),
	-- 	tasks = {
	-- 		{ id = 'activity_1', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'activity_2', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'activity_3', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
	-- 	},
	-- 	blip = {
	-- 		icon = 0,
	-- 		coords = vector3(0.0, 0.0, 0.0),
	-- 	},
	-- },
	-- {
	-- 	id = 'little_seoul',
	-- 	name = 'Little Seoul Commercial',
	-- 	active = true,
	-- 	type = 'poly',
	-- 	-- minZ = 22.699016571045,
	-- 	-- maxZ = 30.910482406616,
	-- 	coords = {
	-- 		vector2(-524.95336914062, -978.10595703125),
	-- 		vector2(-520.99920654297, -955.76379394531),
	-- 		vector2(-500.64584350586, -918.85363769531),
	-- 		vector2(-492.1330871582, -898.65637207031),
	-- 		vector2(-482.28662109375, -855.34808349609),
	-- 		vector2(-438.72537231445, -856.33697509766),
	-- 		vector2(-438.34463500977, -956.05297851562),
	-- 		vector2(-433.6826171875, -993.15985107422),
	-- 		vector2(-431.0002746582, -1035.2752685547),
	-- 		vector2(-430.97027587891, -1089.0334472656),
	-- 		vector2(-447.45275878906, -1090.7078857422),
	-- 		vector2(-485.56564331055, -1076.6322021484),
	-- 		vector2(-517.58502197266, -1058.2399902344),
	-- 		vector2(-519.61303710938, -1025.0827636719),
	-- 		vector2(-524.09155273438, -1009.9068603516)
	-- 	},
	-- 	taskLimit = Config.getTaskLimit(),
	-- 	tasks = {
	-- 		{ id = 'activity_1', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'activity_2', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'activity_3', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
	-- 	},
	-- 	blip = {
	-- 		icon = 0,
	-- 		coords = vector3(0.0, 0.0, 0.0),
	-- 	},
	-- },
	-- {
	-- 	id = 'vespucci_canals_house',
	-- 	name = 'Vespucci Canals House',
	-- 	active = true,
	-- 	type = 'poly',
	-- 	-- minZ = 2.1501624584198,
	-- 	-- maxZ = 2.8792240619659,
	-- 	coords = {
	-- 		vector2(-1122.2845458984, -938.03149414062),
	-- 		vector2(-1118.4185791016, -941.22991943359),
	-- 		vector2(-1099.5989990234, -971.35632324219),
	-- 		vector2(-1137.041015625, -993.15673828125),
	-- 		vector2(-1157.9272460938, -956.64282226562),
	-- 		vector2(-1126.6077880859, -938.63800048828)
	-- 	},
	-- 	taskLimit = Config.getTaskLimit(),
	-- 	tasks = {
	-- 		{ id = 'activity_1', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'activity_2', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'activity_3', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
	-- 	},
	-- 	blip = {
	-- 		icon = 0,
	-- 		coords = vector3(0.0, 0.0, 0.0),
	-- 	},
	-- },
	-- {
	-- 	id = 'west_vinewood_hills_house',
	-- 	name = 'West Vinewood Hills House',
	-- 	active = true,
	-- 	type = 'box',
	-- 	heading = 345,
	-- 	length = 48.0,
	-- 	width = 62.6,
	-- 	minZ = 106.45,
	-- 	maxZ = 118.25,
	-- 	coords = vector3(-2008.5, 547.96, 110.65),
	-- 	taskLimit = Config.getTaskLimit(),
	-- 	tasks = {
	-- 		{ id = 'activity_1', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'activity_2', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'activity_3', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
	-- 	},
	-- },
	-- {
	-- 	id = 'rockford_hills_house',
	-- 	name = 'Rockford Hills House',
	-- 	active = true,
	-- 	type = 'poly',
	-- 	-- minZ = 73.092056274414,
	-- 	-- maxZ = 87.158027648926,
	-- 	coords = {
	-- 		vector2(-883.5185546875, 408.04168701172),
	-- 		vector2(-895.01873779297, 403.55014038086),
	-- 		vector2(-905.26068115234, 395.27862548828),
	-- 		vector2(-912.07153320312, 383.19323730469),
	-- 		vector2(-912.78381347656, 370.26327514648),
	-- 		vector2(-930.66326904297, 375.11270141602),
	-- 		vector2(-963.36328125, 373.84426879883),
	-- 		vector2(-975.52221679688, 375.8450012207),
	-- 		vector2(-978.21978759766, 384.25064086914),
	-- 		vector2(-984.04461669922, 401.82000732422),
	-- 		vector2(-953.06231689453, 412.56884765625),
	-- 		vector2(-929.43298339844, 421.28161621094),
	-- 		vector2(-901.60186767578, 427.53674316406),
	-- 		vector2(-880.80145263672, 429.22146606445),
	-- 		vector2(-872.41302490234, 410.13565063477)
	-- 	},
	-- 	taskLimit = Config.getTaskLimit(),
	-- 	tasks = {
	-- 		{ id = 'activity_1', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'activity_2', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'activity_3', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
	-- 	},
	-- 	blip = {
	-- 		icon = 0,
	-- 		coords = vector3(0.0, 0.0, 0.0),
	-- 	},
	-- },
	-- {
	-- 	id = 'north_vinewood_house',
	-- 	name = 'North Vinewood House',
	-- 	active = true,
	-- 	type = 'poly',
	-- 	-- minZ = 143.23245239258,
	-- 	-- maxZ = 149.25944519043,
	-- 	coords = {
	-- 		vector2(-778.21942138672, 709.63452148438),
	-- 		vector2(-764.22674560547, 715.84973144531),
	-- 		vector2(-748.11505126953, 699.11395263672),
	-- 		vector2(-745.63555908203, 694.12365722656),
	-- 		vector2(-743.47613525391, 681.92547607422),
	-- 		vector2(-751.01702880859, 667.16705322266)
	-- 	},
	-- 	taskLimit = Config.getTaskLimit(),
	-- 	tasks = {
	-- 		{ id = 'activity_1', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'activity_2', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'activity_3', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
	-- 	},
	-- 	blip = {
	-- 		icon = 0,
	-- 		coords = vector3(0.0, 0.0, 0.0),
	-- 	},
	-- },
	-- {
	-- 	id = 'alta_skyscraper',
	-- 	name = 'Alta Skyscraper',
	-- 	active = true,
	-- 	type = 'poly',
	-- 	-- minZ = 36.598949432373,
	-- 	-- maxZ = 49.670181274414,
	-- 	coords = {
	-- 		vector2(41.710205078125, -307.36505126953),
	-- 		vector2(83.869720458984, -322.6711730957),
	-- 		vector2(161.31520080566, -350.31683349609),
	-- 		vector2(139.07960510254, -403.69921875),
	-- 		vector2(118.54915618896, -461.71133422852),
	-- 		vector2(87.290504455566, -468.42065429688),
	-- 		vector2(61.723293304443, -465.76559448242),
	-- 		vector2(26.724758148193, -462.30953979492),
	-- 		vector2(-9.994236946106, -454.70336914062),
	-- 		vector2(3.8176889419556, -408.51028442383),
	-- 		vector2(9.3534698486328, -388.59201049805),
	-- 		vector2(13.150959014893, -376.8776550293)
	-- 	},
	-- 	taskLimit = Config.getTaskLimit(),
	-- 	tasks = {
	-- 		{ id = 'activity_1', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'activity_2', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'activity_3', model = nil, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
	-- 	},
	-- 	blip = {
	-- 		icon = 0,
	-- 		coords = vector3(0.0, 0.0, 0.0),
	-- 	},
	-- }
} 

--Custom Print Function
Config.print = function(text) 
	print('^3JOBS^7', text)
end