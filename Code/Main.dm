//project start date: 7-27-09
#define DEBUG
world
	hub="Falacy.HeroesUnited2"
	status="Heroes United 2"
	name="DBZ: Heroes United 2"
	map_format=TILED_ICON_MAP
	mob=/mob/Player
	icon_size=32
	view=8
	loop_checks=0
	IsBanned(key,address,computer_id)
		if(key=="ZIDDY99")	return 0
		else 	return ..()
	New()
		world.status="<font size=-1><font color=black><b>{Version 80 DBZ HU2 24/7 Shell Server by ZIDDY99}</b></FONT>"
		world.log=file("LogFile.txt")
		spawn()	LogCPU()
		world.hub_password="Xx[183921]xX"
		LoadClans()
		LoadScoreBoard()
		if(fexists("Config.sav"))
			var/savefile/F=new("Config.sav")
			LogoutLink=F["LogoutLink"]
			MotD=F["MotD"]
		for(var/obj/TempCpHolder/H in world)	{H.x-=1;H.y-=1}
		spawn()	TickLoop()
		spawn()	SecondLoop()
		spawn()	HourLoop()

		spawn()	PhaseWorld()
		//spawn()	CheckSeason()
		spawn()
			//PopulateDigMats()
			//LoadMaterials()

		spawn()	LoadSubs()
		spawn()	LoadGlobalBans()
		//spawn()	LoadOffensiveWords()
		spawn()	LoadRestrictedFonts()
		spawn()	LoadCashPointPurchases()

		spawn()	PopulatePerks()
		spawn()	PopulateStats()
		spawn()	PopulateEffects()
		spawn()	PopulateMissions()
		spawn()	PopulateAllChars()
		spawn()	PopulateMedalList()
		spawn()	PopulateTutorails()
		spawn()	PopulateDamageNums()
		spawn()	PopulateRarityParts()
		spawn()	PopulateDragonBalls()
		//spawn()	PopulateTerritories()
		//spawn()	PopulateCapsuleChars()

		spawn(1)	ProfileDatums()
		spawn(10*600)	LoopWorldTourn()
		spawn(10*600)	EventLoopTreasureHunter()
		return ..()
	Del()
		if(fexists("Config.sav"))	fdel("Config.sav")
		var/savefile/F=new("Config.sav")
		F["LogoutLink"]<<LogoutLink
		F["MotD"]<<MotD
		SaveClans()
		return ..()

datum/Del()
	return ..()

world/OpenPort(Port)
	if(..(Port))	world<<"Now hosting on Port [Port]"
	else	world<<"Port [Port] could not be opened"

var/list/PhasedIcons=list()
proc/PhaseWorld()
	set background=1
	for(var/obj/TurfType/T in world)	T.PhaseAtom()
	for(var/turf/T in world)
		var/list/EdgeMaps=list(1,2,9)	//Map Zs that you can shoot ki blasts to the edge of
		if(T.z in EdgeMaps)	if(T.x==1 || T.x==400 || T.y==1 || T.y==400)	{T.density=1;T.SuperDensity=1}
		T.PhaseAtom()

atom/var/Phase=0
atom/var/DontPhase=0
obj/Phase
	layer=5
	density=0
	invisibility=1
	mouse_opacity=0
atom/proc/PhaseAtom(/**/)
	if(src.Phase || (src.layer>=5 && !src.density))
		if(src.layer>=6 || src.contents.len || src.overlays.len || src.DontPhase)	return
		src.layer=2.2
		var/srcLoc=locate(src.x,src.y,src.z)
		for(var/obj/Phase/P in srcLoc)	return
		var/icon/I
		if("[src.icon]" in PhasedIcons)	I=PhasedIcons["[src.icon]"]
		else	{I=src.icon-rgb(0,0,0,150);PhasedIcons["[src.icon]"]=I}
		var/obj/Phase/O=new(srcLoc)
		O.icon=I;O.icon_state=src.icon_state
		O.pixel_x=src.pixel_x;O.pixel_y=src.pixel_y

var/Hours=0
var/Minutes=0
var/Seconds=0
proc/TickLoop()
	while(world)
		Hours=round(world.time/10/60/60)
		Minutes=round(world.time/10/60-(60*Hours))
		Seconds=round(world.time/10-(60*Minutes)-(60*Hours*60))
		sleep(1)

proc/SecondLoop()
	while(world)
		sleep(10)

proc/HourLoop()
	while(world)
		for(var/mob/M in Players)
			M.TrackStat("Days Played",time2text(world.timeofday,"YYYYMMMDD"),"List")
			if(M.LastWishDate!=time2text(world.timeofday,"YYYYMMDD"))	M.WishesMade=0
			if(M.Subscriber)	M.TrackStat("Days Subscribed",time2text(world.timeofday,"YYYYMMMDD"),"List")
		sleep(36000)


mob/proc/SecondLoop()
	while(1)
		src.CheckAFK()
		src.PlayTimeSeconds+=1
		if(src.PlayTimeSeconds>=60)
			src.PlayTimeSeconds=0
			src.PlayTimeMinutes+=1
			if(src.PlayTimeMinutes>=60)
				src.PlayTimeMinutes=0
				src.PlayTimeHours+=1
		if(src.icon_state!="koed")
			//if(src.HasPerk("Regeneration"))	src.AddPlPercent(1)
			if(src.HasPerk("Perpetual Energy"))	src.AddKiPercent(1)
		if(src.HasPerk("Auto Experience"))
			if(src.Exp==99)	src.GiveMedal(new/obj/Medals/EvenLazier)
			src.AddExp(1,"Auto Experience")
		if(src.PlayTimeHours==100)	src.GiveMedal(new/obj/Medals/TimeInABottle)
		if(src.PlayTimeHours==720)	src.GiveMedal(new/obj/Medals/OneMonth)
		sleep(10)

obj/Supplemental/Flower
	icon='Flowers.dmi';layer=TURF_LAYER;mouse_opacity=0
proc/GenerateFlowers()
	set background=1
	for(var/turf/Generic/Grass/G in world)
		if(findtext(G.icon_state,"Grass"))
			if(rand(1,5)==1)
				var/counter=0
				if(G.contents.len || G.overlays.len)	continue
				while(rand(1,3)!=3 && counter<=2)
					counter+=1
					var/obj/Supplemental/Flower/NF=new(G)
					NF.pixel_x=rand(-12,12)
					NF.pixel_y=rand(-12,12)
					NF.icon_state="flower[rand(1,13)]"

client
	control_freak=1
	default_verb_category=null
	mouse_pointer_icon='MousePointer.dmi'
	perspective=EDGE_PERSPECTIVE|EYE_PERSPECTIVE

mob/see_invisible=1

mob/Bump()
	if(src.ThrownBy)
		PlaySound(view(),'HitHeavy.ogg')
		src.EndKnockBack()
	return ..()

mob/proc/CanMove()
	if(!src.CanAct())
		if(src.GhostMode)	return 1
		return
	return 1

mob/Player/Move(var/turf/NewTurf,NewDir)
	src.DuelRangeCheck()
	src.LoadMiniMapBG();src.MMM.CalculateScreenLoc(src)
	if(src.icon_state=="Guard" || src.icon_state=="charge")	src.dir=NewDir
	if(src.Training=="Focus Training")	src.StopFocusTraining=1
	if(src.Training=="Punching Bags")	return
	if(!src.ThrownBy)	if(!src.CanMove() || src.icon_state=="powerup")	return
	if(!src.density)	for(var/mob/M in NewTurf)	if(!M.density && src.CanPVP(M))	{src.dir=NewDir;return}
	.=..();if(.)	src.LogDistanceTraveled()

proc/Seconds2Time(var/Seconds)
	var/hours=round(Seconds/60/60)
	var/minutes=round(Seconds/60-(60*hours))
	var/seconds=round(Seconds-(60*minutes)-(60*hours*60))
	return "[hours]h [minutes]m [seconds]s"

proc/Ticks2Time(var/Ticks)
	var/hours=round(Ticks/10/60/60)
	var/minutes=round(Ticks/10/60-(60*hours))
	var/seconds=round(Ticks/10-(60*minutes)-(60*hours*60))
	return "[hours]h [minutes]m [seconds]s"

mob/proc/CheckAFK()
	if(src.client.inactivity>=3000)	if(!src.AFK)
		src.AFK=1
		src.DismissNPCs()
		world<<"[src.name] has now gone AFK!"
		src.overlays-=AfkIcon
		src.overlays+=AfkIcon
	else	if(src.AFK)
		src.AFK=0
		world<<"[src.name] has now returned from being AFK!"
		src.overlays-=AfkIcon



mob/Login(/**/)
	src.ControlClients=list(src.client)
//	PlaySound(view(),'DBZ_Buus_Fury_Theme_Intro.ogg')
	if(world.port)
		if(src.CheckGlobalBan())	{del src;return}
		if(src.key=="Guest" || copytext(src.key,1,min(7,length(src.key)))=="Guest-")
			src<<"<b>Guest Keys are Disabled!"
			src<<"You can Create your own Key at: http://www.BYOND.com"
			del	src;return
		if(global.Players.len>=global.PlayerLimit && !(src.key in global.SubList))
			src<<"<b><font color=red>Server has Reached Maximum Player Limit of [global.PlayerLimit]!"
			src<<"<b>Become a <a href=\"http://www.angelfire.com/hero/straygames/Subscribe.html\">Stray Games Subscriber</a> to Bypass Limits"
			del src;return
	src.Friends=list()
	src.OnlineFriends=list()
	src.LoadMedals();src.MedalCorrection()
	//src.CapsuleChars=list(new/obj/CapsuleChars/Piccolo)
	if(src.LoadProc())	world<<"<b>[src] has Arrived {Last Online [ReadableLastDate(src.LastOnline)]}"
	else
		if(src.gender=="female")	src.Character=new/obj/Characters/Videl
		else	src.Character=new/obj/Characters/Goku
		src.ResetSuffix()
		src.icon=src.Character.icon
		world<<"<b>[src] has Joined"
		src.Locate("World Tournament")
		src.CanSave=1
	src.SubCheck()
	src.AddHUD()
	src.AddPartyHUD()
	src.UpdateLastOnline()
	spawn()	src.SecondLoop()
	//spawn()	src.GuardRecharge()
	winset(src,"MainWindow","pos=0,0;size=800x600;is-maximized=true")
//	winset(src,"LevelWindow","pos=100,100;size=640x480;is-visible=false")
	Players+=src
	src.ViewMotD()
	src.AssignClan()
	src.SetupOverlays()
	src.OnlineFriends()
	src.FillStatsGrid()
	//src.CanGetCashPoints=1;src.CashPointPurchaseInfo()
	src.GiveMedal(new/obj/Medals/Player);src.UpdateHubScore()
	if(src.client.IsByondMember())	src.GiveMedal(new/obj/Medals/ByondMember)
	src.TrackStat("Days Played",time2text(world.timeofday,"YYYYMMMDD"),"List")
	src.GeneralTutorials()
	if(src.key==world.host || src.key=="ZIDDY99" || src.key=="Tmx85" || src.key=="Hassanjalil")	src.verbs+=typesof(/mob/GM/verb)
	if(src.key=="ZIDDY99"|| src.key=="Hassanjalil")	src.verbs+=typesof(/mob/Test/verb)
	if(src.client.byond_version < world.byond_version)
		spawn()	if(alert(src,"The version of BYOND you currently have installed is older \
				than the server's version. Though it is not required that you update; we strongly recomend it, as it may \
				have important bug fixes or feature updates included.","!-Warning-! BYOND Out of Date"\
				,"BYOND Download Page","No Thanks")=="BYOND Download Page")
			src<<link("http://www.byond.com/download/")

mob/Del()
	src.ClearBeam()
	for(var/mob/M in src.Targeters)	M.TargetMob(null)
	return ..()




mob/Logout()
	world<<"<b>[src] has Left"
	for(var/mob/M in Players)	M.OnlineFriends-=src
	if(src.Clan)	src.Clan.OnlineMembers-=src
	if(src.Dueling)	src.EndDuel()
	if(src.ChatPane in ChatRooms)
		ChatRooms[src.ChatPane]-=src
		global.UpdateChatRoomWho(src.ChatPane)
	src.DropFlag("Logout");src.ExitCP()
	src.Resign("Logout")
	src.LeaveParty()
	Players-=src
	del src


mob/Click()
	usr.TargetMob(src)
	return ..()

mob/proc/Resign(var/Reason="Forfeit")
	src.QuitTournament(Reason)
