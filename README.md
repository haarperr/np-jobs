# NoPixelJobs
A set of jobs coded for use within NoPixel 3.0


NoPixel Activities List for interested Code Contributors

Your activity should be:
- Fully configurable via a config file
- Dependable / tested
- Written cleanly and easy to follow / understand
- Use library functions that NoPixel may already have (such as CreateVehicle) instead of the FiveM natives directly
- In an independent resource with appropriately exposed exports / events. Named something similar to "activity_{name}"
- Have appropriately de-coupled override functions for UI / key press / etc things
- This should always be limited to certain areas, with things multiple people can interact with. Rather than "solo quests"

Configurable:

- Activity Name
-- Use this reference in your code when calling / receiving exports / events 
- Task Name
-- Separate Activity Tasks in to their own name
- Valid locations
-- Use polyzone configs, zone data, or road data.
- Timers
-- Think action timers for your activity, how long does it take to pan gold one time?
- Cooldowns
-- Between actions, how long?
- Props / Objects
-- Allow us to see what props/objects are used in the config and change them if necessary
- Inventory items
-- Their resource names and purpose, use these when referring to them in the exports
- More to come, think of things like the above though

NoPixel Exports: (Implement your own boilerplate, please share on the excel sheet if you create one, for others to drop in.)

All exports should be called as `exports["np-activities"]:{functionName}`.

Client:

Call this before starting the activity on the client to ensure they can start.
- :canDoActivity(:activityName, :playerServerId)
-- returns bool

Call this when activity in progress
- :activityInProgress(:activityName, :playerServerId, :timeToComplete)
-- returns bool

Call this when an activity completes, fails, or is abandoned
- :activityCompleted(:activityName, :playerServerId, :success, :reason)
-- returns void

Call this before starting the task
- :canDoTask(:activityName, :playerServerId, :taskName)
-- returns bool

Call this when a task is in progress
- :taskInProgress(:activityName, :playerServerId, :taskName, :taskDescription)
-- returns void

Call this when a task is completed, failed, or abandoned
- :taskCompleted(:activityName, :playerServerId, :taskName, :success, :reason)

Call this to check if they have something in their inventory required for task
- :hasInventoryItem(:playerServerId, :name)

Call this to give a player an inventory item
- :giveInventoryItem(:playerServerId, :name, :quantity)

Call this to remove a players inventory item
- :removeInventoryItem(:playerServerId, :name, :quantity)

Call this to notify the player of something
- :notifyPlayer(:playerServerId, :message)

--

Your resource exports: `exports["activity_{name}"]:`

Client:

Accept this export call to enable / disable the activity completely
- :setActivityStatus(:enabledDisabled)

This sets locations / areas (as in the config) to enabled / disabled, which should remove any blips etc
- :setLocationStatus(:locationId, :enabledDisabled)

Accept this to place a blip / marker / whatever for them to go to
- :setActivityDestination(:locationId)

Remove the destination stuff
- :removeActivityDestination(:locationId)

To start an activity from a random location
- :startActivity(:playerServerId)
