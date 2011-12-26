mob/Player/Move(var/turf/NewTurf,var/NewDir)
	var/turf/NextNewTurf=get_step(NewTurf,NewDir)
	for(var/obj/Items/Destroyable/D in NewTurf.contents+NextNewTurf.contents)
		src.ShowTutorial(Tutorials["Opening Chests"]);break

	for(var/mob/Player/M in NewTurf)
		if(src.Clan==M.Clan)
			if(src.FlagCaptured && M.FlagCaptured && src.FlagCaptured.icon_state==M.FlagCaptured.icon_state)
				FlagsCaptured(src.FlagCaptured,M.FlagCaptured)

	for(var/obj/FlagWars/Flags/F in NewTurf)
		if(src.FlagCaptured && src.FlagCaptured.icon_state==F.icon_state)	FlagsCaptured(src.FlagCaptured,F)
		else	F.Capture()

	for(var/obj/Items/I in NewTurf)
		var/Dist=-I.pixel_y+16
		switch(NewDir)
			if(NORTH)	Dist=I.pixel_y+16
			if(EAST)	Dist=I.pixel_x+16
			if(WEST)	Dist=-I.pixel_x+16
		spawn(Dist/4)	I.Collect(src)
	return ..()