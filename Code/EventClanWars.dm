var/ClanWarsMode="Idle Mode"
var/ClanWarsStatus="Idle"
var/list/ClanWarsEntrants=list()
var/datum/Clan/ClanWarsWinner

obj/HUD
	Clan_Wars
		icon_state="CW"
		screen_loc="6,1"
		desc="Clan Wars"
		MouseEntered()
			src.desc="Clan Wars Mode: [global.ClanWarsMode]\nClan Wars Status: [global.ClanWarsStatus]\n[global.ClanWarsEntrants.len] Entrants"
			return ..()
		Click()
			usr.UpdateCWEntrants()
			usr.OpenedWindow("ClanWarsWindow")
			winset(usr,"ClanWarsWindow","pos=100,100;size=432x432;is-visible=true")

mob/proc/UpdateCWEntrants()
	if(!src.client)	return
	winset(src,"ClanWarsPane","title='Clan Wars - [global.ClanWarsMode]'")
	winset(src,"ClanWarsPane.ChampLabel","text=\"Clan Wars - [global.ClanWarsMode]\nDefending Clan: [global.ClanWarsWinner]\"")
	winset(src,"ClanWarsPane.EntrantsLabel","text=\"[global.ClanWarsEntrants.len] Clan Wars Entrants ([global.ClanWarsMode])\"")
	winset(src,"ClanWarsPane.StatusLabel","text=\"Clan Wars Status: [global.ClanWarsStatus]\"")
	var/HTML="<body bgcolor=[rgb(0,0,64)]><center><table width=100% border=1 bordercolor=[rgb(255,128,0)]>"
	var/FMT="<font face=comic color=[rgb(255,128,0)]><b>"
	var/counter=0
	for(var/mob/M in global.ClanWarsEntrants)
		counter+=1
		HTML+="<tr><td>[FMT]{[M.Clan]} [M]"
	src<<browse(HTML,"window=ClanWarsPane.EntrantsBrowser")

proc/UpdateCWEntrants()
	for(var/mob/M in Players)	if("ClanWarsWindow" in M.OpenWindows)	spawn(-1)	M.UpdateCWEntrants()

mob/verb/CWRegister()
	set hidden=1
	if(global.ClanWarsStatus!="Registering")	{alert("Registration Time is Over!","Clan Wars");return}
	usr=usr.GetFusionMob()
	if(!usr.Clan)	{alert("You must have a Clan to Register for Clan Wars!","Clan Wars");return}
	for(var/mob/M in global.ClanWarsEntrants)
		if(usr.client.computer_id==M.client.computer_id)
			alert("You are Already Registered!","Clan Wars");return
	global.ClanWarsEntrants+=usr
	global.ClanWarsEntrants=SortDatumList(global.ClanWarsEntrants,"Clan")
	global.UpdateCWEntrants()
	world<<"[FlagWarsTag] <b><font color=[usr.Clan.Color]>{[usr.Clan]}</font color> [usr] Registered! ([global.ClanWarsEntrants.len] Entrants)"

mob/proc/Resign(var/Reason="Forfeit")
	src.QuitTournament(Reason)
	src.QuitClanWars(Reason)

mob/proc/QuitClanWars(var/Reason="Forfeit?")
	if(src in global.ClanWarsEntrants)
		if(global.ClanWarsStatus=="Battle")	src.ExitCP()
		global.ClanWarsEntrants-=src
		global.ClanWarsEntrants=SortDatumList(global.ClanWarsEntrants,"Clan")
		global.UpdateCWEntrants()
		var/ClanTag;if(src.Clan)	ClanTag="<font color=[src.Clan.Color]>{[src.Clan]}</font color> "
		world<<"[global.FlagWarsTag] <b>[ClanTag][src] Resigned ([Reason]) ([global.ClanWarsEntrants.len] Entrants Remaining)"

mob/proc/JoinClanWars(/**/)
	if(global.ClanWarsStatus=="Battle")
		if(src.InTournament)	return
		if(!src.client || !src.Clan)	return
		var/Instances=InstanceDatum.Instances["Flag Wars"]
		src.SetInstance(Instances[1])
		src.ShowForcedMiniMap()
		src.client.screen+=global.FWMMMs
		src.DismissNPCs();src.GhostMode()
		spawn()	alert(src,"- There are 2 Flags of Red, Blue, Black and White around the Map.\n- Only 1 Set of Flags will Spawn for every 6 Entrants.\n- Your goal is to bring 2 of the same colored flags together.\n- Move over a dropped flag to pick it up.\n- You can either combine a flag you're carrying with one dropped on the ground, or come together with a clan member carrying the same color!\n- If you get hit while carrying a Flag, you will drop it.\n- Earn 100 Levels and 100 Clan Exp each time you Score.\n- Battle Lasts 10 Minutes.","Flag Wars")

mob/proc/JoinClanWarsCheck()
	if(src in global.ClanWarsEntrants)
		src.JoinClanWars()
		return 1

proc/StartCW()
	global.ClanWarsStatus="Battle"
	world<<"[FlagWarsTag] <b>Clan Wars Starting! ([global.ClanWarsEntrants.len] Entrants)"
	for(var/mob/M in global.ClanWarsEntrants)	M.JoinClanWars()

proc/LoopClanWars()
	while(world)
		for(var/mob/M in global.ClanWarsEntrants)	M.ExitCP()
		world<<"[FlagWarsTag] <b>Now Accepting Entrants!"
		global.ClanWarsStatus="Registering"
		global.ClanWarsMode="Flag Wars"
		global.ClanWarsEntrants=list()
		global.UpdateCWEntrants()
		spawn(5*600)
			global.StartCW()
		sleep(15*600)