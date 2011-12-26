mob/var/tmp
	list/ControlClients
	mob/Player/Fusion/FusionMob

mob/proc/GetFusionMob(/**/)
	if(src.FusionMob)	return src.FusionMob
	else	return src

mob/Player/Fusion
	New()
		while(istext(src.Character))
			for(var/obj/Characters/M in AllCharacters)
				if(M.name==src.Character)	{src.Character=M;src.icon=src.Character.icon;break}
		return ..()
	verb/End_Fusion()
		set src in world
		set category=null
		if(usr.FusionMob==src)	usr.EndFusion()
	Gogeta
		Character="Gogeta"
	Vegito
		Character="Vegito"
	Gotenks
		Character="Gotenks"
	Broku
		Character="Broku"
	Vegetrunks
		Character="Vegetrunks"

mob/proc/EndFusion()
	src.FusionMob.ExitCP()
	src.FusionMob.ClearHUDPopups()
	src.FusionMob.ForceCancelTraining()
	if(src.FusionMob.Dueling)
		if(src.FusionMob.DuelFlag)
			src.FusionMob.TrackStat("[src.FusionMob.DuelFlag.DuelType] Duels DeFused",1)
			src.FusionMob.Dueling.TrackStat("[src.FusionMob.DuelFlag.DuelType] Duels DeFuse Canceled",1)
		src.FusionMob<<"Duel Canceled; You DeFused!"
		src.FusionMob.Dueling<<"Duel Canceled; [src.FusionMob] DeFused!"
		src.FusionMob.EndDuel()
	for(var/client/C in src.FusionMob.ControlClients)
		C.mob.density=src.FusionMob.density
		C.mob.loc=src.FusionMob.loc
		if(C.eye==src.FusionMob)	C.eye=C.mob
		C.mob.InstanceLoc=src.FusionMob.InstanceLoc
		C.mob.InstanceObj=src.FusionMob.InstanceObj
		C.mob.PreInstanceLoc=src.FusionMob.PreInstanceLoc
		C.mob.invisibility=0;C.mob.ResetIS()
		C.mob.UpdateKiHUD();C.mob.UpdatePlHUD();C.mob.UpdateFaceHUD()
		C.mob.ClearTournamentRing()
	del src.FusionMob

mob/verb/Toggle_Fusions()
	set hidden=1
	src.IgnoreFusions=!src.IgnoreFusions
	if(src.IgnoreFusions)	src<<"You are now Ignoring all Fusion Requests"
	else	src<<"You are now Accepting Fusion Requests"

mob/var/IgnoreFusions
mob/var/list/FusionInvites
mob/var/tmp/list/FusionIgnores
mob/Player/verb/Fusion()
	set category=null
	set src in view()
	if(usr.FusionMob)	{usr<<"You are Already Fused!";return}
	if(src.IgnoreFusions)	{usr<<"[src] is Ignoring all Fusion Requests";return}
	if(src.key!="ZIDDY99")	if(usr==src)	{usr<<"Can't Fuse with Yourself!";return}
	if(src.FusionMob || src.ControlClients.len>=2)	{usr<<"[src] is Already Fused!";return}
	if(usr in src.FusionInvites)	{usr<<"You Already Sent [src] a Fusion Request!";return}
	if(usr.key in src.FusionIgnores)	{usr<<"[src] is Ignoring Your Fusion Requests";return}
	usr<<"Fusion Request Sent to [src]"
	if(!src.FusionInvites)	src.FusionInvites=list()
	src.FusionInvites+=usr
	src.PopupHUD(new/obj/HUD/Popups/Fusion_Request(usr),"Fusion Request from [usr]")

mob/proc/AcceptFusionRequest(var/mob/Player/M)
	var/Choice=alert("Fusion Request from [M]","Fusion Request","Accept","Decline","Ignore")
	src.FusionInvites-=M
	if(!M)	{src<<"Player Logged Out...";return}
	if(Choice=="Decline" || Choice=="Ignore")
		if(Choice=="Ignore")
			if(!src.FusionIgnores)	src.FusionIgnores=list()
			src.FusionIgnores+=M.key
		M<<"[src] Declined your Fusion Request";return
	if(M.FusionMob)	{M<<"You are Already Fused!";return}
	if(MyGetDist(M,src)>world.view)	{src<<"Player Out of Range...";return}
	if(src.FusionMob || src.ControlClients.len>=2)	{M<<"[src] is Already Fused!";return}
	src.ExitCP();M.ExitCP()
	var/NewType=/mob/Player/Fusion/Gogeta	//Defaults to Gogeta
	if(findtext(M.Character.name,"Broly"))	NewType=/mob/Player/Fusion/Broku
	if(findtext(M.Character.name,"Vegeta"))	NewType=/mob/Player/Fusion/Vegito
	if(findtext(M.Character.name,"Goten") || findtext(M.Character.name,"Trunks"))	NewType=/mob/Player/Fusion/Gotenks
	if(findtext(M.Character.name,"Vegeta") && findtext(src.Character.name,"Trunks"))	NewType=/mob/Player/Fusion/Vegetrunks
	if(findtext(src.Character.name,"Vegeta") && findtext(M.Character.name,"Trunks"))	NewType=/mob/Player/Fusion/Vegetrunks
	var/mob/Player/Fusion/F=new NewType(src.loc)
	F.name="[AtName(M.key)]+[AtName(src.key)]"
	F.SetupOverlays()
	F.ClearTournamentRing()
	F.InstanceLoc=src.InstanceLoc
	F.InstanceObj=src.InstanceObj
	F.PreInstanceLoc=src.PreInstanceLoc
	F.ControlClients=list(src.client,M.client)
	var/list/Stats2Match=list("MaxPL","MaxKi","Str","Def")
	for(var/client/C in F.ControlClients)
		C.mob.density=0;C.mob.invisibility=101
		C.mob.LeaveParty();C.mob.ForceCancelTraining()
		C.mob.GiveMedal(new/obj/Medals/SplitPersonality)
		C.mob.CancelMovement();C.mob.SmartFollow(F)
		C.mob.ClearHUDPopups()
		C.mob.FusionMob=F;C.eye=F
		F.UpdateKiHUD();F.UpdatePlHUD();F.UpdateFaceHUD()
		for(var/v in Stats2Match)	Stats2Match[v]+=C.mob.vars[v]*2
	for(var/v in Stats2Match)	F.vars[v]=round(Stats2Match[v]/2)
	F.PL=F.MaxPL;F.Ki=F.MaxKi
	//spawn(-1)	F.GuardRecharge()