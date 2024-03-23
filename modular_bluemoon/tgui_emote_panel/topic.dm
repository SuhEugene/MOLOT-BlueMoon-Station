/datum/tgui_panel/on_message(type, payload)
    . = ..()
    if (.)
        return

    switch (type)
        if ("emote/create")
            return TRUE
        if ("emote/execute")
			if (isliving(client?.mob))
				var/mob/living/L = client.mob
				L.emote(payload)
            return TRUE
        if ("emote/remove")
            return TRUE
        if ("emote/rename")
            return TRUE
