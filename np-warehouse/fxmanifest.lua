fx_version 'cerulean'
game 'gta5'

author 'MetaGrenade'
description 'Port/Dock Warehouse Forklift Operator'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}