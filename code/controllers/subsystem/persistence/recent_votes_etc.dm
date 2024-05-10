/**
 * Stores recently played gamemodes, maps, etc.
 */
/datum/controller/subsystem/persistence
	var/list/saved_modes = list(1,2,3)
	var/list/saved_chaos = list(5,5,5)
	var/list/saved_dynamic_rules = list(list(),list(),list())
	var/average_threat = 50
	var/list/saved_maps
	var/last_dynamic_gamemode = "" //BLUEMOON ADDITION
	var/static/is_roundtype_collected = FALSE // BLUEMOON ADD - НЕ СОХРАНЯЕТСЯ

/datum/controller/subsystem/persistence/SaveServerPersistence()
	. = ..()
	CollectRoundtype()
	RecordMaps()

/datum/controller/subsystem/persistence/LoadServerPersistence()
	. = ..()
	LoadRecentModes()
	LoadRecentChaos()
	LoadRecentRulesets()
	LoadRecentMaps()
	LoadRecentDynamicType() //BLUEMOON ADDITION

/datum/controller/subsystem/persistence/proc/CollectRoundtype()
	if (is_roundtype_collected) return // BLUEMOON ADD

	saved_modes[3] = saved_modes[2]
	saved_modes[2] = saved_modes[1]
	saved_modes[1] = SSticker.mode.config_tag
	var/json_file = file("data/RecentModes.json")
	var/list/file_data = list()
	file_data["data"] = saved_modes
	fdel(json_file)
	WRITE_FILE(json_file, json_encode(file_data))
	saved_chaos[3] = saved_chaos[2]
	saved_chaos[2] = saved_chaos[1]
	saved_chaos[1] = SSticker.mode.get_chaos()
	average_threat = (SSactivity.get_average_threat() + average_threat) / 2
	json_file = file("data/RecentChaos.json")
	file_data = list()
	file_data["data"] = saved_chaos + average_threat
	fdel(json_file)
	WRITE_FILE(json_file, json_encode(file_data))

	is_roundtype_collected = TRUE // BLUEMOON ADD

/datum/controller/subsystem/persistence/proc/RecordMaps()
	saved_maps = saved_maps?.len ? list("[SSmapping.config.map_name]") | saved_maps : list("[SSmapping.config.map_name]")
	var/json_file = file("data/RecentMaps.json")
	var/list/file_data = list()
	file_data["maps"] = saved_maps
	fdel(json_file)
	WRITE_FILE(json_file, json_encode(file_data))
//BLUEMOON ADDITION START
/datum/controller/subsystem/persistence/proc/RecordDynamicType(var/type)
	last_dynamic_gamemode = type
	var/json_file = file("data/RecentDynamicType.json")
	var/list/file_data = list()
	file_data["data"] = last_dynamic_gamemode
	fdel(json_file)
	WRITE_FILE(json_file, json_encode(file_data))

/datum/controller/subsystem/persistence/proc/LoadRecentDynamicType()
	var/json_file = file("data/RecentDynamicType.json")
	if(!fexists(json_file))
		return
	var/list/json = json_decode(file2text(json_file))
	if(!json)
		return
	last_dynamic_gamemode = json["data"]
//BLUEMOON ADDITION END

/datum/controller/subsystem/persistence/proc/LoadRecentModes()
	var/json_file = file("data/RecentModes.json")
	if(!fexists(json_file))
		return
	var/list/json = json_decode(file2text(json_file))
	if(!json)
		return
	saved_modes = json["data"]

/datum/controller/subsystem/persistence/proc/LoadRecentChaos()
	var/json_file = file("data/RecentChaos.json")
	if(!fexists(json_file))
		return
	var/list/json = json_decode(file2text(json_file))
	if(!json)
		return
	saved_chaos = json["data"]
	if(saved_chaos.len > 3)
		average_threat = saved_chaos[4]
	saved_chaos.len = 3

/datum/controller/subsystem/persistence/proc/LoadRecentRulesets()
	var/json_file = file("data/RecentRulesets.json")
	if(!fexists(json_file))
		return
	var/list/json = json_decode(file2text(json_file))
	if(!json)
		return
	saved_dynamic_rules = json["data"]

/datum/controller/subsystem/persistence/proc/LoadRecentMaps()
	var/json_file = file("data/RecentMaps.json")
	if(!fexists(json_file))
		return
	var/list/json = json_decode(file2text(json_file))
	if(!json)
		return
	saved_maps = json["maps"]

/datum/controller/subsystem/persistence/proc/get_recent_chaos()
	var/sum = 0
	for(var/n in saved_chaos)
		sum += n
	return sum/length(saved_chaos)
