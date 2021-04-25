Config = {}

Config.enabled = true -- (boolean) is the job enabled?
Config.actviityName = 'activity_construction'
Config.jobName = 'Construction Worker'
Config.initMessage = 'Loading: Construction' -- (string) text to print

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
	Config.requiredItems = {
		'toolbelt'
	}
end

--
-- Variables
--
Config.maxGroupSize = 4 -- (integer) Maximum players allowed in the job center group for this job
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
	if Config.useRandTaskLimit do
		Config.taskLimit = random(Config.minTaskLimit, Config.maxTaskLimit) -- (integer) set random taskLimit between Config.minTaskLimit & Config.maxTaskLimit
	else
		Config.taskLimit = Config.minTaskLimit -- (integer) uses the minTaskLimit param above
	end
end

---
-- Polyzones
---

-- job sites / locations
Config.zones = {
	{
		id = 'paleto_wholefoods',
		name = 'Paleto Wholefoods',
		active = true,
		type = 'box',
		length = 87,
		width = 90,
		coords = vector3(74.04, 6535.2, 31.39),
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'paleto_house',
		name = 'Paleto House',
		active = true,
		type = 'box',
		length = 36.2,
		width = 45.6,
		coords = vector3(-327.41, 6303.54, 35.65),
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'paleto_clucking_bell',
		name = 'Paleto Clucking Bell',
		active = true,
		type = 'box',
		length = 55.0,
		width = 78.2,
		coords = vector3(133.83, 6442.29, 31.2),
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'pdm_skyscraper',
		name = 'PDM Skyscraper',
		active = true,
		type = 'poly',
		minZ = 22.859148025513,
		maxZ = 29.39026260376,
		coords = {
			vector2(-81.278228759766, -1023.1381225586),
			vector2(-105.77919769287, -1085.3673095703),
			vector2(-120.01286315918, -1111.0174560547),
			vector2(-127.62714385986, -1116.4565429688),
			vector2(-155.97286987305, -1121.5473632812),
			vector2(-230.99276733398, -1121.9537353516),
			vector2(-218.39356994629, -1106.3304443359),
			vector2(-198.20851135254, -1032.4522705078),
			vector2(-187.41934204102, -1001.9202880859),
			vector2(-159.56045532227, -925.03851318359),
			vector2(-59.014083862305, -961.68048095703)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'elburro_heights_house',
		name = 'El Burro Heights House',
		active = true,
		type = 'box',
		length = 62.8,
		width = 22.4,
		coords = vector3(1285.75, -1765.23, 51.78),
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'little_seoul',
		name = 'Little Seoul Commercial',
		active = true,
		type = 'poly',
		minZ = 22.699016571045,
		maxZ = 30.910482406616,
		coords = {
			vector2(-524.95336914062, -978.10595703125),
			vector2(-520.99920654297, -955.76379394531),
			vector2(-500.64584350586, -918.85363769531),
			vector2(-492.1330871582, -898.65637207031),
			vector2(-482.28662109375, -855.34808349609),
			vector2(-438.72537231445, -856.33697509766),
			vector2(-438.34463500977, -956.05297851562),
			vector2(-433.6826171875, -993.15985107422),
			vector2(-431.0002746582, -1035.2752685547),
			vector2(-430.97027587891, -1089.0334472656),
			vector2(-447.45275878906, -1090.7078857422),
			vector2(-485.56564331055, -1076.6322021484),
			vector2(-517.58502197266, -1058.2399902344),
			vector2(-519.61303710938, -1025.0827636719),
			vector2(-524.09155273438, -1009.9068603516)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'vespucci_canals_house',
		name = 'Vespucci Canals House',
		active = true,
		type = 'poly',
		minZ = 2.1501624584198,
		maxZ = 2.8792240619659,
		coords = {
			vector2(-1122.2845458984, -938.03149414062),
			vector2(-1118.4185791016, -941.22991943359),
			vector2(-1099.5989990234, -971.35632324219),
			vector2(-1137.041015625, -993.15673828125),
			vector2(-1157.9272460938, -956.64282226562),
			vector2(-1126.6077880859, -938.63800048828)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'west_vinewood_hills_house',
		name = 'West Vinewood Hills House',
		active = true,
		type = 'box',
		length = 48.0,
		width = 62.6,
		coords = vector3(-2008.5, 547.96, 110.65),
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'rockford_hills_house',
		name = 'Rockford Hills House',
		active = true,
		type = 'poly',
		minZ = 73.092056274414,
		maxZ = 87.158027648926,
		coords = {
			vector2(-883.5185546875, 408.04168701172),
			vector2(-895.01873779297, 403.55014038086),
			vector2(-905.26068115234, 395.27862548828),
			vector2(-912.07153320312, 383.19323730469),
			vector2(-912.78381347656, 370.26327514648),
			vector2(-930.66326904297, 375.11270141602),
			vector2(-963.36328125, 373.84426879883),
			vector2(-975.52221679688, 375.8450012207),
			vector2(-978.21978759766, 384.25064086914),
			vector2(-984.04461669922, 401.82000732422),
			vector2(-953.06231689453, 412.56884765625),
			vector2(-929.43298339844, 421.28161621094),
			vector2(-901.60186767578, 427.53674316406),
			vector2(-880.80145263672, 429.22146606445),
			vector2(-872.41302490234, 410.13565063477)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'north_vinewood_house',
		name = 'North Vinewood House',
		active = true,
		type = 'poly',
		minZ = 143.23245239258,
		maxZ = 149.25944519043,
		coords = {
			vector2(-778.21942138672, 709.63452148438),
			vector2(-764.22674560547, 715.84973144531),
			vector2(-748.11505126953, 699.11395263672),
			vector2(-745.63555908203, 694.12365722656),
			vector2(-743.47613525391, 681.92547607422),
			vector2(-751.01702880859, 667.16705322266)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'alta_skyscraper',
		name = 'Alta Skyscraper',
		active = true,
		type = 'poly',
		minZ = 36.598949432373,
		maxZ = 49.670181274414,
		coords = {
			vector2(41.710205078125, -307.36505126953),
			vector2(83.869720458984, -322.6711730957),
			vector2(161.31520080566, -350.31683349609),
			vector2(139.07960510254, -403.69921875),
			vector2(118.54915618896, -461.71133422852),
			vector2(87.290504455566, -468.42065429688),
			vector2(61.723293304443, -465.76559448242),
			vector2(26.724758148193, -462.30953979492),
			vector2(-9.994236946106, -454.70336914062),
			vector2(3.8176889419556, -408.51028442383),
			vector2(9.3534698486328, -388.59201049805),
			vector2(13.150959014893, -376.8776550293)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	}
} 

--Custom Print Function
Config.print = function(text) 
	print('^3CONFIG^7', text)
end