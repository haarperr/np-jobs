fx_version 'cerulean'
game 'gta5'

author 'MetaGrenade'
description 'Job Center Hub & Shared Functions'
version '1.0.0'

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}

exports {
	'getJobCenterStatus', 
	'signInToJob', 
	'createJobGroup', 
	'setGroupReadyForJobs', 
	'acceptJobTasks', 
	'getTasksList', 
	'completeJobTask', 
	'cancelJobTasks', 
	'completeCurrentJob', 
	'signOutOfJob'
}