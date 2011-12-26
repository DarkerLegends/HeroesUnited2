obj/TurfType
	Wall_Filler
		density=1
		icon_state="BaseWall"
		icon='ApartmentInts.dmi'
	Expand_Walls
		density=1
		icon='DbzTurfs.dmi'
		icon_state="FullTopV"
		proc/Expand(var/Dir)
			var/turf/NextStep=get_step(src,Dir)
			while(NextStep && !NextStep.SuperDensity)
				var/obj/O=new src.type(NextStep)
				NextStep.density=1;NextStep.SuperDensity=1
				O.verbs+=typesof(/obj/TurfType/Expand_Walls/Created/verb)
				if(Dir>=4)
					O.icon_state="FullTopH"
					var/turf/Below=get_step(O,SOUTH)
					if(Below && Below.Enter(O))	new/obj/TurfType/Wall_Filler(Below)
				else	O.icon_state="FullTopV"
				NextStep=get_step(NextStep,Dir)
		verb
			Expand_North()
				set src in oview()
				src.Expand(NORTH)
			Expand_South()
				set src in oview()
				src.Expand(SOUTH)
			Expand_East()
				set src in oview()
				src.Expand(EAST)
			Expand_West()
				set src in oview()
				src.Expand(WEST)
		Created/verb
			CutOff()
				set name="-----"
				set src in oview()
			Delete()
				set src in oview()
				src.loc:density=0
				src.loc:SuperDensity=0
				for(var/obj/TurfType/Wall_Filler/F in get_step(src,SOUTH))	F.loc=null
				src.loc=null
			Delete_Group()
				set src in oview()