Config = {}

Config.enabled = true -- (boolean) is the job enabled?
Config.activityName = 'activity_construction'
Config.jobName = 'Construction Worker'
Config.initMessage = 'Construction Loaded' -- (string) text to print

-- Enable NoPixel Exports
Config.useNoPixelExports = false

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
Config.useRandTaskLimit = false -- (boolean) Use a ranom task limit at each job site?
Config.minTaskLimit = 2 -- (integer) Minimum number of tasks required to complete a zone || NOTE: if useRandTaskLimit = false, this value becomes the default taskLimit for each zone
Config.maxTaskLimit = 5 -- (integer) Maximum number of tasks required to complete a zone
Config.useRandZoneAssignmentDelay = false -- (boolean) Use a ranom zone assignment delay?
Config.minZoneAssignmentDelay = 5000 -- (integer) Minimum amount of time in ms to delay before assigning the next zone during a job
Config.maxZoneAssignmentDelay = 15000 -- (integer) Maximum amount of time in ms to delay before assigning the next zone during a job
Config.useRandRewards = true -- (boolean) Use a ranom payments?
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
		return math.random(Config.minTimeToComplete, Config.maxTimeToComplete) -- (integer) set random timeToComplete between Config.minTimeToComplete & Config.maxTimeToComplete
	else
		return Config.minTimeToComplete -- (integer) default to minimum time to complete value
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
			{ id = 'fix_caution_fence_2', name = 'Fix Caution Fence', model = 1469496946, tool = 'prop_tool_hammer', coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'check_blueprints', name = 'Check Blueprints', model = 904554844, tool = 'prop_tool_hammer', coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
			-- TODO: add support for polyzone based tasks for digging, hammering, sawing & cutting, etc.
		},
		objectsSpawned = false,
		objects = {
			{ prop = 'prop_tool_bench02', object = nil, model = 904554844, coords = vector3(98.11519, 6549.871, 31.67644) }, -- check_blueprints
			{ prop = 'prop_cementbags01', object = nil, model = 1899123601, coords = vector3(92.31735, 6544.2, 31.67644) }, -- open_cement_bags
			{ prop = 'prop_cons_cements01', object = nil, model = 1962326206, coords = vector3(81.55157, 6543.569, 31.67645) }, -- open_cement_bags_2
			{ prop = 'prop_cementmixer_01a', object = nil, model = -2113539824, coords = vector3(75.4737, 6537.761, 31.67645) }, -- mix_cement
			{ prop = 'prop_cementmixer_02a', object = nil, model = -500221685, coords = vector3(98.84708, 6536.671, 31.66304) }, -- mix_cement_2
			{ prop = 'prop_cablespool_01a', object = nil, model = -423137698, coords = vector3(108.1223, 6538.994, 31.66305) }, -- destroy_wood_spool_a
			{ prop = 'prop_cablespool_01b', object = nil, model = -903793390, coords = vector3(88.66129, 6495.451, 31.3701) }, -- destroy_wood_spool_b
			{ prop = 'prop_cablespool_02', object = nil, model = -1485906437, coords = vector3(99.2834, 6508.607, 31.37016) }, -- cut_tubing
			{ prop = 'prop_cablespool_03', object = nil, model = -1255376522, coords = vector3(70.29006, 6487.601, 31.37542) }, -- destroy_wood_spool_3
			{ prop = 'prop_cablespool_04', object = nil, model = 2111998691, coords = vector3(62.51626, 6488.584, 31.4565) }, -- destroy_wood_spool_4
			{ prop = 'prop_cablespool_05', object = nil, model = -1951881617, coords = vector3(61.01862, 6498.011, 31.55049) }, -- cut_cable
			{ prop = 'prop_cablespool_06', object = nil, model = -497495090, coords = vector3(45.7235, 6562.972, 31.43453) }, -- cut_cable_2
			{ prop = 'prop_conc_blocks01a', object = nil, model = -1951226014, coords = vector3(75.29274, 6590.26, 31.45163) }, -- prepare_cinder_blocks
			{ prop = 'prop_paints_bench01', object = nil, model = 2126419969, coords = vector3(82.51329, 6584.312, 31.44679) }, -- mix_paint
			{ prop = 'prop_generator_04', object = nil, model = -1001828301, coords = vector3(70.88823, 6571.704, 28.45139) }, -- fix_generator_3
			{ prop = 'prop_portaloo_01a', object = nil, model = 682074297, coords = vector3(113.096, 6519.136, 31.40958) }, -- clean_potty
			{ prop = 'prop_pallet_02a', object = nil, model = 830159341, coords = vector3(121.6373, 6529.694, 31.37017) } -- destroy_pallate
		},
		blip = {
			icon = 446,
			color = 47,
			alpha = 100,
			coords = vector3(74.22813, 6552.917, 31.4397),
		},
	},
	-- {
	-- 	id = 'paleto_house',
	-- 	name = 'Paleto House',
	-- 	active = true,
	-- 	type = 'box',
	-- 	heading = 45,
	-- 	length = 36.2,
	-- 	width = 45.6,
	-- 	minZ = 29.05,
	-- 	maxZ = 42.25,
	-- 	coords = vector3(-327.41, 6303.54, 35.65),
	-- 	taskLimit = Config.getTaskLimit(),
	-- 	tasks = {
	-- 		{ id = 'mix_cement_2', name = 'Mix Cement', model = -500221685, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'mix_cement', name = 'Mix Cement', model = -2113539824, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'open_cement_bags', name = 'Open Cement Bags', model = 1899123601, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'clean_potty', name = 'Clean Port-a-Potty', model = 682074297, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'collect_lumber', name = 'Collect Lumber', model = 1861370687, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'check_trash', name = 'Check Trash', model = -515278816, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
	-- 	},
	-- 	objectsSpawned = false,
	-- 	objects = {
	-- 		{ prop = 'prop_tool_bench02', object = nil, model = 904554844, coords = vector3(0.0, 0.0, 0.0) }, -- check_blueprints
	-- 		{ prop = 'prop_cementbags01', object = nil, model = 1899123601, coords = vector3(0.0, 0.0, 0.0) }, -- open_cement_bags
	-- 		{ prop = 'prop_cons_cements01', object = nil, model = 1962326206, coords = vector3(0.0, 0.0, 0.0) }, -- open_cement_bags_2
	-- 		{ prop = 'prop_cementmixer_01a', object = nil, model = -2113539824, coords = vector3(0.0, 0.0, 0.0) }, -- mix_cement
	-- 		{ prop = 'prop_cementmixer_02a', object = nil, model = -500221685, coords = vector3(0.0, 0.0, 0.0) }, -- mix_cement_2
	-- 		{ prop = 'prop_cablespool_01a', object = nil, model = -423137698, coords = vector3(0.0, 0.0, 0.0) }, -- destroy_wood_spool_a
	-- 		{ prop = 'prop_cablespool_01b', object = nil, model = -903793390, coords = vector3(0.0, 0.0, 0.0) }, -- destroy_wood_spool_b
	-- 		{ prop = 'prop_cablespool_02', object = nil, model = -1485906437, coords = vector3(0.0, 0.0, 0.0) }, -- cut_tubing
	-- 		{ prop = 'prop_cablespool_03', object = nil, model = -1255376522, coords = vector3(0.0, 0.0, 0.0) }, -- destroy_wood_spool_3
	-- 		{ prop = 'prop_cablespool_04', object = nil, model = 2111998691, coords = vector3(0.0, 0.0, 0.0) }, -- destroy_wood_spool_4
	-- 		{ prop = 'prop_cablespool_05', object = nil, model = -1951881617, coords = vector3(0.0, 0.0, 0.0) }, -- cut_cable
	-- 		{ prop = 'prop_cablespool_06', object = nil, model = -497495090, coords = vector3(0.0, 0.0, 0.0) }, -- cut_cable_2
	-- 		{ prop = 'prop_conc_blocks01a', object = nil, model = -1951226014, coords = vector3(0.0, 0.0, 0.0) }, -- prepare_cinder_blocks
	-- 		{ prop = 'prop_paints_bench01', object = nil, model = 2126419969, coords = vector3(0.0, 0.0, 0.0) }, -- mix_paint
	-- 		{ prop = 'prop_generator_04', object = nil, model = -1001828301, coords = vector3(0.0, 0.0, 0.0) }, -- fix_generator_3
	-- 		{ prop = 'prop_portaloo_01a', object = nil, model = 682074297, coords = vector3(0.0, 0.0, 0.0) }, -- clean_potty
	-- 		{ prop = 'prop_pallet_02a', object = nil, model = 830159341, coords = vector3(0.0, 0.0, 0.0) } -- destroy_pallate
	-- 	},
	-- 	blip = {
	-- 		icon = 446,
	-- 		color = 47,
	-- 		alpha = 90,
	-- 		coords = vector3(-319.2657, 6317.954, 31.7847),
	-- 	},
	-- },
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
			{ id = 'open_cement_bags', name = 'Open Cement Bags', model = 1899123601, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'mix_cement_2', name = 'Mix Cement', model = -2113539824, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'prepare_cinder_blocks', name = 'Prepare Cinder Blocks', model = -1951226014, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'destroy_pallate', name = 'Destroy Pallate', model = 830159341, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'cut_wood', name = 'Cut Wood (2x4)', model = 31071109, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'repair_brick_wall', name = 'Repair Brick Wall', model = -1744550758, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'check_blueprints', name = 'Check Blueprints', model = 904554844, tool = 'prop_tool_hammer', coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
		objectsSpawned = false,
		objects = {
			{ prop = 'prop_tool_bench02', object = nil, model = 904554844, coords = vector3(-364.8458, 6249.079, 31.48724) }, -- check_blueprints
			{ prop = 'prop_cementbags01', object = nil, model = 1899123601, coords = vector3(-372.2398, 6247.938, 31.48724) }, -- open_cement_bags
			-- { prop = 'prop_cons_cements01', object = nil, model = 1962326206, coords = vector3(0.0, 0.0, 0.0) }, -- open_cement_bags_2
			-- { prop = 'prop_cementmixer_01a', object = nil, model = -2113539824, coords = vector3(0.0, 0.0, 0.0) }, -- mix_cement
			-- { prop = 'prop_cementmixer_02a', object = nil, model = -500221685, coords = vector3(0.0, 0.0, 0.0) }, -- mix_cement_2
			-- { prop = 'prop_cablespool_01a', object = nil, model = -423137698, coords = vector3(0.0, 0.0, 0.0) }, -- destroy_wood_spool_a
			-- { prop = 'prop_cablespool_01b', object = nil, model = -903793390, coords = vector3(0.0, 0.0, 0.0) }, -- destroy_wood_spool_b
			-- { prop = 'prop_cablespool_02', object = nil, model = -1485906437, coords = vector3(0.0, 0.0, 0.0) }, -- cut_tubing
			-- { prop = 'prop_cablespool_03', object = nil, model = -1255376522, coords = vector3(0.0, 0.0, 0.0) }, -- destroy_wood_spool_3
			-- { prop = 'prop_cablespool_04', object = nil, model = 2111998691, coords = vector3(0.0, 0.0, 0.0) }, -- destroy_wood_spool_4
			-- { prop = 'prop_cablespool_05', object = nil, model = -1951881617, coords = vector3(0.0, 0.0, 0.0) }, -- cut_cable
			-- { prop = 'prop_cablespool_06', object = nil, model = -497495090, coords = vector3(0.0, 0.0, 0.0) }, -- cut_cable_2
			-- { prop = 'prop_conc_blocks01a', object = nil, model = -1951226014, coords = vector3(0.0, 0.0, 0.0) }, -- prepare_cinder_blocks
			-- { prop = 'prop_paints_bench01', object = nil, model = 2126419969, coords = vector3(0.0, 0.0, 0.0) }, -- mix_paint
			-- { prop = 'prop_generator_04', object = nil, model = -1001828301, coords = vector3(0.0, 0.0, 0.0) }, -- fix_generator_3
			-- { prop = 'prop_portaloo_01a', object = nil, model = 682074297, coords = vector3(0.0, 0.0, 0.0) }, -- clean_potty
			-- { prop = 'prop_pallet_02a', object = nil, model = 830159341, coords = vector3(0.0, 0.0, 0.0) } -- destroy_pallate
		},
		blip = {
			icon = 446,
			color = 47,
			alpha = 100,
			coords = vector3(-381.6368, 6265.179, 31.05582),
		},
	},
	-- {
	-- 	id = 'paleto_clucking_bell',
	-- 	name = 'Paleto Clucking Bell',
	-- 	active = true,
	-- 	type = 'box',
	-- 	heading = 46,
	-- 	length = 55.0,
	-- 	width = 78.2,
	-- 	minZ = 30.2,
	-- 	maxZ = 43.4,
	-- 	coords = vector3(133.83, 6442.29, 31.2),
	-- 	taskLimit = Config.getTaskLimit(),
	-- 	tasks = {
	-- 		{ id = 'open_cement_bags', name = 'Open Cement Bags', model = 1899123601, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'prepare_cinder_blocks', name = 'Prepare Cinder Blocks', model = -1951226014, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'destroy_wood_spool', name = 'Destroy Wood Spool', model = 2111998691, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'cut_iron_beams', name = 'Cut Iron Beams', model = 1723816705, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'refuel_generator', name = 'Refuel Generator', model = -1775229459, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'refuel_generator_2', name = 'Refuel Generator', model = -57215983, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'clean_potty', name = 'Clean Port-a-Potty', model = 682074297, tool = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'check_blueprints', name = 'Check Blueprints', model = 904554844, tool = 'prop_tool_hammer', coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
	-- 	},
	-- 	objectsSpawned = false,
	-- 	objects = {
	-- 		{ prop = 'prop_tool_bench02', object = nil, model = 904554844, coords = vector3(0.0, 0.0, 0.0) }, -- check_blueprints
	-- 		{ prop = 'prop_cementbags01', object = nil, model = 1899123601, coords = vector3(0.0, 0.0, 0.0) }, -- open_cement_bags
	-- 		{ prop = 'prop_cons_cements01', object = nil, model = 1962326206, coords = vector3(0.0, 0.0, 0.0) }, -- open_cement_bags_2
	-- 		{ prop = 'prop_cementmixer_01a', object = nil, model = -2113539824, coords = vector3(0.0, 0.0, 0.0) }, -- mix_cement
	-- 		{ prop = 'prop_cementmixer_02a', object = nil, model = -500221685, coords = vector3(0.0, 0.0, 0.0) }, -- mix_cement_2
	-- 		{ prop = 'prop_cablespool_01a', object = nil, model = -423137698, coords = vector3(0.0, 0.0, 0.0) }, -- destroy_wood_spool_a
	-- 		{ prop = 'prop_cablespool_01b', object = nil, model = -903793390, coords = vector3(0.0, 0.0, 0.0) }, -- destroy_wood_spool_b
	-- 		{ prop = 'prop_cablespool_02', object = nil, model = -1485906437, coords = vector3(0.0, 0.0, 0.0) }, -- cut_tubing
	-- 		{ prop = 'prop_cablespool_03', object = nil, model = -1255376522, coords = vector3(0.0, 0.0, 0.0) }, -- destroy_wood_spool_3
	-- 		{ prop = 'prop_cablespool_04', object = nil, model = 2111998691, coords = vector3(0.0, 0.0, 0.0) }, -- destroy_wood_spool_4
	-- 		{ prop = 'prop_cablespool_05', object = nil, model = -1951881617, coords = vector3(0.0, 0.0, 0.0) }, -- cut_cable
	-- 		{ prop = 'prop_cablespool_06', object = nil, model = -497495090, coords = vector3(0.0, 0.0, 0.0) }, -- cut_cable_2
	-- 		{ prop = 'prop_conc_blocks01a', object = nil, model = -1951226014, coords = vector3(0.0, 0.0, 0.0) }, -- prepare_cinder_blocks
	-- 		{ prop = 'prop_paints_bench01', object = nil, model = 2126419969, coords = vector3(0.0, 0.0, 0.0) }, -- mix_paint
	-- 		{ prop = 'prop_generator_04', object = nil, model = -1001828301, coords = vector3(0.0, 0.0, 0.0) }, -- fix_generator_3
	-- 		{ prop = 'prop_portaloo_01a', object = nil, model = 682074297, coords = vector3(0.0, 0.0, 0.0) }, -- clean_potty
	-- 		{ prop = 'prop_pallet_02a', object = nil, model = 830159341, coords = vector3(0.0, 0.0, 0.0) } -- destroy_pallate
	-- 	},
	-- 	blip = {
	-- 		icon = 446,
	-- 		color = 47,
	-- 		alpha = 90,
	-- 		coords = vector3(134.4951, 6418.958, 31.31242),
	-- 	},
	-- },
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