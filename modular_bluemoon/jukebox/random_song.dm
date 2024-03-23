/obj/machinery/jukebox/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if ("random_song")
			ui_act("add_to_queue", list("track" = pick(cached_songs)))
			return TRUE


/obj/item/jukebox/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if ("random_song")
			ui_act("add_to_queue", list("track" = pick(cached_songs)))
			return TRUE
