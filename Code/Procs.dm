proc
	PlaySound(var/Hearers,file,repeat=0,wait,channel,VolChannel="Effect")
		if(ismob(Hearers))	for(var/client/C in Hearers:ControlClients)
			var/mob/M=C.mob;if(M.vars["Volume[VolChannel]"] && !M.VolumeMuteAll)	M<<sound(file,repeat,wait,channel,M.vars["Volume[VolChannel]"])
		else	for(var/mob/H in Hearers)	for(var/client/C in H.ControlClients)
			var/mob/M=C.mob;if(M.vars["Volume[VolChannel]"] && !M.VolumeMuteAll)	M<<sound(file,repeat,wait,channel,M.vars["Volume[VolChannel]"])

	GetPercent(var/Percent,var/Total)
		return round(Total*(Percent/100))

	FullNum(var/eNum,var/ShowCommas=1)
		eNum=num2text(round(eNum),99)
		if(ShowCommas && length(eNum)>3)
			for(var/i=1;i<=round(length(eNum)/4);i++)
				var/CutLoc=length(eNum)+1-(i*3)-(i-1)
				eNum="[copytext(eNum,1,CutLoc)],[copytext(eNum,CutLoc)]"
		return eNum

atom/movable/var/atom/SmartFollowID
atom/movable/var/atom/SmartFollowTarget
atom/movable/proc/SmartFollow(var/atom/Target,var/FollowDist=0,var/Speed=0)
	walk_to(src,Target,FollowDist,Speed)
	src.SmartFollowTarget=Target
	src.SmartFollowID=rand(1,999999)
	var/ThisID=src.SmartFollowID
	spawn()	while(src.SmartFollowID==ThisID && Target)
		if(MyGetDist(src,Target)>world.view)
			src.loc=Target.loc
			walk_to(src,Target,FollowDist,Speed)
		sleep(5)

atom/movable/proc/CancelSmartFollow()
	src.SmartFollowTarget=null
	src.SmartFollowID=null
	walk(src,0)

mob/proc/SetTeam(var/NewTeam)
	for(var/mob/M in src.Party)	if(M.Owner==src)	M.Team=NewTeam
	src.Team=NewTeam

mob/proc/CombatTime()
	src.InCombat+=1
	spawn(50)	src.InCombat-=1

/*mob/proc/GuardRecharge(/**/)
	while(1)
		if(!src.GuardBroken && src.GuardLeft<100)
			if(src.icon_state!="Guard")
				if(!src.HitStun || src.HasPerk("Combat Shield"))
					if(src.CanBeHit())
						src.GuardLeft=min(100,src.GuardLeft+1)
						src.UpdateGuardHUD()
		sleep(1)*/

mob/var/list/KeysHeld
mob/var/list/KeysTapped
mob/proc/PressKey(var/Key)
	if(!src.KeysHeld)	src.KeysHeld=list()
	if(!(Key in src.KeysHeld))	src.KeysHeld+=Key
	if(!src.KeysTapped)	src.KeysTapped=list()
	src.KeysTapped+=Key
	spawn(2)	src.KeysTapped-=Key
mob/proc/ReleaseKey(var/Key)
	if(!src.KeysHeld)	src.KeysHeld=list()
	src.KeysHeld-=Key
mob/proc/HoldingKey(var/Key)
	if(Key in src.KeysHeld)	return 1

mob/proc/PM(var/mob/M)
	src.CreatePrMsgWindow(M)
	winset(src,"PrMsg[M.key]","is-minimized=false;is-visible=true")
	winset(src,"PrMsg[M.key].PrMsgInput","focus=true")

proc/MyProb(var/Percent)
	if(rand(1,100)<=Percent)	return 1

proc/UpdateChatRoomWho(var/ThisRoom)
	if(ThisRoom in ChatRooms)
		var/list/PlayerList=ChatRooms[ThisRoom]
		var/HTML="<body bgcolor=[rgb(255,128,0)]><center><b><u>[PlayerList.len] Chatters</u><br>"
		for(var/mob/M in PlayerList)	HTML+="[M]<br>"
		for(var/mob/M in PlayerList)	M<<browse(HTML,"window=[ThisRoom].ChattersBrowser")

mob/proc/UpdateLastOnline()
	src.LastOnline=time2text(world.timeofday,"YYMMDD")
	if(src.Clan)
		if(!(src.key in src.Clan.LastOnlineMembers))	src.Clan.LastOnlineMembers+=src.key
		src.Clan.LastOnlineMembers[src.key]=src.LastOnline

mob/proc/CreatePrMsgWindow(var/mob/M)
	if(!("PrMsg[M.key]" in src.OpenWindows))
		src.OpenedWindow("PrMsg[M.key]")
		winclone(src,"PrMsgWindow","PrMsg[M.key]")
		winset(src,"PrMsg[M.key].PrMsgInput","command='PrivateMessage [M.key], '")
		winset(src,"PrMsg[M.key]","title='PM: [M.key]';pos=100,100;size=400x300;on-close='ClosedWindow PrMsg[M.key]'")
		return 1

var/list/MonthDays=list(31,28,31,30,31,30,31,31,30,31,30,31)
proc/ReadableLastDate(var/BaseDate)
	if(!BaseDate)	return "Unknown"
	if(BaseDate==time2text(world.timeofday,"YYMMDD"))	return "Earlier Today"

	var/LastDay=text2num(copytext(BaseDate,5))
	var/ThisDay=text2num(time2text(world.timeofday,"DD"))
	var/DaysOffline=ThisDay-LastDay

	var/LastMonth=text2num(copytext(BaseDate,3,5))
	var/ThisMonth=text2num(time2text(world.timeofday,"MM"))
	var/MonthsOffline=ThisMonth-LastMonth

	var/LastYear=text2num(copytext(BaseDate,1,3))
	var/ThisYear=text2num(time2text(world.timeofday,"YY"))
	var/YearsOffline=ThisYear-LastYear

	if(YearsOffline>=1)
		if(LastMonth>ThisMonth)	{YearsOffline-=1;MonthsOffline=ThisMonth+12-LastMonth}
		if(LastMonth==ThisMonth)	if(LastDay>ThisDay)	{YearsOffline-=1;MonthsOffline=11;DaysOffline=ThisDay+MonthDays[LastMonth]-LastDay}
	if(MonthsOffline>=1)	if(LastDay>ThisDay)	{MonthsOffline-=1;DaysOffline=ThisDay+MonthDays[LastMonth]-LastDay}

	var/DateTag=""
	if(YearsOffline)	DateTag+="[YearsOffline] Years"
	if(MonthsOffline)
		if(DateTag)	DateTag+=", "
		DateTag+="[MonthsOffline] Months"
	if(DaysOffline)
		if(DateTag)	DateTag+=", "
		if(DateTag || DaysOffline>1)	DateTag+="[DaysOffline] Days"
		else	return "Yesterday"
	return "[DateTag] Ago"

var/list/Locations=list("West City","Hercule City","World Tournament","Kamis Lookout","Kame House")
mob/proc
	GhostMode(var/RespawnTime=15)
		spawn(-1)
			src.Revert()
			src.DropFlag("Died")
			src.GhostMode=1
			src.icon='Ghost.dmi'
			src.TakeKiPercent(100)
			src.TakePlPercent(100)
			for(var/mob/CombatNPCs/M in oview(src))	if(M.Target==src)	M.TargetMob()
			src.CountDown("Respawn in",RespawnTime)
			if(src.GhostMode)	{src.GhostMode=2;src.UpdateHUDText("TrainingDesc","Press E to Respawn!")}
	OnlineFriends()
		var/FriendsOnline=0
		var/WatchersOnline=0
		for(var/mob/M in Players)
			if(M.key in src.Friends)	{src.OnlineFriends+=M;FriendsOnline+=1}
			if(src.key in M.Friends)	{M.OnlineFriends+=src;WatchersOnline+=1}
		src<<"[FriendsOnline] Friends Online.  [WatchersOnline] Watchers."
	DisplayPlayTime(/**/)
		var/DisplayHours="[src.PlayTimeHours]";while(length(DisplayHours)<1)	DisplayHours="0[DisplayHours]"
		var/DisplayMinutes="[src.PlayTimeMinutes]";while(length(DisplayMinutes)<2)	DisplayMinutes="0[DisplayMinutes]"
		var/DisplaySeconds="[src.PlayTimeSeconds]";while(length(DisplaySeconds)<2)	DisplaySeconds="0[DisplaySeconds]"
		return "[DisplayHours]h [DisplayMinutes]m [DisplaySeconds]s"
	Locate(var/Location)
		switch(Location)
			if("Hercule City")	src.loc=locate(rand(314,318),rand(228,231),1)
			if("West City")	src.loc=locate(rand(183,186),rand(212,215),1)
			if("World Tournament")	src.loc=locate(rand(286,293),rand(47,55),1)
			if("Kamis Lookout")	src.loc=locate(rand(95,97),rand(170,175),1)
			if("Kame House")	src.loc=locate(rand(346,356),rand(109,112),1)
	CountDown(var/Msg="Round Starts in",var/Timer=10)
		for(var/i=Timer;i>=1;i--)
			src.UpdateHUDText("TrainingDesc","[Msg] [i] Seconds!")
			PlaySound(src,'Beep.ogg')
			sleep(10)
		src.UpdateHUDText("TrainingDesc")
	ForceCancelFlight()
		if(!src.density)
			src.icon_state=""
			src.RemoveAura("Fly")
			src.layer=4;src.density=1
			src.overlays-=FlightShadow
	FillStatsGrid()
		var/Column=0
		for(var/obj/O in AllStats)
			Column+=1
			src<<output(O,"StatsTab.StatsGrid:1,[Column]")
			src<<output(O.suffix,"StatsTab.StatsGrid:2,[Column]")
	ScreenShake()
		for(var/client/C in src.ControlClients)
			for(var/i=1;i<=5;i++)
				var/PickedAmt=rand(4,8)
				var/PickedDir=pick("pixel_x","pixel_y")
				C.vars[PickedDir]+=PickedAmt
				sleep(1);if(!src || !C)	return
				C.vars[PickedDir]-=PickedAmt
	GetAuraType(/**/)
		if(src.CurTrans)
			if(src.TransDatum && src.TransDatum.CustAura)	return "[src.TransDatum.CustAura]Energy"
			if(findtext("[src.icon]","SS4"))	return "RedEnergy"
			if(findtext(src.Character.Race,"Saiyan"))	return "YellowEnergy"
		return "[src.Character.Aura]Energy"
	AddAura(var/AuraTag)
		src.overlays-=src.Aura
		if(!src.Aura)	src.Aura=new
		src.Aura.icon_state="[src.GetAuraType()][AuraTag]"
		src.Aura.layer=src.layer-0.1
		src.overlays+=src.Aura
	RemoveAura(var/AuraTag)
		if(!src.Aura)	return
		if(!AuraTag)	src.overlays-=src.Aura
		else	if(findtext(src.Aura.icon_state,AuraTag))	src.overlays-=src.Aura
	RespecPerks()
		src.UnlockedPerks=list("Empty")
		src.PerkPoints=round(src.GetRebirthLevel()/10000)
		src.SlottedPerks=list("Empty","Locked Slot","Locked Slot")
		src<<"<b><font size=4 color=red>Respec: Your Character's Perks have been Reset!"
	RespecStats(/**/)
		src.TraitPoints=src.GetRebirthLevel()-1
		src.MaxPL=initial(src.MaxPL)
		src.PL=src.MaxPL
		src.MaxKi=initial(src.MaxKi)
		src.Ki=src.MaxKi
		src.Str=initial(src.Str)
		src.Def=initial(src.Def)
		src.Traits=initial(src.Traits)
		src<<"<b><font size=4 color=red>Respec: Your Character's Stats have been Reset!"
	FullRespec(/**/)
		src.RespecStats()
		src.RespecPerks()
	CanBeHit(/**/)
		if(src.GhostMode)	return
		if(src.TeleCountering)	return
		if(src.invisibility==101)	return
		if(src.icon_state=="Beam")	return
		return 1
	CanPVP(var/mob/M)
		if(!src || !M)	return
		if(src.GhostMode || M.GhostMode)	return
		if(src.CounterBeamMob || M.CounterBeamMob)	return
		if(src.ButtonComboing || M.ButtonComboing)	return
		if(!src.ControlClients || !M.ControlClients)
			if(src.StartTarget && src.StartTarget!=M)	return
			if(M.StartTarget && M.StartTarget!=src)	return
			if(src.Team==M.Team)	return
			return 1
		if(src.InTournament && M.InTournament && global.TournStatus=="Battle" && global.TournFighters[src]!=global.TournFighters[M])	return 1
		if(src.InstanceObj)
			if(src.InstanceObj.IsPvpType("Clan Only"))	if(src.Clan!=M.Clan)	return 1
			else	if(src.InstanceObj.IsPvpType("Standard") || src.InstanceObj.IsPvpType("Balanced"))	return 1
		if(src.Dueling==M || M.Dueling==src)	return 1
	LoopMap()
		if(src.x<=world.view)	src.loc=locate(world.maxx-world.view-1,src.y,src.z)
		if(src.y<=world.view)	src.loc=locate(src.x,world.maxy-world.view-1,src.z)
		if(src.x>=world.maxx-world.view)	src.loc=locate(world.view+1,src.y,src.z)
		if(src.y>=world.maxy-world.view)	src.loc=locate(src.x,world.view+1,src.z)
	ResetSuffix(/**/)
		src.suffix="<font size=1>Level [FullNum(src.Level)] [src.Character.Race]"
		if(src.Clan)	src.suffix+="<br>Lvl.[src.ClanRank.Level] [src.ClanRank] of {[src.Clan]}"
		if(src.Title)	src.suffix+="<br>[src.Title]"
	ResetTeleCounters(var/ThisID)
		if(!ThisID || ThisID==src.TeleCounteringID)
			src.ITing=0;src.TeleCountering=null;src.TeleCounteringID=null
	GuardTap(var/mob/Attacker)
		var/GoAhead
		if(src.TeleCounteringID)	return
		if(src.BeamOverCharge==20 && src.icon_state=="charge" && !src.CounterBeamMob && src.HasPerk("IT KameHameHa"))
			flick("IT",src);PlaySound(view(),'InstantTransmission.ogg')
			var/turf/T=get_step(Attacker,get_dir(src,Attacker))
			if(T && T.Enter(src))	src.loc=T
			src.dir=get_dir(src,Attacker)
			src.BeamOverCharge=0;src.Beam()
			src.TakeKiPercent(100)
			return 2
		if(src.GuardTapping)
			var/KiRequired=20
			if(src.HasPerk("Teleport Efficiency"))	KiRequired=10
			if(src.UseKiPercent(KiRequired))	GoAhead=1
		else	if(src.HasPerk("After Image") && src.UseKiPercent(40))	GoAhead=1
		if(GoAhead)
			src.PowerUpRelease();src.ITing=1
			src.ThrownDamage=null;src.EndKnockBack()
			flick("IT",src);PlaySound(view(),'InstantTransmission.ogg')
			src.TeleCounteringID=rand(1,999999)
			var/ThisID=src.TeleCounteringID
			src.TeleCountering=Attacker
			spawn(5)
				if(!Attacker)	{src.ResetTeleCounters(ThisID);return}
				if(MyGetDist(src,Attacker)>world.view || !src.CanPVP(Attacker))	{src.ResetTeleCounters(ThisID);return}
				var/turf/T=get_step(Attacker,get_dir(src,Attacker))
				Attacker.ThrownDamage=null;Attacker.EndKnockBack()
				if(T && T.Enter(src))	src.loc=T
				src.dir=get_dir(src,Attacker)
				src.loc.Entered(src)
			spawn(10)
				if(!Attacker)	{src.ResetTeleCounters(ThisID);return}
				if(MyGetDist(src,Attacker)>world.view || !src.CanPVP(Attacker))	{src.ResetTeleCounters(ThisID);return}
				if(!src.TeleCountering || src.TeleCounteringID!=ThisID)	return
				flick("kick1",src);PlaySound(view(),'HitHeavy.ogg')
				if(Attacker.icon_state!="Guard")
					ShowEffect(Attacker,"HyperCombat",16,16)
					Attacker.Blocked("Tele Counter",src,20)
					Attacker.AddKiPercent(10)
					src.StandardDamage(Attacker,src.Str,1)
					Attacker.HitStun(0,src)
					if(!src.HasPerk("Weakling"))	src.Throw(Attacker,7,src.dir)
				src.ResetTeleCounters()
			return 1
	TargetMob(var/mob/M)
		if(src.Target==M)	return
		if(ismob(src.Target))	src.Target.Targeters-=src
		if(M)
			if(!src.ControlClients && src.Team==M.Team)	return
			if(!M.ControlClients && !src.ControlClients)	if(M.Team==src.Team)	return
			if(!src.ControlClients && src.Target && src.Target.icon_state=="koed")	M.GiveMedal(new/obj/Medals/Savior)
		src.Target=M
		if(ismob(M))
			M.Targeters+=src
			src.UpdateEnemyHUD()
			src.UpdateReverseHUDText("EnemyName",AtName(M.name))
		else
			src.UpdateEnemyHUD()
			src.UpdateReverseHUDText("EnemyName","No Target")