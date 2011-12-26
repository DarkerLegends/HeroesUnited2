var
	LastTournHost
	TournChamp="Hercule"
	TournRound=0
	TournRounds=0
	TournStatus="Idle"
	TournPerks="Enabled"
	TournHost="Auto-Host"
	TournRegMode="Single"
	TournDamage="Balanced"
	TournPowerMode="Ki Only"
	TournPrizeZenie=10000
	list/TournEntrants=list()
	list/TournFighters=list()
	WorldTournTag="<b><font color=[rgb(0,0,255)]>World Tournament:</font>"
	obj/HUD/World_Tournament/WorldTournHUD=new()

mob/var/InTournament

var/obj/Teams/Flags/BlueTeam/BlueTeamFlag=new
var/obj/Teams/Flags/RedTeam/RedTeamFlag=new
var/list/TeamFlags=list(BlueTeamFlag,RedTeamFlag)
obj/Teams/Flags
	icon='Flags.dmi'
	layer=FLOAT_LAYER
	pixel_x=4;pixel_y=16
	BlueTeam
		icon_state="BlueTeam"
	RedTeam
		icon_state="RedTeam"

obj/HUD
	World_Tournament
		icon_state="WT"
		screen_loc="8,1"
		desc="Click to Host, View Rulings, or Register for the World Tournament!"
		MouseEntered()
			src.desc="[initial(src.desc)]\nWT Status: [global.TournStatus]"
			return ..()
		Click()
			usr.UpdateWTEntrants()
			usr.OpenedWindow("WTWindow")
			winset(usr,"WTWindow","pos=100,100;size=432x432;is-visible=true")

mob/proc/UpdateWTEntrants()
	if(!src.client)	return
	if(global.TournStatus=="Idle")	winset(src,"WTWindow.RegBtn","text=Host")
	else	winset(src,"WTWindow.RegBtn","text=Register")
	winset(src,"WTWindow.StatusLabel","text=\"Tournament Status: [global.TournStatus]\"")
	winset(src,"WTWindow.ChampLabel","text=\"Defending Champion: [global.TournChamp]\nWon the Previous Tournament after [global.TournRounds] Rounds\"")
	winset(src,"WTWindow.EntrantsLabel","text=\"[global.TournEntrants.len] World Tournament Entrants ([global.TournRegMode])\"")
	winset(src,"WTWindow.PrizeHostLabel","text=\"[FullNum(global.TournPrizeZenie)] Zenie Prize : Hosted by [global.TournHost]\"")
	winset(src,"WTWindow.DamageLabel","text=\"Damage: [global.TournDamage]\"")
	winset(src,"WTWindow.PerksLabel","text=\"Perks: [global.TournPerks]\"")
	winset(src,"WTWindow.PowerUpLabel","text=\"Power Up: [global.TournPowerMode]\"")
	var/HTML="<body bgcolor=[rgb(0,0,64)]><center><table width=100% border=1 bordercolor=[rgb(255,128,0)]>"
	if(global.TournRound)	HTML+="<tr><td NoWrap colspan=2><font color=[rgb(255,128,0)] face=comic><b><center>Round [global.TournRound] in Progress"
	var/counter=0
	for(var/v in global.TournEntrants)
		counter+=1
		if(counter%2)	HTML+="<tr><td rowspan=2 width=1% NoWrap><font color=[rgb(255,128,0)] face=comic><b>Round [global.TournRound+round(counter/2,1)]"
		else	HTML+="<tr>"
		HTML+="<td NoWrap><font color=[rgb(255,128,0)] face=comic><b>[v]"
	src<<browse(HTML,"window=WTWindow.EntrantsBrowser")

proc/UpdateWTEntrants()
	for(var/mob/M in Players)	if("WTWindow" in M.OpenWindows)	spawn(-1)	M.UpdateWTEntrants()

mob/verb/HostWT()
	set hidden=1
	if(global.LastTournHost==src.key)	{src<<"3 Minutes Between Hosting!";return}
	if(global.TournStatus!="Idle")	{src<<"A Tournament is Already in Progress!";return}
	var/ZenieInput=text2num(winget(src,"WTHostWindow.ZenieInput","text"))
	if(ZenieInput<10000)	{src<<"10,000 Zenie Minimum!";return}
	if(ZenieInput>src.Zenie)	{src<<"You can't afford that!";return}
	var/list/FirstModes=params2list(winget(src,"WTHostWindow.SingleReg;WTHostWindow.RoyaleReg;WTHostWindow.PerksEnabled;WTHostWindow.BalancedDamage","is-checked"))
	var/list/PowerUpModes=params2list(winget(src,"WTHostWindow.Both;WTHostWindow.KiOnly;WTHostWindow.PLOnly;WTHostWindow.KithenPL;WTHostWindow.PLthenKi","is-checked"))
	if(ZenieInput<10000)	{src<<"10,000 Zenie Minimum!";return}
	if(ZenieInput>src.Zenie)	{src<<"You can't afford that!";return}
	if(global.TournStatus!="Idle")	{src<<"A Tournament is Already in Progress!";return}
	src.Zenie-=ZenieInput
	global.TournHost=src.key
	global.TournPrizeZenie=ZenieInput
	if(FirstModes["WTHostWindow.SingleReg.is-checked"]=="true")	global.TournRegMode="Single"
	else	if(FirstModes["WTHostWindow.RoyaleReg.is-checked"]=="true")	global.TournRegMode="Royale"
	else	global.TournRegMode="Parties"
	if(FirstModes["WTHostWindow.PerksEnabled.is-checked"]=="true")	global.TournPerks="Enabled"
	else	global.TournPerks="Disabled"
	if(FirstModes["WTHostWindow.BalancedDamage.is-checked"]=="true")	global.TournDamage="Balanced"
	else	global.TournDamage="Stat Based"
	if(PowerUpModes["WTHostWindow.Both.is-checked"]=="true")	global.TournPowerMode="Both"
	else	if(PowerUpModes["WTHostWindow.KiOnly.is-checked"]=="true")	global.TournPowerMode="Ki Only"
	else	if(PowerUpModes["WTHostWindow.PLOnly.is-checked"]=="true")	global.TournPowerMode="PL Only"
	else	if(PowerUpModes["WTHostWindow.KithenPL.is-checked"]=="true")	global.TournPowerMode="Ki then PL"
	else	if(PowerUpModes["WTHostWindow.PLthenKi.is-checked"]=="true")	global.TournPowerMode="PL then Ki"
	else	global.TournPowerMode="Nothing"
	winset(src,"WTHostWindow","is-visible=false")
	src.GiveMedal(new/obj/Medals/Sponsor)
	src.TrackStat("WTs Hosted",1)
	global.StartTournHosting()

mob/verb/WTRegister()
	set hidden=1
	if(global.TournStatus=="Idle")
		winset(usr,"WTHostWindow.ZenieInput","focus=true;text='10000'")
		winset(usr,"WTHostWindow.ZenieLabel","text='You Currently Have [FullNum(src.Zenie)] Zenie.'")
		winset(usr,"WTHostWindow","pos=100,100;size=432x432;is-visible=true");return
	else	if(global.TournStatus!="Registering")	{alert("Registration Time is Over!","World Tournament");return}
	usr=usr.GetFusionMob()
	for(var/mob/T in usr.GetTeamList())
		for(var/mob/M in global.TournEntrants)
			for(var/client/MC in M.ControlClients)
				for(var/client/TC in T.ControlClients)
					if(MC.computer_id==TC.computer_id)
						alert("You Already Registered!","World Tournament");return
	global.TournEntrants+=usr
	global.UpdateWTEntrants()
	world<<"[global.WorldTournTag] [usr] Registered! ([global.TournEntrants.len] Entrants)"

mob/verb/WTWatch()
	set hidden=1
	var/mob/FusionMob=usr.GetFusionMob()
	if(usr.client.eye==FusionMob)	usr.client.eye=locate(289,100,1)
	else	usr.client.eye=FusionMob

var/list/TournSpawners=list()
obj/Supplemental/TournSpawner
	var/SpawnerID="1"
	New()
		global.TournSpawners+=src.SpawnerID
		TournSpawners[src.SpawnerID]=src
		return ..()

var/list/RingEdges=list()
turf/TournamentRing
	layer=10
	var/ResetDensity=0
	New()
		src.ResetDensity=src.density
		global.RingEdges+=src
		return ..()

proc/GetWTBlock()
	return block(locate(282,92,1),locate(297,107,1))

proc/StartTournHosting()
	world<<"[global.WorldTournTag] [FullNum(global.TournPrizeZenie)] Zenie Reward Hosted by [global.TournHost]!"
	world<<"[global.WorldTournTag] [global.TournRegMode] Battles, [global.TournDamage] Damage, Perks [global.TournPerks], Power Up [global.TournPowerMode]!"
	world<<"[global.WorldTournTag] Now Accepting Entrants!"
	global.TournStatus="Registering"
	global.UpdateWTEntrants()
	spawn(3*600)	if(global.TournStatus=="Registering")
		if(global.TournEntrants.len<=1)
			world<<"[global.WorldTournTag] Canceled! ([global.TournEntrants.len] Entrants)"
			for(var/mob/M in Players)	if(M.key==global.TournHost)	M.Zenie+=global.TournPrizeZenie
			EndTournament()
		else
			world<<"[global.WorldTournTag] Registration is Over! ([global.TournEntrants.len] Entrants)"
			for(var/turf/TournamentRing/R in global.RingEdges)	{R.density=1;R.SuperDensity=1}
			global.StartTournRound()

proc/LoopWorldTourn()
	while(world)
		if(global.TournStatus=="Idle")
			global.TournHost="Auto-Host"
			global.TournPrizeZenie=10000
			global.TournPerks="Enabled"
			global.TournDamage="Balanced"
			global.TournRegMode="Single"
			global.TournPowerMode="Ki Only"
			global.StartTournHosting()
		sleep(10*600)

mob/proc/QuitTournament(var/Reason="Forfeit?")
	if(src.InTournament)	src.LoseTournRound(Reason)
	if(src in global.TournEntrants)
		global.TournEntrants-=src;global.UpdateWTEntrants()
		world<<"[global.WorldTournTag] [src] Resigned ([Reason]) ([global.TournEntrants.len] Entrants Remaining)"
		if(global.TournRegMode=="Parties" && Reason!="Duplicate Party" && src.Party)	for(var/mob/M in src.Party-src)	if(M.ControlClients)
			global.TournEntrants+=M;global.UpdateWTEntrants()
			world<<"[global.WorldTournTag] [M] Registered (Party Replacement) ([global.TournEntrants.len] Entrants)";break

mob/proc/TournTeamLeft()
	for(var/mob/M in global.TournFighters-src)	if(global.TournFighters[M]==global.TournFighters[src])	return 1

mob/proc/LoseTournRound(var/Reason="Forfeited?",var/mob/Winner)
	if(src.InTournament)
		var/SrcTeamLeft=src.TournTeamLeft()
		src.InTournament=0;src.overlays-=global.TeamFlags
		src.Team=null;src.PowerMode=src.PreferredPowerMode
		global.TournFighters-=src;global.UpdateWTEntrants()
		src.ClearTournamentRing();src.JoinMissionCheck()
		if(!SrcTeamLeft)
			for(var/mob/M in src.GetTeamList())
				global.TournEntrants-=M
				M.TrackStat("WT Rounds Lost",1)
			if(!Winner)	Winner=global.TournFighters[1]
			world<<"[global.WorldTournTag] [Winner] Advances! ([src] [Reason])"
			if(global.TournRegMode=="Royale")	{global.TournRound+=1;global.UpdateWTEntrants()}
			if(global.TournRegMode=="Parties")	if(!Winner.Party || Winner.Party.len<=1)	if(src.Party && src.Party.len>=2)	Winner.GiveMedal(new/obj/Medals/IStandAlone)
			for(var/mob/M in Winner.GetTeamList())
				M.AddExp(100*100,"Won WT Round")
				M.TrackStat("WT Rounds Won",1)
				M.overlays-=global.TeamFlags
				if(global.TournRegMode!="Royale")
					M.Team=null
					M.InTournament=0
					M.JoinMissionCheck()
					M.PowerMode=M.PreferredPowerMode
					M.AddPlPercent(100);M.AddKiPercent(100)
			if(global.TournRegMode!="Royale" || global.TournFighters.len==1)
				if(global.TournRegMode=="Royale")
					Winner.Team=null
					Winner.InTournament=0
					Winner.JoinMissionCheck()
					Winner.PowerMode=Winner.PreferredPowerMode
					Winner.AddPlPercent(100);Winner.AddKiPercent(100)
				global.TournFighters=list()
				global.StartTournRound()

mob/proc/ClearTournamentRing(/**/)
	if(src.z==1 && global.TournStatus!="Idle" && global.TournStatus!="Registering")
		if(src.x>=282 && src.x<=297)
			if(src.y>=92 && src.y<=107)
				if(!src.InTournament)
					src.loc=locate(rand(284,295),rand(86,88),1)

proc/EndTournament()
	global.TournRound=0
	global.TournStatus="Idle"
	global.TournEntrants=list()
	global.UpdateWTEntrants()
	for(var/turf/TournamentRing/R in global.RingEdges)	{R.density=R.ResetDensity;R.SuperDensity=0}

mob/proc/GetTeamList()
	var/list/TeamList=list(src)
	if(global.TournRegMode=="Parties" && src.Party && src.Party.len)	TeamList=src.Party
	return TeamList

proc/StartTournRound()
	if(global.TournEntrants.len==1)
		var/mob/Winner=global.TournEntrants[1]
		global.LastTournHost=global.TournHost
		spawn(3*600)	global.LastTournHost=null
		world<<"[global.WorldTournTag] [Winner] has Won the World Tournament!"
		world<<"[global.WorldTournTag] [Winner] was Rewarded [FullNum(global.TournPrizeZenie)] Zenie and [FullNum(100*global.TournRound)] Levels!"
		for(var/mob/M in Winner.GetTeamList())
			M.InTournament=0
			M.TrackStat("World Tournaments Won",1)
			M.GiveMedal(new/obj/Medals/WorldChampion)
			if(global.TournRegMode=="Royale")	M.GiveMedal(new/obj/Medals/RoyaleRoyalty)
			if(global.TournHost==M.key)	M.GiveMedal(new/obj/Medals/Refunded)
			if(M.key==global.TournChamp)	M.GiveMedal(new/obj/Medals/TitleDefender)
			if(global.TournRegMode=="Parties" && M.Party)	M.AddZenie(round(global.TournPrizeZenie/max(1,M.Party.len)))
			else	M.AddZenie(global.TournPrizeZenie)
			M.AddExp(100*global.TournRound*100,"Won Tournament")
		global.TournRounds=global.TournRound;global.TournChamp=Winner.key
		EndTournament()
		return
	global.TournRound+=1
	global.TournStatus="Face-Off"
	for(var/mob/M in world)
		M.InTournament=0;M.ClearTournamentRing()
	global.TournFighters=list()
	var/TotalTeams=2
	if(global.TournRegMode=="Royale")	TotalTeams=global.TournEntrants.len
	for(var/i=1;i<=TotalTeams;i++)
		for(var/mob/E in global.TournEntrants)
			global.TournEntrants-=E
			global.TournEntrants+=E
			var/TeamMember=0
			for(var/mob/M in E.GetTeamList())
				TeamMember+=1
				M.InTournament=1
				M.Team="Team [i]"
				global.TournFighters+=M
				global.TournFighters[M]="Team [i]"
				M.ExitCP();M.PowerMode=global.TournPowerMode
				M.ForceCancelFlight();M.ForceCancelTraining()
				if(global.TournRegMode!="Parties")	M.DismissNPCs()
				if(global.TournRegMode=="Royale")	M.loc=locate(rand(284,295),rand(94,105),1)
				else
					var/obj/Supplemental/TournSpawner=global.TournSpawners["P[i]S[TeamMember]"]
					M.CancelSmartFollow();M.loc=TournSpawner.loc;M.dir=TournSpawner.dir
				M.AddTeamFlag()
				M.AddPlPercent(100);M.AddKiPercent(100)
				if(M.icon_state=="koed")	M.ResetIS()
				spawn()	if(M)	M.CountDown("Round Starts in",10)
				if(M.Dueling)
					if(M.DuelFlag)
						M.TrackStat("[M.DuelFlag.DuelType] Duels Exited (WT)",1)
						M.Dueling.TrackStat("[M.DuelFlag.DuelType] Duels Canceled",1)
					M<<"Duel Canceled; Entered Tournament!"
					M.Dueling<<"Duel Canceled; [src] Entered Tournament!"
					M.EndDuel()
			break
	world<<"[WorldTournTag] Round [global.TournRound]: [global.TournFighters[1]] vs [global.TournFighters[2]] ([global.TournEntrants.len] Entrants Remaining)"
	global.UpdateWTEntrants()
	var/ThisRound=global.TournRound
	spawn(100)
		if(ThisRound==global.TournRound)	global.TournStatus="Battle"
		else	if(global.TournRegMode=="Royale" && global.TournStatus=="Face-Off")	global.TournStatus="Battle"
	spawn(3*600)	if(ThisRound==global.TournRound)
		var/mob/Loser=pick(global.TournFighters)
		for(var/mob/L in global.TournFighters)	if(L.PL/L.MaxPL<Loser.PL/Loser.MaxPL)	Loser=L
		Loser.LoseTournRound("Time Up")