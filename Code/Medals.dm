var/list/AllMedals=list()
var/list/AllMedalNames=list()
mob/var/list/Medals=list()
mob/var/ViewingMedal=0

proc/PopulateMedalList()
	AllMedals=typesof(/obj/Medals)-/obj/Medals
	for(var/v in AllMedals)
		var/obj/NewObj=new v
		AllMedals-=v
		AllMedals+=NewObj
		AllMedalNames+=NewObj.name
	CompletedProcs+="PopulateMedalList"

mob/proc/SaveMedals()
	if(fexists("Medals/[ckey(src.key)].sav"))	fdel("Medals/[ckey(src.key)].sav")
	var/savefile/F=new("Medals/[ckey(src.key)].sav")
	F["Medals"]<<src.Medals

mob/proc/LoadMedals()
	if(fexists("Medals/[ckey(src.key)].sav"))
		var/savefile/F=new("Medals/[ckey(src.key)].sav")
		F["Medals"]>>src.Medals

var/obj/ViewMedalPage/VMP=new
obj/ViewMedalPage
	name="* Click here to View All Medals & Scores *"
	Click()	usr<<link("http://www.byond.com/games/Falacy/DBZHU2?tab=scores")

/*
var/obj/ViewMedalStatus/VMS=new
obj/ViewMedalStatus
	name="* Click here to View Your Medals"
	Click()
		var/F="<b><font face='arial bold' color=[rgb(0,0,64)]>"
		var/MedalHTML="<title>Medal Status</title><body bgcolor=[rgb(0,0,64)]>"
		MedalHTML+="<center><table height=100% border=1 bgcolor=[rgb(255,128,0)]><tr><td colspan=2><center><b>[F]Your Medal Status"
		MedalHTML+="<tr height=50><td><center><b><i>[F][usr.Medals.len] Medals Earned<td><center><b><i>[F][AllMedals.len-usr.Medals.len] Medals Remaining"
		MedalHTML+="<tr><td valign=top><table border=1 frame=below>"
		for(var/v in usr.Medals)	MedalHTML+="<tr><td>[F][v]"
		MedalHTML+="</table><td valign=top><table border=1 frame=below>"
		for(var/obj/Medals/M in AllMedals)	if(!(M.name in usr.Medals))	MedalHTML+="<tr><td>[F][M.name]"
		MedalHTML+="</table></table>"
		usr<<browse(MedalHTML,"window=MedalStatus")
*/

obj/Medals
	icon='Medals.dmi'
	//Leveling & Stats
	Ding
		name="Ding"
		suffix="Reach Level Two"
	Centennial
		name="Centennial"
		suffix="Reach Level 100"
	Millennial
		suffix="Reach Level 1,000"
	Perky
		name="Perky"
		suffix="Earn your first Perk Point"
	LevelCap
		name="Level Cap"
		suffix="Reach Level 999,999"
	ItsOver9000
		name="It's Over 9,000!!!"
		suffix="Reach a Power Level of Over 9,000"
	StatCap
		name="Stat Cap"
		suffix="Raise a Stat to 999,999"
	PerfectWarrior
		name="Perfect Warrior"
		suffix="Raise all Stats to 999,999"

	Perkfect
		name="Perkfect"
		suffix="Unlock All Perks"

	//Events
	TreasureHunter
		name="Treasure Hunter"
		suffix="Find the Golden Treasure Chest"
	Sponsor
		name="Sponsor"
		suffix="Host a World Tournament"
	Refunded
		name="Refunded"
		suffix="Win a World Tournament that you Hosted"
	WorldChampion
		name="World Champion"
		suffix="Win a World Tournament"
	TitleDefender
		name="Title Defender"
		suffix="Win 2 World Tournaments in a Row"
	IStandAlone
		name="I Stand Alone"
		suffix="Defeat a Party in the WT by Yourself"
	RoyaleRoyalty
		name="Royale Royalty"
		suffix="Win a Battle Royale WT"

//	Flag_Bearer
		suffix="Solo Flag Wars Score"
//	Flag_Buddies
		suffix="Flag Wars Score with a Clan Member"

	//Missions
	Clear
		name="Clear!"
		suffix="Loot all Chests and Kill all Enemies in a Mission"
	Untouchable
		name="Untouchable"
		suffix="Complete any Mission without Taking Damage"
	LuckyLooter
		name="Lucky Looter"
		suffix="Open 3 Chests in a Single Mission"
	MassMurderer
		name="Mass Murderer"
		suffix="Kill 7 Enemies in a Single Mission"
	PartyAnimal
		name="Party Animal"
		suffix="Complete a Mission with a Full Party"
	Savior
		name="Savior"
		suffix="Pull an NPC Enemy off of a KOed Party Member"

	//Training
	PBagMaster
		name="P.Bag Master"
		suffix="Achieve +100% Exp on a Punching Bag without Gravity"
	ShadowSparMaster
		name="Shadow Spar Master"
		suffix="Achieve +100% Exp while Shadow Sparring without Gravity"
	FocusedTrainer
		name="Focused Trainer"
		suffix="Gain 1,000+ Levels from a Single Training Session"
	Lazy
		name="Lazy"
		suffix="Gain a Level by Focus Training"
	EvenLazier
		name="Even Lazier"
		suffix="Gain a Level from Auto Experience"

	//Clans
	UnitedWeStand
		name="United We Stand"
		suffix="Create or Join a Clan"
	ClanContributor
		name="Clan Contributor"
		suffix="Earn Clan Exp"

	//General Gameplay
	//MedalUp
	//	name="Medal Up"
	//	suffix="Gain a Level by Earning a Medal"
	//MeetYourHoster
		//name="Meet Your Hoster"
		//suffix="Play the Game while ZIDDY99 is Online"
	HopeOfTheUniverse
		name="Hope of the Universe"
		suffix="Transform into a Super Saiyan as Goku"
	Ascended
		name="Ascended"
		suffix="Transform into a Super Saiyan 2"
	EvenFurtherBeyond
		name="Even Further Beyond"
		suffix="Transform into a Super Saiyan 3"
	SuperSaiyan4
		name="Super Saiyan 4"
		suffix="Transform into a Super Saiyan 4"
	TimeInABottle
		name="Time in a Bottle"
		suffix="Play for 100 Hours"
	OneMonth
		name="One Month"
		suffix="Play for 720 Hours"
	Proclaimer
		suffix="Walk 500 Miles"
	Millionaire
		name="Millionaire"
		suffix="Bank 1,000,000 Zenie"
	BeamBattler
		name="Beam Battler"
		suffix="Win 10 Beam Battles"
	eBrake
		name="eBrake"
		suffix="Throw Cancel 10 Times"
	SplitPersonality
		name="Split Personality"
		suffix="Fuse with another Player"
	EternalDragon
		name="Eternal Dragon"
		suffix="Be Granted a Wish by the Eternal Dragon"
	Reborn
		name="Reborn"
		suffix="Wish for a Character Rebirth"
//	Duelicious
//		name="Duelicious"
//		suffix="Win a PvP Duel"
	Thief
		suffix="Steal 1,000 Zenie"
	Medic
		name="Medic"
		suffix="Heal Party Members 100 Times"
	GhostBuster
		name="Ghost Buster"
		suffix="Revive 10 Fallen Party Members"
	Friendly
		name="Friendly"
		suffix="Add Someone to your Friend List"

	//Player Status
	Player
		name="Player"
		suffix="Login to the Game"
	ByondMember
		name="BYOND Member"
		suffix="Have an Active BYOND Membership"
	Subscriber
		name="Subscriber"
		suffix="Have an Active Stray Games Subscription"
	SubMember
		name="Sub Member"
		suffix="Have an Active Subcription and Membership"

	Completionist
		name="Completionist"
		suffix="Earn all other Medals"

mob/var/tmp/list/MedalObjs
mob/proc/MedalCorrection()
	while(!("PopulateMedalList" in CompletedProcs))	sleep(1)
	src.MedalObjs=list()
	for(var/v in src.Medals)
		if(v=="Its Over 9,000!!!")	src.Medals+="It's Over 9,000!!!"
		if(v=="Member")	src.Medals+="BYOND Member"
		if(v=="Mission Perfect")	src.Medals+="Untouchable"
		if(v=="Mass Murder")	src.Medals+="Mass Murderer"
		if(v=="P.Bag Mastery")	src.Medals+="P.Bag Master"
		if(v=="Shadow Spar Mastery")	src.Medals+="Shadow Spar Master"
		if(v=="Been There, Done That")	src.Medals+="Player"
		if(v=="On Your Way")	src.Medals+="Ding"
		if(v=="Well On Your Way")	src.Medals+="Centennial"
		if(!(v in AllMedalNames))	src.Medals-=v
	for(var/obj/Medals/M in AllMedals)	if(M.name in src.Medals)	src.MedalObjs+=M
	src.SaveMedals()

mob/proc/GiveMedal(var/obj/Medals/M)
	if(!src.client)	return
	spawn()
		while(src.ViewingMedal)	sleep(1)
		if(!(M.name in src.Medals))
			src.ViewingMedal=1;src.Medals+=M.name;src.SaveMedals()
			winset(src,"MedalWindow.DescLabel","text=\"- [M.name] -\n[M.suffix]\"")
			for(var/obj/Medals/O in AllMedals)	if(O.name==M.name)	{src.MedalObjs+=O;break}
			winset(src,"MedalWindow","pos=8,44;is-visible=true")
			PlaySound(src,'BleepBloop.ogg')
			world<<"<b><font size=1 color=[rgb(250,100,0)]>\icon[M] [src] has Earned a Medal:  [M.name]"
			spawn(50)	if(src)	{winset(src,"MedalWindow","is-visible=false");src.ViewingMedal=0}
			spawn()	world.SetMedal(M.name,src)
			src.TrackStat("Medals Earned","[src.Medals.len]/[global.AllMedals.len]")
			if(src.Medals.len>=global.AllMedals.len-1)	src.GiveMedal(new/obj/Medals/Completionist)


mob/verb/Select_Title()
	set hidden=1
	src.Title=input("Select Your Title:","Select Title",src.Title) as null|anything in src.Medals
	src.ResetSuffix();src.AddTitle()

obj/Supplemental/TitleDisplay
	icon='TextGold.dmi'
	layer=FLOAT_LAYER
	pixel_y=-30
	var/DefaultOffset=9
	New(var/px,var/IS)
		src.pixel_x=px+DefaultOffset
		src.icon_state=IS
		if(LowLetter(IS))	src.pixel_y-=2
mob/proc/AddTitle(/**/)
	for(var/O in src.overlays)	if(O:name=="TitleDisplay")	src.overlays-=O
	if(!src.Title)	return
	var/Name2Add=src.Title
	var/PixelSpace=6
	var/letter;var/spot=0
	var/px=((1*PixelSpace)-(length(Name2Add)*PixelSpace)/2)-PixelSpace
	while(spot<length(Name2Add))
		spot+=1;letter=copytext(Name2Add,spot,spot+1)
		if(SlimLetter(letter))	px+=2
	spot=0
	while(1)
		spot+=1;letter=copytext(Name2Add,spot,spot+1)
		if(!letter)	return
		px+=PixelSpace
		var/obj/NL=new/obj/Supplemental/TitleDisplay(px,letter)
		if(!src.Clan)	NL.pixel_y+=10
		if(SlimLetter(letter))	px-=4
		src.overlays+=NL