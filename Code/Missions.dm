mob/var/tmp/datum/Missions/CurrentMission

var/list/AllMissions
proc/PopulateMissions()
	AllMissions=typesof(/datum/Missions)-/datum/Missions
	for(var/v in AllMissions)
		AllMissions+=new v
		AllMissions-=v

datum/Missions
	var/ChipSet=""
	var/name;var/Boss
	var/EnemyCount=0;var/ChestCount=0
	var/list/Enemies=list()
	Arrival_of_Raditz
		name="Arrival of Raditz"
		Boss=list("Raditz",1,1.5)
		Enemies=list(list("Saibaman",6,1))
	Return_of_Goku
		name="Return of Goku"
		Boss=list("Scouter Vegeta",1,2)
		Enemies=list(list("Saibaman",5,1),list("Nappa",1,1.5))
	Pathos_of_Frieza
		name="Pathos of Frieza"
		Boss=list("Frieza",1,3)
		Enemies=list(list("Guldo",1,1.2),list("Recoome",1,1.4),list("Burter",1,1.5),list("Jeice",1,1.5),list("Captain Ginyu",1,2))
	Meet_Me_In_The_Ring
		name="Meet Me In The Ring"
		Boss=list("Cell",1,5)
		Enemies=list(list("Cell Jr",6,3))
	Buu_is_Hatched
		name="Buu is Hatched!"
		Boss=list("Buu",1,7)
		Enemies=list(list("Henchman",4,1),list("Dabura",1,5),list("Babidi",1,3))

	World_Champion
		ChipSet="City"
		name="World Champion"
		Boss=list("Hercule",1,10)
		Enemies=list(list("Raditz",1,2),list("Vegeta",1,2.5),list("Frieza",1,3))

mob/proc/CompleteMission(/**/)
	var/list/PartyList=src.Party
	if(!src.Party || !src.Party.len)	PartyList=list(src)
	var/TotalKills=0;var/ChestsLooted=0
	for(var/mob/M in PartyList)
		if(M.CurrentCP && M.CurrentMission)
			M<<"<font color=green><b>~! Mission Complete !~"
			PlaySound(M,'VictoryFanfare.mid',repeat=0,wait=0,channel=6,VolChannel="Music")
			spawn(39)	M<<sound(null,channel=6)
			M.CompleteTutorial("Mission Completion")
			TotalKills+=M.GetTrackedStat("NPCs Killed",M.TempTracked)
			ChestsLooted+=M.GetTrackedStat("Chests Opened",M.TempTracked)
			if(PartyList.len>=4)	M.GiveMedal(new/obj/Medals/PartyAnimal)
			if(!M.GetTrackedStat("Damage Taken",M.TempTracked))	M.GiveMedal(new/obj/Medals/Untouchable)
			if(M.GetTrackedStat("Chests Opened",M.TempTracked)>=3)	M.GiveMedal(new/obj/Medals/LuckyLooter)
			if(M.GetTrackedStat("NPCs Killed",M.TempTracked)>=7)	M.GiveMedal(new/obj/Medals/MassMurderer)
			if(PartyList.len<=1)
				M.TrackStat("Missions Completed",1)
				M.TrackStat("Completed '[M.CurrentMission.name]'",1)
			else
				M.TrackStat("([PartyList.len]xParty)Missions Completed",1)
				M.TrackStat("([PartyList.len]xParty)Completed '[M.CurrentMission.name]'",1)
		else	M<<"Your Party Finished the Mission without You =("
	for(var/mob/M in PartyList)	if(M.CurrentCP && M.CurrentMission)
		if(ChestsLooted>=M.CurrentMission.ChestCount)
			if(TotalKills-1>=M.CurrentMission.EnemyCount)
				M.GiveMedal(new/obj/Medals/Clear)
				M.CompleteTutorial("Clearing Missions")
				M.AddExp(round(10000/PartyList.len),"Mission Clear Bonus")
				if(M.Clan)	M.Clan.AddClanExp(25,M)
				if(PartyList.len<=1)	M.TrackStat("Missions Cleared",1)
				else	M.TrackStat("([PartyList.len]xParty)Missions Cleared",1)
		M.AddPlPercent(100);M.AddKiPercent(100)
		M.ExitCP()
	for(var/mob/M in PartyList)	M.ShowTutorial(Tutorials["Changing Characters"])