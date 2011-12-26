obj/CapsuleChars
	icon='Items.dmi'
	icon_state="Capsule"
	var/tmp/mob/CharMob
	suffix="Right Click to Summon"
	verb/Dismiss()
		set src in world
		if(src.CharMob)	src.CharMob.DismissNPC()
	verb/Summon()
		set src in world
		usr.CompleteTutorial("Capsule Characters")
		if(usr.FusionMob)	{usr<<"Disabled when Fused";return}
		if(src.CharMob)	{usr<<"This Character is Already Active!";return}
		if(!(usr in usr.Party))
			usr.Party+=usr;usr.PartyID=1
			usr.UpdatePartyHUD(usr)
		if(usr.Party.len>=4)	{usr<<"Your Party is Full!";return}
		for(var/mob/M in usr.Party)	if(M.InTournament)	{usr<<"Not Available During Events";return}
		if(usr.InstanceObj && usr.InstanceObj.name=="Flag Wars")	{usr<<"Not Available During Events";return}
		var/mob/CombatNPCs/CapsuleChars/C=new(usr.loc,src.name)
		C.Owner=usr;C.name="[C.name] ([usr.key])";C.Team=usr.Team
		src.CharMob=C;C.Party=list();C.JoinParty(usr);C.TargetMob()
	Piccolo
		desc="Play 'Arrival of Raditz' Mission"
	Goku
		desc="Defeat Raditz with Piccolo's Special Beam Cannon"
	Raditz
		desc="Defeat Raditz as Goku"
	Saibaman
		desc="Defeat Raditz as Saibaman"
	Nappa
		desc="Defeat Nappa as Vegeta"
	Vegeta
		desc="Defeat Vegeta as Goku"


var/obj/CapsuleCharGuide/CapsuleCharGuide=new
obj/CapsuleCharGuide
	name="* Unlock Guide (Click Here)"
	Click()
		usr<<browse(src.desc,"window=CharGuide")
		return ..()

var/list/AllCapsuleChars=list()
proc/PopulateCapsuleChars()
	AllCapsuleChars=typesof(/obj/CapsuleChars)-/obj/CapsuleChars
	for(var/v in AllCapsuleChars)
		var/obj/NewObj=new v
		AllCapsuleChars-=v
		AllCapsuleChars+=NewObj
	var/HTML="<title>Character Guide</title><body bgcolor=[rgb(0,0,64)]><center><table border=1 width=100% bgcolor=[rgb(255,128,0)]>"
	HTML+="<tr><td><u><center><b>Character<td><center><u><b>How to Unlock *During Official Missions"
	for(var/obj/CapsuleChars/C in AllCapsuleChars)
		HTML+="<tr><td><b>[C.name]<td>[C.desc]"
	global.CapsuleCharGuide.desc=HTML
	CompletedProcs+="PopulateCapsuleChars"

mob/proc/CheckMissionUnlocks(var/mob/Target,var/datum/Missions/Mission,var/DamageType)
	if(Mission.type==/datum/Missions/Arrival_of_Raditz)
		if(Target.name=="Raditz")
			if(DamageType=="Beam" && src.Character.name=="Piccolo")	src.UnlockCapsuleChar("Goku")
			else	if(src.Character.name=="Saibaman")	src.UnlockCapsuleChar("Saibaman")
			else	if(src.Character.name=="Goku")	src.UnlockCapsuleChar("Raditz")
	if(Mission.type==/datum/Missions/Return_of_Goku)
		if(Target.name=="Nappa")	if(src.Character.name=="Vegeta")	src.UnlockCapsuleChar("Nappa")
		if(Target.name=="Scouter Vegeta")	if(src.Character.name=="Goku")	src.UnlockCapsuleChar("Vegeta")
	src.SetFocus("MainWindow.MainMap")

mob/proc/UnlockCapsuleChar(var/NewChar)
	if(!islist(src.CapsuleChars))	src.CapsuleChars=list(new/obj/CapsuleChars/Piccolo)
	for(var/obj/CapsuleChars/C in src.CapsuleChars)	if(C.name==NewChar)	return
	var/TextPath=text2path("/obj/CapsuleChars/[NewChar]")
	src.CapsuleChars+=new TextPath
	src.TrackStat("Characters Unlocked","[src.CapsuleChars.len]/[global.AllCapsuleChars.len]")
	spawn()	alert(src,"You have Unlocked the Character Capsule for [NewChar]!","Capsule Character Unlocked")

mob/CombatNPCs/CapsuleChars
	New(var/turf/NewLoc,var/NewChar)
		for(var/obj/Characters/M in AllCharacters)
			if(M.name==NewChar)
				src.Character=M;src.name=M.name
				src.icon=src.Character.icon;break
		src.AddName()
		spawn()	src.CombatAI()
		return ..()
	verb/Dismiss()
		set src in oview()
		if(src.Owner==usr)	src.DismissNPC()