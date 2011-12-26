var/datum/InstanceDatum/InstanceDatum=new
datum/InstanceDatum
	var/list/Instances=list()

mob/proc/CanInstance()
	if(src.CurrentCP && src.CurrentMission)	{src<<"Cannot relocate during Missions";return}
	if(src.InTournament)	{src<<"Cannot relocate during WT!";return}
	if(src.Training || !src.CanAct())	{src<<"Cannot relocate at this time...";return}
	return 1

mob/proc/ChangeInstance(var/InstanceID)
	src=src.GetFusionMob()
	var/StartLoc=src.loc
	var/list/ChoiceList=InstanceDatum.Instances[InstanceID]
	var/obj/TurfType/Instances/Choice=input("Select Instance:","Zoning") as null|anything in ChoiceList
	if(!Choice || src.loc!=StartLoc)	return
	if(!src.CanInstance())	return
	src.SetInstance(Choice)

mob/proc/SetInstance(var/obj/TurfType/Instances/Choice)
	src=src.GetFusionMob();src.ExitCP()
	src.PreInstanceLoc="[src.x]&[src.y]&[src.z]"
	Choice.InstancePlayers+=src;Choice.UpdateName()
	src.loc=locate(Choice.x+Choice.InstanceX+rand(-Choice.RandomX,Choice.RandomX),Choice.y+Choice.InstanceY+rand(-Choice.RandomY,Choice.RandomY),Choice.z)
	src.InstanceLoc="[Choice.x]&[Choice.y]&[Choice.z]"
	src.ClearTournamentRing()
	src.InstanceObj=Choice
	src.DuelRangeCheck()
	src.LoadMiniMapBG()

mob/proc/ExitInstance(/**/)
	if(src.PreInstanceLoc)
		var/list/PL=Split(src.PreInstanceLoc,"&")
		src.loc=locate(text2num(PL[1]),text2num(PL[2]),text2num(PL[3]))
		src.PreInstanceLoc=null
	if(src.InstanceObj)
		var/obj/TurfType/Instances/I=src.InstanceObj
		I.InstancePlayers-=src;I.UpdateName()
		src.InstanceObj=null;src.InstanceLoc=null
	src.ClearTournamentRing()
	src.LoadMiniMapBG()

turf/InstanceDoorway
	layer=5
	Entered(var/mob/M)
		if(ismob(M))
			spawn(8)
			if(M && M.loc==src)	M.ChangeInstance(src.name)
		return ..()

turf/InstanceExit
	layer=5
	Entered(var/mob/M)
		if(ismob(M))
			spawn(8)
			if(M && M.loc==src)	M.ExitCP()
		return ..()

obj/TurfType/Instances
	density=0
	var/ReqIS
	var/PvpType
	var/DeathMode
	var/InstanceID
	var/InstanceX=0
	var/InstanceY=0
	var/RandomX=0
	var/RandomY=0
	var/list/InstancePlayers=list()
	New()
		if(!src.ReqIS || src.icon_state==src.ReqIS)
			if(!(src.InstanceID in InstanceDatum.Instances))
				InstanceDatum.Instances+=src.InstanceID;InstanceDatum.Instances[src.InstanceID]=list()
			var/list/InstanceList=InstanceDatum.Instances[src.InstanceID]
			InstanceList+=src
			src.name="[src.name] #[InstanceList.len]"
			src.suffix=src.name
		return ..()
	proc/IsPvpType(var/ReqType)
		if(src.PvpType==ReqType)	return 1
		if(ReqType in src.PvpType)	return 1
		if(!ReqType && src.PvpType)	return 1
	proc/UpdateName()
		src.name="[src.suffix] ([src.InstancePlayers.len] Players)"
		if(!src.InstancePlayers.len)	src.name="[src.suffix]"
	GenericInstance
		InstanceID="GenericInstance"
	PvP_Arena
		PvpType=list("Standard")
		InstanceID="PvpArenas"
	Clan_PvP_Arena
		PvpType=list("Clan Only")
		InstanceID="ClanPvpArenas"
	Balanced_PvP_Arena
		PvpType=list("Balanced")
		InstanceID="BalancedPvpArenas"
	Training_Capsule
		density=1
		ReqIS="1,1"
		InstanceY=-8
		icon='GravMachine.png'
		InstanceID="TrainingCapsules"
		verb/Gravity()
			set src in oview()
			set category=null
			usr.GravityProc(src)
		verb/Shadow_Spar()
			set src in oview()
			set category=null
			usr.ShadowSparProc(src)
		verb/Sparring_Partner()
			set src in oview()
			set category=null
			usr.SparringPartnerProc(src)
		verb/Focus_Training()
			set src in oview()
			set category=null
			usr.FocusTrainingProc(src)