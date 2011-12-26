mob/var/tmp/obj/FlagWars/Flags/FlagCaptured
var/TextIcon='TextIcons.dmi'
var/FlagWarsTag=GenFwString()
proc/GenFwString()
	var/FwString=""
	for(var/i=1;i<=5;i++)	FwString+="<IMG CLASS=icon SRC=\ref[TextIcon] ICONSTATE='FW[i]'>"
	return FwString

mob/proc/DropFlag(var/Reason="Got Too Heavy?")
	if(!src.FlagCaptured)	return
	var/obj/FlagWars/Flags/F=src.FlagCaptured
	F.ResetFlag()

proc/FlagsCaptured(var/obj/FlagWars/Flags/F1,var/obj/FlagWars/Flags/F2)
	var/ClanTag="<font color=[F1.CapturedBy.Clan.Color]>{[F1.CapturedBy.Clan]}</font color> "
	if(F2.CapturedBy)
		world<<"[FlagWarsTag] <b>[ClanTag][F1.CapturedBy] and [F2.CapturedBy] have Scored with the <font color=[F1.name]>[F1.name] Flags!"
		//F2.CapturedBy.AddExp(100*100,"Flag Wars Capture")
		//F1.CapturedBy.Clan.AddClanExp(50,F1.CapturedBy);F2.CapturedBy.Clan.AddClanExp(50,F2.CapturedBy)
		//F1.CapturedBy.GiveMedal(new/obj/Medals/Flag_Buddies);F2.CapturedBy.GiveMedal(new/obj/Medals/Flag_Buddies)
	else
		world<<"[FlagWarsTag] <b>[ClanTag][F1.CapturedBy] has Scored with the <font color=[F1.name]>[F1.name] Flags!"
		//F1.CapturedBy.GiveMedal(new/obj/Medals/Flag_Bearer)
		//F1.CapturedBy.Clan.AddClanExp(100,F1.CapturedBy)
	//F1.CapturedBy.AddExp(100*100,"Flag Wars Capture")
	F1.ResetFlag();F2.ResetFlag()
	F1.loc=null;F2.loc=null
	spawn(rand(100,200))	F1.ResetFlag()
	spawn(rand(100,200))	F2.ResetFlag()

var/list/Flags2Spawn=list("Blue","Red","Black","White","Green","Yellow")

obj/FlagWars
	Flags
		icon='Flags.dmi'
		var/mob/CapturedBy
		var/obj/HUD/MiniMapMarkers/FW/MMM
		New()
			src.MMM=new(src.icon_state);global.FWMMMs+=src.MMM
			spawn()	while(1)
				var/TargetLoc=src
				if(src.CapturedBy)	TargetLoc=src.CapturedBy
				src.MMM.CalculateForcedLoc(TargetLoc,220,220,32,16)
				sleep(2)
			return ..()
		verb/Capture()
			set hidden=1
			if(usr.GhostMode)	return
			if(usr.FlagCaptured)	return
			src.loc=null
			src.CapturedBy=usr
			src.pixel_x=4;src.pixel_y=16
			usr.overlays+=src;usr.FlagCaptured=src
		proc/ResetFlag()
			if(src.CapturedBy)
				src.CapturedBy.overlays-=src
				src.CapturedBy.FlagCaptured=null
			src.pixel_x=0;src.pixel_y=0
			src.CapturedBy=null
			spawn(-1)
				src.loc=initial(src.loc)
		Blue
			icon_state="Blue"
		Red
			icon_state="Red"
		Black
			icon_state="Black"
		White
			icon_state="White"
		Green
			icon_state="Green"
		Yellow
			icon_state="Yellow"