Config = {}

Config.enabled = true -- show message
Config.actviityName = 'activity_slaughter'
Config.jobName = 'Slaughterhouse'
Config.initMessage = 'Loading: Slaughterhouse' -- (string) text to print

-- Enable NoPixel Exports
Config.useNoPixelExports = false

-- Set required items for player to complete job tasks
Config.requireMultipleItems = false -- (boolean) does this job require multiple items?
if Config.requireMultipleItems then
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

--
-- Zones
--

-- Task 0 : Job Pickup & Drop-off
Config.foreman = {
	id = 'foreman',
	name = 'Foreman',
	active = true,
	type = 'circle',
	radius = 25,
	coords = vector3(0.0, 0.0, 0.0),
	activities = {
		{ id = 'get_truck', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
		{ id = 'return_truck', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
	},
}
-- Task 1 : Animal Collection
Config.farms = {
	{
		id = 'grapeseed_farm',
		name = 'Grapeseed Farm #1',
		active = true,
		type = 'poly',
		minZ = 40.638362884521,
		maxZ = 53.635459899902,
		coords = {
			vector2(1858.1090087891, 5004.7275390625),
			vector2(1866.9041748047, 4993.33203125),
			vector2(1874.1550292969, 4974.52734375),
			vector2(1886.591796875, 4961.5356445312),
			vector2(1913.2518310547, 4948.564453125),
			vector2(1931.0177001953, 4936.32421875),
			vector2(1937.3547363281, 4931.4501953125),
			vector2(1899.7253417969, 4889.8413085938),
			vector2(1889.8748779297, 4867.923828125),
			vector2(1869.4298095703, 4847.4868164062),
			vector2(1820.5982666016, 4800.4418945312),
			vector2(1801.1361083984, 4821.1293945312),
			vector2(1799.3546142578, 4843.0556640625),
			vector2(1802.5567626953, 4872.2900390625),
			vector2(1791.3975830078, 4898.3969726562),
			vector2(1768.3558349609, 4923.9663085938),
			vector2(1837.7462158203, 4983.5283203125)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'catch_chickens', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'cluck_n_bell', activityId = 'butcher_chickens' },
			{ id = 'catch_pigs', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'slaughter_house', activityId = 'butcher_pigs' },
			{ id = 'catch_cows', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'slaughter_house', activityId = 'butcher_cows' }
		},
	},
	{
		id = 'grapeseed_farm_2',
		name = 'Grapeseed Farm #2',
		active = true,
		type = 'poly',
		minZ = 32.586009979248,
		maxZ = 38.098377227783,
		coords = {
			vector2(2567.1528320312, 4731.189453125),
			vector2(2560.494140625, 4725.0161132812),
			vector2(2547.0461425781, 4738.798828125),
			vector2(2473.2526855469, 4665.8076171875),
			vector2(2370.6745605469, 4766.9365234375),
			vector2(2351.69140625, 4775.158203125),
			vector2(2361.2412109375, 4792.7778320312),
			vector2(2414.1193847656, 4845.5424804688),
			vector2(2421.5126953125, 4855.2333984375),
			vector2(2449.0471191406, 4828.2626953125),
			vector2(2478.8095703125, 4799.6826171875),
			vector2(2521.9948730469, 4773.4379882812)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'catch_chickens', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'cluck_n_bell', activityId = 'butcher_chickens' },
			{ id = 'catch_pigs', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'slaughter_house', activityId = 'butcher_pigs' },
			{ id = 'catch_cows', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'slaughter_house', activityId = 'butcher_cows' }
		},
	},
	{
		id = 'grapeseed_farm_3',
		name = 'Grapeseed Farm #3',
		active = true,
		type = 'poly',
		minZ = 40.7724609375,
		maxZ = 45.687217712402,
		coords = {
			vector2(2251.8166503906, 5002.337890625),
			vector2(2263.0483398438, 4992.2338867188),
			vector2(2170.5869140625, 4900.9086914062),
			vector2(2060.4113769531, 5010.275390625),
			vector2(2144.6193847656, 5097.7963867188),
			vector2(2190.525390625, 5051.2163085938),
			vector2(2244.49609375, 4994.9033203125)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'catch_chickens', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'cluck_n_bell', activityId = 'butcher_chickens' },
			{ id = 'catch_pigs', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'slaughter_house', activityId = 'butcher_pigs' },
			{ id = 'catch_cows', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'slaughter_house', activityId = 'butcher_cows' }
		},
	},
	{
		id = 'grapeseed_farm_4',
		name = 'Grapeseed Farm #4',
		active = true,
		type = 'poly',
		minZ = 45.580806732178,
		maxZ = 47.347198486328,
		coords = {
			vector2(2360.9196777344, 5111.771484375),
			vector2(2381.1677246094, 5093.5541992188),
			vector2(2443.0236816406, 5047.0327148438),
			vector2(2470.0400390625, 5021.8579101562),
			vector2(2418.3605957031, 4966.7153320312),
			vector2(2399.7668457031, 4995.5063476562),
			vector2(2321.8386230469, 5073.6865234375)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'catch_chickens', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'cluck_n_bell', activityId = 'butcher_chickens' },
			{ id = 'catch_pigs', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'slaughter_house', activityId = 'butcher_pigs' },
			{ id = 'catch_cows', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'slaughter_house', activityId = 'butcher_cows' }
		},
	},
	{
		id = 'paleto_farm',
		name = 'Paleto Farm',
		active = true,
		type = 'poly',
		minZ = 25.097793579102,
		maxZ = 31.911756515503,
		coords = {
			vector2(602.79583740234, 6447.7221679688),
			vector2(607.13677978516, 6550.93359375),
			vector2(774.81225585938, 6515.896484375),
			vector2(765.27520751953, 6434.56640625),
			vector2(602.26159667969, 6433.8056640625)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'catch_chickens', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'cluck_n_bell', activityId = 'butcher_chickens' },
			{ id = 'catch_pigs', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'slaughter_house', activityId = 'butcher_pigs' },
			{ id = 'catch_cows', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil, butcherId = 'slaughter_house', activityId = 'butcher_cows' }
		},
	}
} 
-- Task 2 : Animal Butchering
Config.butchers = {
	{
		id = 'slaughter_house',
		name = 'Slaughter House',
		active = true,
		type = 'poly',
		minZ = 30.297485351562,
		maxZ = 31.023944854736,
		coords = {
			vector2(935.17553710938, -2188.9265136719),
			vector2(929.58306884766, -2183.2453613281),
			vector2(936.80444335938, -2094.0915527344),
			vector2(1005.4051513672, -2095.189453125),
			vector2(1021.619934082, -2093.8835449219),
			vector2(1017.403503418, -2101.9140625),
			vector2(1012.5164794922, -2145.2600097656),
			vector2(1010.4906005859, -2174.986328125),
			vector2(1008.1586303711, -2195.7465820312)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'butcher_pigs', object = nil, coords = vector3(0.0, 0.0, 0.0) },
			{ id = 'butcher_cows', object = nil, coords = vector3(0.0, 0.0, 0.0) }
		},
	},
	{
		id = 'cluck_n_bell',
		name = 'Clucking Bell',
		active = true,
		type = 'poly',
		minZ = 31.102109909058,
		maxZ = 32.005264282227,
		coords = {
			vector2(-177.93362426758, 6097.97265625),
			vector2(-222.04377746582, 6142.078125),
			vector2(-120.4164276123, 6244.0522460938),
			vector2(-105.32070159912, 6257.0844726562),
			vector2(-86.967903137207, 6272.1186523438),
			vector2(-39.049434661865, 6317.435546875),
			vector2(-3.1916382312775, 6259.4331054688),
			vector2(3.4892303943634, 6247.912109375),
			vector2(-35.453006744385, 6225.6435546875),
			vector2(-64.901191711426, 6205.3745117188),
			vector2(-102.51775360107, 6171.314453125)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'butcher_chickens', object = nil, coords = vector3(0.0, 0.0, 0.0) }
		},
	}
} 

--custonm print function
Config.print = function(text) 
	print("^3CONFIG^7", text)
end