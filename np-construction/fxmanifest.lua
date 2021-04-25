fx_version 'cerulean'
game 'gta5'

author 'MetaGrenade'
description 'Construction Worker'
version '1.0.0'

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
	'config.lua',
	'client/*.lua'
}

server_scripts {
	'config.lua',
	'server/*.lua'
}