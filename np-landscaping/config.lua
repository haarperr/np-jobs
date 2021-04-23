Config = {}

Config.enabled = true -- (boolean) is the job enabled?
Config.actviityName = 'activity_landscaping'
Config.jobName = 'Landscaping'
Config.initMessage = 'Loading: Landscaping' -- (string) text to print

-- Enable NoPixel Exports
Config.useNoPixelExports = false

-- Set required items for player to complete job tasks
Config.requireMultipleItems = false -- (boolean) does this job require multiple items?
if Config.requireMultipleItems do
	-- NOTE: REPLACE ITEM NAMES BELOW WITH PROPER NP ITEM NAMES
	Config.requiredItems = {
		'hatchet',
		'pickaxe',
		'heavyboltcutter'
	}
else
	Config.requiredItems = nil
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
	if Config.useRandTaskLimit do
		Config.taskLimit = random(Config.minTaskLimit, Config.maxTaskLimit) -- (integer) set random taskLimit between Config.minTaskLimit & Config.maxTaskLimit
	else
		Config.taskLimit = Config.minTaskLimit -- (integer) uses the minTaskLimit param above
	end
end

-- Job related zones
Config.zones = {
	{
		id = 'graveyard',
		name = 'Graveyard',
		active = true,
		type = 'poly',
		minZ = 38.964504241943,
		maxZ = 67.078857421875,
		coords = {
			vector2(-1858.9957275391, -213.64888000488),
			vector2(-1841.1221923828, -195.63279724121),
			vector2(-1838.9948730469, -181.32507324219),
			vector2(-1814.8461914062, -175.3595123291),
			vector2(-1797.7864990234, -170.76391601562),
			vector2(-1788.4016113281, -164.41348266602),
			vector2(-1746.484375, -146.13798522949),
			vector2(-1706.7459716797, -130.90852355957),
			vector2(-1684.5511474609, -114.46078491211),
			vector2(-1629.4426269531, -113.34706878662),
			vector2(-1611.3302001953, -144.14447021484),
			vector2(-1598.8289794922, -162.60894775391),
			vector2(-1586.0361328125, -179.10530090332),
			vector2(-1588.1062011719, -184.82130432129),
			vector2(-1614.2620849609, -216.41189575195),
			vector2(-1620.8096923828, -229.5372467041),
			vector2(-1629.2681884766, -268.08343505859),
			vector2(-1639.2722167969, -300.40490722656),
			vector2(-1652.8005371094, -318.10211181641),
			vector2(-1672.1480712891, -333.3835144043),
			vector2(-1688.9750976562, -340.71926879883),
			vector2(-1715.4953613281, -344.63955688477),
			vector2(-1741.3702392578, -340.51898193359),
			vector2(-1761.6767578125, -330.82501220703),
			vector2(-1781.7008056641, -314.35415649414),
			vector2(-1805.6987304688, -288.9143371582),
			vector2(-1823.1870117188, -264.52230834961),
			vector2(-1837.9727783203, -239.80389404297),
			vector2(-1848.7563476562, -225.28588867188)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'western_skatepark',
		name = 'Western Skatepark',
		active = true,
		type = 'poly',
		minZ = 15.405848503113,
		maxZ = 27.727514266968,
		coords = {
			vector2(-990.72833251953, -804.45660400391),
			vector2(-981.77130126953, -788.62939453125),
			vector2(-981.45257568359, -764.62463378906),
			vector2(-991.7041015625, -763.74133300781),
			vector2(-992.11895751953, -704.40295410156),
			vector2(-971.95874023438, -690.34143066406),
			vector2(-947.02783203125, -679.31237792969),
			vector2(-921.76977539062, -673.71923828125),
			vector2(-896.88824462891, -669.60211181641),
			vector2(-868.15008544922, -669.39367675781),
			vector2(-865.74298095703, -694.42456054688),
			vector2(-866.1787109375, -748.83343505859),
			vector2(-866.47863769531, -823.02105712891),
			vector2(-877.47277832031, -824.95672607422),
			vector2(-950.41619873047, -824.70965576172),
			vector2(-970.03515625, -817.11120605469)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'northern_golfcourse',
		name = 'Northern Golf Course',
		active = true,
		type = 'poly',
		minZ = 37.74352645874,
		maxZ = 67.588729858398,
		coords = {
			vector2(-903.65466308594, -108.19882202148),
			vector2(-921.23864746094, -121.7516708374),
			vector2(-960.52557373047, -142.02903747559),
			vector2(-977.24932861328, -146.0255279541),
			vector2(-1002.01953125, -150.73164367676),
			vector2(-1035.275390625, -166.53968811035),
			vector2(-1052.1573486328, -168.68580627441),
			vector2(-1065.6918945312, -162.97006225586),
			vector2(-1118.5563964844, -136.89682006836),
			vector2(-1172.6424560547, -108.15673065186),
			vector2(-1205.5964355469, -90.495567321777),
			vector2(-1255.9952392578, -61.982624053955),
			vector2(-1287.7452392578, -49.335445404053),
			vector2(-1309.50390625, -44.175323486328),
			vector2(-1317.9041748047, -34.702285766602),
			vector2(-1338.841796875, -34.169986724854),
			vector2(-1346.2041015625, -41.704818725586),
			vector2(-1386.1160888672, -45.491237640381),
			vector2(-1406.1368408203, -31.461471557617),
			vector2(-1408.1579589844, -11.945234298706),
			vector2(-1414.0776367188, 23.138782501221),
			vector2(-1418.7241210938, 55.697101593018),
			vector2(-1421.8059082031, 101.71979522705),
			vector2(-1416.4228515625, 140.53659057617),
			vector2(-1406.9488525391, 159.26036071777),
			vector2(-1393.1953125, 176.00450134277),
			vector2(-1372.8540039062, 190.82539367676),
			vector2(-1338.4587402344, 201.00381469727),
			vector2(-1303.2973632812, 203.1085357666),
			vector2(-1265.4349365234, 207.63293457031),
			vector2(-1243.5534667969, 213.4965057373),
			vector2(-1206.2687988281, 225.43254089355),
			vector2(-1165.1871337891, 234.44236755371),
			vector2(-1147.2807617188, 240.12977600098),
			vector2(-1122.6409912109, 250.17620849609),
			vector2(-1097.25390625, 253.62509155273),
			vector2(-1095.7902832031, 235.97497558594),
			vector2(-1090.4383544922, 211.99215698242),
			vector2(-1079.1938476562, 182.36352539062),
			vector2(-1068.8273925781, 162.0347442627),
			vector2(-1052.1804199219, 136.65003967285),
			vector2(-1037.1462402344, 114.32489776611),
			vector2(-1022.1965942383, 89.737525939941),
			vector2(-996.36572265625, 45.092720031738),
			vector2(-975.46862792969, 9.1891584396362),
			vector2(-956.96746826172, -18.617336273193),
			vector2(-940.20373535156, -41.093940734863),
			vector2(-939.89117431641, -45.768737792969),
			vector2(-926.7880859375, -64.30451965332),
			vector2(-917.36883544922, -80.719757080078),
			vector2(-913.62451171875, -81.872406005859),
			vector2(-903.31396484375, -102.51031494141)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'vinewood_mansion',
		name = 'Vinewood Mansion',
		active = true,
		type = 'poly',
		minZ = 226.62889099121,
		maxZ = 236.91148376465,
		coords = {
			vector2(-79.598571777344, 912.64489746094),
			vector2(-89.612419128418, 922.51788330078),
			vector2(-105.9061050415, 936.16271972656),
			vector2(-120.99965667725, 949.55987548828),
			vector2(-128.20025634766, 957.33251953125),
			vector2(-125.1817779541, 967.71350097656),
			vector2(-126.9176864624, 970.81500244141),
			vector2(-133.3129119873, 971.9736328125),
			vector2(-137.78266906738, 974.33843994141),
			vector2(-147.58145141602, 994.85021972656),
			vector2(-141.44845581055, 1028.5277099609),
			vector2(-116.52400970459, 1026.1462402344),
			vector2(-79.436973571777, 1028.3798828125),
			vector2(-73.034568786621, 1015.7149658203),
			vector2(-70.85164642334, 1017.1248168945),
			vector2(-49.368953704834, 998.32171630859),
			vector2(-48.603244781494, 991.45550537109),
			vector2(-46.039569854736, 983.54846191406),
			vector2(-49.43000793457, 952.01580810547),
			vector2(-28.102342605591, 952.80432128906),
			vector2(-25.896396636963, 951.14770507812),
			vector2(-27.581741333008, 932.78802490234),
			vector2(-30.027267456055, 931.45080566406),
			vector2(-30.11619758606, 925.35424804688),
			vector2(-65.847320556641, 917.98529052734)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'downtown_park',
		name = 'Downtown Park',
		active = true,
		type = 'poly',
		minZ = 30.62921333313,
		maxZ = 40.416103363037,
		coords = {
			vector2(-32.532974243164, -406.66662597656),
			vector2(-56.876258850098, -481.09274291992),
			vector2(-77.012809753418, -480.67993164062),
			vector2(-139.28472900391, -481.95922851562),
			vector2(-155.64279174805, -479.31072998047),
			vector2(-167.57090759277, -475.13528442383),
			vector2(-174.7572479248, -473.74053955078),
			vector2(-157.92115783691, -426.14440917969),
			vector2(-140.46983337402, -370.3854675293)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'city_hall',
		name = 'City Hall',
		active = true,
		type = 'poly',
		minZ = 30.62921333313,
		maxZ = 40.416103363037,
		coords = {
			vector2(-475.4162902832, -223.00552368164),
			vector2(-470.45443725586, -225.44831848145),
			vector2(-467.00131225586, -234.43006896973),
			vector2(-468.45779418945, -242.51441955566),
			vector2(-476.22473144531, -249.44729614258),
			vector2(-481.65838623047, -250.80030822754),
			vector2(-485.22305297852, -249.43898010254),
			vector2(-536.85723876953, -270.1083984375),
			vector2(-540.22100830078, -274.68905639648),
			vector2(-559.96032714844, -283.19674682617),
			vector2(-574.84088134766, -257.98168945312),
			vector2(-574.51568603516, -251.69055175781),
			vector2(-593.09722900391, -219.31262207031),
			vector2(-597.85327148438, -216.9736328125),
			vector2(-607.67962646484, -200.74017333984),
			vector2(-608.96221923828, -189.91958618164),
			vector2(-601.49279785156, -179.28210449219),
			vector2(-587.41271972656, -173.09204101562),
			vector2(-582.69952392578, -174.28984069824),
			vector2(-546.92083740234, -159.67184448242),
			vector2(-544.78271484375, -155.18717956543),
			vector2(-526.18151855469, -147.81352233887),
			vector2(-519.24523925781, -147.59957885742),
			vector2(-512.15924072266, -153.13215637207),
			vector2(-502.88317871094, -169.06524658203),
			vector2(-503.10971069336, -175.3078918457)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'legion_square',
		name = 'Legion Square',
		active = true,
		type = 'poly',
		minZ = 29.158296585083,
		maxZ = 31.021266937256,
		coords = {
			vector2(124.43236541748, -991.32653808594),
			vector2(161.45614624023, -888.63891601562),
			vector2(170.61459350586, -876.27191162109),
			vector2(178.10305786133, -859.76177978516),
			vector2(184.53120422363, -842.51507568359),
			vector2(188.09828186035, -840.3984375),
			vector2(192.31132507324, -840.55078125),
			vector2(261.4541015625, -865.56524658203),
			vector2(265.24755859375, -870.31085205078),
			vector2(265.83514404297, -877.16632080078),
			vector2(211.39276123047, -1027.0537109375),
			vector2(156.38381958008, -1007.9952392578),
			vector2(152.73220825195, -1001.1463623047)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'mirrorpark_skatepark',
		name = 'Mirrorpark Skate & Soccer',
		active = true,
		type = 'poly',
		minZ = 45.384662628174,
		maxZ = 74.772308349609,
		coords = {
			vector2(746.17199707031, -158.04463195801),
			vector2(770.34210205078, -173.41551208496),
			vector2(785.81787109375, -181.05085754395),
			vector2(803.41766357422, -189.24824523926),
			vector2(827.17352294922, -204.4786529541),
			vector2(831.50885009766, -205.61129760742),
			vector2(866.05578613281, -226.70028686523),
			vector2(870.00061035156, -231.2202911377),
			vector2(902.39508056641, -252.20588684082),
			vector2(907.3203125, -253.7707824707),
			vector2(929.35961914062, -269.82849121094),
			vector2(933.15368652344, -274.13394165039),
			vector2(947.64526367188, -284.98818969727),
			vector2(949.87347412109, -292.30880737305),
			vector2(947.26959228516, -302.10556030273),
			vector2(932.09643554688, -315.0514831543),
			vector2(912.314453125, -322.05282592773),
			vector2(888.30981445312, -325.89236450195),
			vector2(856.56079101562, -328.78753662109),
			vector2(834.98852539062, -329.22463989258),
			vector2(822.29071044922, -330.81039428711),
			vector2(789.18908691406, -336.62484741211),
			vector2(766.697265625, -342.49780273438),
			vector2(748.92242431641, -348.15826416016),
			vector2(732.62316894531, -333.64489746094),
			vector2(718.56799316406, -312.33050537109),
			vector2(706.71911621094, -319.9651184082),
			vector2(694.85418701172, -323.13497924805),
			vector2(688.80932617188, -301.66262817383),
			vector2(689.29388427734, -284.92965698242),
			vector2(708.68090820312, -238.87832641602)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'mirrorpark_lake',
		name = 'Mirrorpark Lake',
		active = true,
		type = 'poly',
		minZ = 57.318111419678,
		maxZ = 64.909599304199,
		coords = {
			vector2(1186.7663574219, -753.46514892578),
			vector2(1072.4436035156, -753.33062744141),
			vector2(1062.2839355469, -752.46673583984),
			vector2(1047.0096435547, -746.78387451172),
			vector2(1034.966796875, -736.83050537109),
			vector2(1000.4196166992, -695.61602783203),
			vector2(994.76184082031, -685.7978515625),
			vector2(986.25085449219, -665.21173095703),
			vector2(997.22827148438, -660.05987548828),
			vector2(1009.9383544922, -655.70184326172),
			vector2(1017.833190918, -649.70129394531),
			vector2(1021.3635864258, -640.71728515625),
			vector2(1022.8801269531, -629.89666748047),
			vector2(1025.2662353516, -611.82159423828),
			vector2(1029.3508300781, -593.92492675781),
			vector2(1033.9090576172, -575.99322509766),
			vector2(1036.2424316406, -557.27618408203),
			vector2(1036.5548095703, -532.14245605469),
			vector2(1057.8465576172, -526.93994140625),
			vector2(1075.8835449219, -524.84240722656),
			vector2(1148.849609375, -517.58868408203),
			vector2(1163.5992431641, -519.29431152344),
			vector2(1162.1197509766, -527.49938964844),
			vector2(1160.0633544922, -546.29132080078),
			vector2(1160.0567626953, -566.62036132812),
			vector2(1161.1645507812, -585.46026611328),
			vector2(1164.3585205078, -607.02508544922),
			vector2(1170.8824462891, -640.12933349609),
			vector2(1185.7911376953, -718.68316650391),
			vector2(1187.2722167969, -741.96636962891)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'paleto_rest_area',
		name = 'Paleto Rest Stop',
		active = true,
		type = 'poly',
		minZ = 8.3955898284912,
		maxZ = 24.054468154907,
		coords = {
			vector2(1566.2053222656, 6478.884765625),
			vector2(1552.7507324219, 6445.015625),
			vector2(1516.7739257812, 6459.8720703125),
			vector2(1399.6586914062, 6492.6157226562),
			vector2(1344.0463867188, 6502.08203125),
			vector2(1302.6547851562, 6504.9833984375),
			vector2(1306.5754394531, 6532.5756835938),
			vector2(1326.0804443359, 6542.9799804688),
			vector2(1341.3497314453, 6553.9833984375),
			vector2(1351.4010009766, 6584.638671875),
			vector2(1372.1247558594, 6602.0297851562),
			vector2(1401.8796386719, 6611.5498046875),
			vector2(1437.0189208984, 6620.1977539062),
			vector2(1443.7231445312, 6600.7553710938),
			vector2(1481.0347900391, 6590.81640625),
			vector2(1520.7312011719, 6581.6376953125),
			vector2(1538.8206787109, 6577.4462890625),
			vector2(1558.3172607422, 6562.962890625),
			vector2(1585.3532714844, 6572.1049804688),
			vector2(1594.7841796875, 6552.5776367188),
			vector2(1601.0386962891, 6510.3559570312)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'north_vinewood_park',
		name = 'North Vinewood Park',
		active = true,
		type = 'poly',
		minZ = 199.55363464355,
		maxZ = 220.20584106445,
		coords = {
			vector2(-722.5703125, 851.54412841797),
			vector2(-728.01232910156, 846.53668212891),
			vector2(-734.23486328125, 842.82507324219),
			vector2(-741.52069091797, 839.64788818359),
			vector2(-753.42602539062, 836.03143310547),
			vector2(-766.98309326172, 833.06829833984),
			vector2(-783.84600830078, 830.51202392578),
			vector2(-801.80786132812, 827.93121337891),
			vector2(-816.82336425781, 825.609375),
			vector2(-826.89031982422, 823.18353271484),
			vector2(-830.84625244141, 836.27655029297),
			vector2(-846.18035888672, 834.02191162109),
			vector2(-872.31420898438, 826.56372070312),
			vector2(-875.29449462891, 857.37915039062),
			vector2(-867.31915283203, 877.267578125),
			vector2(-856.68768310547, 886.39721679688),
			vector2(-778.45593261719, 902.9501953125),
			vector2(-762.70361328125, 904.34527587891)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'cottage_park',
		name = 'Cottage Park',
		active = true,
		type = 'poly',
		minZ = 66.502510070801,
		maxZ = 72.464233398438,
		coords = {
			vector2(-935.51080322266, 264.64047241211),
			vector2(-953.86236572266, 271.49371337891),
			vector2(-966.52142333984, 274.9365234375),
			vector2(-981.98504638672, 277.6291809082),
			vector2(-994.18798828125, 278.3134765625),
			vector2(-1007.1372680664, 278.12078857422),
			vector2(-1008.3912963867, 290.98080444336),
			vector2(-1023.0264282227, 333.72592163086),
			vector2(-1005.1615600586, 338.02847290039),
			vector2(-992.59362792969, 342.02737426758),
			vector2(-986.95269775391, 344.39233398438),
			vector2(-980.82543945312, 349.75994873047),
			vector2(-975.78765869141, 355.54614257812),
			vector2(-971.95587158203, 359.52536010742),
			vector2(-956.1982421875, 357.94958496094),
			vector2(-947.45391845703, 354.26635742188),
			vector2(-943.39019775391, 350.72955322266),
			vector2(-938.380859375, 342.63879394531),
			vector2(-935.49047851562, 333.37417602539),
			vector2(-933.05322265625, 315.49331665039),
			vector2(-930.580078125, 291.93966674805),
			vector2(-926.52911376953, 272.09045410156),
			vector2(-927.35467529297, 268.17944335938),
			vector2(-930.93035888672, 265.23223876953)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	},
	{
		id = 'court_house',
		name = 'Court House',
		active = true,
		type = 'poly',
		minZ = 41.063034057617,
		maxZ = 45.24654006958,
		coords = {
			vector2(196.32427978516, -355.64190673828),
			vector2(222.59237670898, -364.03707885742),
			vector2(242.06045532227, -370.16152954102),
			vector2(266.81866455078, -379.05453491211),
			vector2(277.7780456543, -386.57864379883),
			vector2(285.63256835938, -395.84957885742),
			vector2(290.46365356445, -407.37121582031),
			vector2(293.05877685547, -420.93475341797),
			vector2(293.32894897461, -434.2590637207),
			vector2(292.58245849609, -449.80438232422),
			vector2(289.43453979492, -463.99838256836),
			vector2(277.99389648438, -463.06256103516),
			vector2(261.00537109375, -462.77359008789),
			vector2(250.73950195312, -463.70303344727),
			vector2(237.6577911377, -464.38046264648),
			vector2(232.17297363281, -464.05334472656),
			vector2(219.32763671875, -459.15954589844),
			vector2(217.74917602539, -463.494140625),
			vector2(201.34687805176, -463.74163818359),
			vector2(160.20217895508, -449.37030029297),
			vector2(170.81260681152, -415.99780273438),
			vector2(175.55290222168, -403.09915161133)
		},
		taskLimit = Config.getTaskLimit(),
		tasks = {
			{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
			{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil }
		},
	}
	-- {
	-- 	id = 'zone_1',
	-- 	name = 'Zone #1',
	-- 	active = true,
	-- 	type = 'box',
	-- 	zoneLength = 87,
	-- 	width = 90,
	-- 	coords = vector3(0.0, 0.0, 0.0),
	-- 	taskLimit = Config.getTaskLimit(),
	-- 	tasks = {
	-- 		{ id = 'activity_1', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'activity_2', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 		{ id = 'activity_3', object = nil, coords = vector3(0.0, 0.0, 0.0), isBeingUsed = false, isUsed = false, beingUsedBy = nil },
	-- 	},
	-- },
} 

--custonm print function
Config.print = function(text) 
	print("^3CONFIG^7", text)
end