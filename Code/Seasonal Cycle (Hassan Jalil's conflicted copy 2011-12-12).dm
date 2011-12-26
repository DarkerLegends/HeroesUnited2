var
	list/Season=list("Winter"=list("November","December","January"))

proc
	CheckSeason()
		while(1)
			var/list/Winter=Season["Winter"]
			var/CurMonth=time2text(world.realtime,"Month")
			if(CurMonth in Winter)
				ApplyWinter()
			else
				ApplyNormal()
				GenerateFlowers()
			sleep(6000)
	ApplyWinter()
		for(var/obj/Supplemental/Flower/F in world)
			del(F)
		for(var/turf/Generic/Water/W in world)
			W.icon_state="Ice"
			W.density=1
		for(var/turf/W in world)
			if(istype(W,/turf/Generic/Grass) in W.loc)
				W.icon_state=pick("Snow 1","Snow 2")

	ApplyNormal()
		for(var/turf/Generic/Water/W in world)
			W.icon_state="Water"
			W.density=1
		for(var/turf/Generic/Grass/W in world)
			W.icon_state="Grass[rand(1,4)]"
			W.density=0