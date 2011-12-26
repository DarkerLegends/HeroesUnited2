var/obj/Overlays/FlightShadow/FlightShadow=new
obj/Overlays/FlightShadow
	layer=FLOAT_LAYER-1;pixel_y=-32
	icon='Other.dmi';icon_state="FlightShadow"
var/obj/Overlays/KiBlastShadow/KiBlastShadow=new
obj/Overlays/KiBlastShadow
	layer=FLOAT_LAYER;pixel_y=-32
	icon='Effects.dmi';icon_state="KiBlastShadow"

var/obj/Overlays/Halo/Halo=new
obj/Overlays/Halo
	pixel_y=7;layer=6
	icon='Effects.dmi';icon_state="Halo"

mob/var/obj/Overlays/Aura/Aura
obj/Overlays/Aura
	icon='Effects.dmi'

mob/proc/AddTeamFlag()
	if(src.InTournament && global.TournRegMode=="Parties")
		if(global.TournFighters[src]=="Team 1")	src.overlays+=global.BlueTeamFlag
		else	src.overlays+=global.RedTeamFlag
	else	switch(src.Team)
		if("Blue")	src.overlays+=global.BlueTeamFlag
		if("Red")	src.overlays+=global.RedTeamFlag

mob/proc/SetupOverlays(/**/)
	src.overlays=initial(src.overlays)
	src.AddTeamFlag()
	src.AddName();src.AddClanName();src.AddTitle()
	if(src.IsDead)	src.overlays+=global.Halo
	if(src.Subscriber)	src.overlays+=src.SubOverlays
	if(!src.density)	src.overlays+=global.FlightShadow
	if(src.FlagCaptured)	src.overlays+=src.FlagCaptured
	if(src.Training=="Focus Training")	src.AddAura()