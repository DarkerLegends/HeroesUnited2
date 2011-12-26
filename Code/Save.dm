client
	Del()
		if(src.mob)
			src.mob.ControlClients=list()
			if(src.mob.FusionMob)	src.mob.EndFusion()
			src.mob.SaveProc()
		return ..()

mob/verb/Save()
	set hidden=1
	usr.SaveProc()

mob/var/CanSave=0
mob/proc/SaveProc()
	if(!src.CanSave)	return
	src.UpdateLastOnline()
	if(fexists("Players/[ckey(src.key)].sav"))	fdel("Players/[ckey(src.key)].sav")
	var/savefile/F=new("Players/[ckey(src.key)].sav")
	F["SaveVersion"]<<GameVersion
	F["name"]<<src.name
	F["dir"]<<src.dir

	F["Level"]<<src.Level
	F["Exp"]<<src.Exp
	F["PL"]<<src.PL
	F["MaxPL"]<<src.MaxPL
	F["Ki"]<<src.Ki
	F["MaxKi"]<<src.MaxKi
	F["Str"]<<src.Str
	F["Def"]<<src.Def
	F["Zenie"]<<src.Zenie
	F["BankedZenie"]<<src.BankedZenie
	F["TraitPoints"]<<src.TraitPoints
	F["PerkPoints"]<<src.PerkPoints
	F["Alignment"]<<src.Alignment
	F["Traits"]<<list2params(src.Traits)
	F["RecordedTracked"]<<src.RecordedTracked
	F["CashPoints"]<<src.CashPoints
	F["CashPointsReceived"]<<src.CashPointsReceived
	F["SlottedPerks"]<<src.SlottedPerks
	F["UnlockedPerks"]<<list2params(src.UnlockedPerks)
	F["PreferredPowerMode"]<<src.PreferredPowerMode
	F["LastWishDate"]<<src.LastWishDate
	F["WishesMade"]<<src.WishesMade
	F["Title"]<<src.Title
	F["IsDead"]<<src.IsDead
	F["Training"]<<src.Training
	F["TrainingExp"]<<src.TrainingExp
	F["CapsuleChars"]<<src.CapsuleChars
	F["Friends"]<<src.Friends
	//F["Materials"]<<src.Materials
	F["LastOnline"]<<src.LastOnline
	F["PartsInventory"]<<src.PartsInventory

	F["x"]<<src.x
	F["y"]<<src.y
	F["z"]<<src.z
	F["Character"]<<src.Character.name
	F["CurTrans"]<<src.CurTrans
	F["KbType"]<<src.KbType
	F["FontFace"]<<src.FontFace
	F["FontColor"]<<src.FontColor
	F["NameColor"]<<src.NameColor
	F["DisplayNameColor"]<<src.DisplayNameColor
	F["see_invisible"]<<src.see_invisible
	F["VolumeMuteAll"]<<src.VolumeMuteAll
	F["VolumeEffect"]<<src.VolumeEffect
	F["VolumeMenu"]<<src.VolumeMenu
	F["VolumeVoice"]<<src.VolumeVoice
	F["VolumeMusic"]<<src.VolumeMusic
	F["InstanceLoc"]<<src.InstanceLoc
	F["PreInstanceLoc"]<<src.PreInstanceLoc
	F["TutsComplete"]<<src.TutsComplete
	F["PlayTimeTicks"]<<src.PlayTimeTicks
	F["PlayTimeSeconds"]<<src.PlayTimeSeconds
	F["PlayTimeMinutes"]<<src.PlayTimeMinutes
	F["PlayTimeHours"]<<src.PlayTimeHours
	F["IgnoreDuels"]<<src.IgnoreDuels
	F["IgnoreParties"]<<src.IgnoreParties
	F["IgnoreFusions"]<<src.IgnoreFusions
	src<<"Game Saved"

mob/proc/LoadProc()
	if(fexists("Players/[ckey(src.key)].sav"))
		var/savefile/F=new("Players/[ckey(src.key)].sav")
		var/SaveVersion=F["SaveVersion"]
		src.name=F["name"]
		src.dir=F["dir"]

		src.Level=F["Level"]
		src.Exp=F["Exp"]
		src.PL=F["PL"]
		src.MaxPL=F["MaxPL"]
		src.Ki=F["Ki"]
		src.MaxKi=F["MaxKi"]
		src.Str=F["Str"]
		src.Def=F["Def"]
		src.Zenie=F["Zenie"]
		src.BankedZenie=F["BankedZenie"]
		src.TraitPoints=F["TraitPoints"]
		src.PerkPoints=F["PerkPoints"]
		src.Alignment=F["Alignment"]
		src.Traits=params2list(F["Traits"])
		src.RecordedTracked=F["RecordedTracked"]
		F["CashPoints"]>>src.CashPoints
		F["CashPointsReceived"]>>src.CashPointsReceived
		src.SlottedPerks=F["SlottedPerks"]
		src.UnlockedPerks=params2list(F["UnlockedPerks"])
		src.PreferredPowerMode=F["PreferredPowerMode"]
		src.LastWishDate=F["LastWishDate"]
		src.WishesMade=F["WishesMade"]
		src.Title=F["Title"]
		src.IsDead=F["IsDead"]
		src.Training=F["Training"]
		src.TrainingExp=F["TrainingExp"]
		src.CapsuleChars=F["CapsuleChars"]
		src.Friends=F["Friends"]
		//src.Materials=F["Materials"]
		src.LastOnline=F["LastOnline"]
		src.PartsInventory=F["PartsInventory"]

		src.KbType=F["KbType"]
		src.FontFace=F["FontFace"]
		src.FontColor=F["FontColor"]
		src.NameColor=F["NameColor"]
		src.DisplayNameColor=F["DisplayNameColor"]
		src.see_invisible=F["see_invisible"]
		src.VolumeMuteAll=F["VolumeMuteAll"]
		src.VolumeEffect=F["VolumeEffect"]
		src.VolumeMenu=F["VolumeMenu"]
		src.VolumeVoice=F["VolumeVoice"]
		src.VolumeMusic=F["VolumeMusic"]
		src.InstanceLoc=F["InstanceLoc"]
		src.PreInstanceLoc=F["PreInstanceLoc"]
		src.TutsComplete=F["TutsComplete"]
		src.PlayTimeTicks=F["PlayTimeTicks"]
		src.PlayTimeSeconds=F["PlayTimeSeconds"]
		src.PlayTimeMinutes=F["PlayTimeMinutes"]
		src.PlayTimeHours=F["PlayTimeHours"]
		src.IgnoreDuels=F["IgnoreDuels"]
		src.IgnoreParties=F["IgnoreParties"]
		src.IgnoreFusions=F["IgnoreFusions"]

		src.Character=AllCharacters[1]
		for(var/obj/Characters/C in AllCharacters)	if(C.name==F["Character"])	{src.Character=C;break}
		src.CurTrans=F["CurTrans"]
		if(src.CurTrans && src.CurTrans<=src.Character.Transes.len)	src.ApplyTransDatum()
		else	src.icon=src.Character.icon
		src.loc=locate(F["x"],F["y"],F["z"])

		if(src.Training=="Focus Training")
			src.Training=initial(src.Training)
			spawn(-1)	src.FocusTrainingProc(src)
			if(src.InstanceLoc)
				var/list/Locs=Split(src.InstanceLoc,"&")
				for(var/obj/TurfType/Instances/I in locate(text2num(Locs[1]),text2num(Locs[2]),text2num(Locs[3])))
					I.InstancePlayers+=src;I.UpdateName();src.InstanceObj=I
		else	src.ExitCP()
		src.loc.Entered(src)
		src.ClearTournamentRing()

		for(var/obj/Items/Lootable/Parts/P in src.PartsInventory)	if(!P.icon_state)
			src.PartsInventory-=P
			for(var/obj/Items/Lootable/Parts/A in AllParts)	if(A.name==P.name)
				var/obj/Items/Lootable/Parts/NP=new A.type
				NP.suffix=P.suffix;src.PartsInventory+=NP;break

		if(!src.SaveFixes(SaveVersion))
			src<<"There was an Error Loading your Old Character!"
			src<<"This was most likely a Programming Error..."
			src<<"Report it on the <a href='http://www.byond.com/members/ZIDDY99/forum'>Forums</a> for correction."
			del src
		if(SaveVersion<GameVersion)	src.ViewUpdates()
		if(src.PL<=0)	src.KnockOut(src,"Load")
		src.ResetSuffix()
		src<<"Game Loaded"
		src.CanSave=1
		return 1

mob/proc/SaveFixes(var/SaveVersion)
	if(!src.KbType)	src.KbType=initial(src.KbType)
	if(!src.NameColor)	src.NameColor=initial(src.NameColor)
	if(SaveVersion<17)	src.PlayTimeSeconds=round(src.PlayTimeTicks/10)
	if(src.PlayTimeSeconds>=2592000)	src.GiveMedal(new/obj/Medals/OneMonth)
	if(src.PlayTimeSeconds>=360000)	src.GiveMedal(new/obj/Medals/TimeInABottle)
	if(SaveVersion<19)	src.Medals-="Hope of the Universe"
	if(SaveVersion<21)	if("Zenie Collected" in src.RecordedTracked)	src.RecordedTracked["Zenie Collected"]=src.Zenie
	if(istext(src.RecordedTracked))	src.RecordedTracked=list()
	if(SaveVersion<28)
		if(!src.RecordedTracked)	src.RecordedTracked=list()
		src.RecordedTracked+="Levels Gained";src.RecordedTracked["Levels Gained"]=src.Level
	if(SaveVersion<34)
		if(src.TutsComplete)	src.TutsComplete-="Trait Points"
		src.Medals-="P.Bag Master"
		src.Medals-="Shadow Spar Master"
	if(SaveVersion<38)	src.FullRespec()
	if(SaveVersion<40)	if(src.TutsComplete)	src.TutsComplete-="Stat Points"
	if(SaveVersion<48)	src.RemovePerk("Flash Finish")
	if(SaveVersion<49)	src.RemovePerk("BulletProof")
	if(!src.DisplayNameColor)	src.DisplayNameColor=initial(src.DisplayNameColor)
	if(!src.PreferredPowerMode)	src.PreferredPowerMode="Both"
	if(SaveVersion<56)	src.RespecPerks()
	if(SaveVersion<58)
		src.RemovePerk("KnockBack Resistance")
		src.RemovePerk("Beam Fanatic")
		src.RemovePerk("Weakling")
	if(SaveVersion<61)
		src.PlayTimeHours=round(src.PlayTimeSeconds/60/60)
		src.PlayTimeMinutes=0;src.PlayTimeSeconds=0
		if(!src.TrainingExp)	src.TrainingExp=0
		src.RemovePerk("Wide Awake")
	if(SaveVersion<63)	if(src.Level>=1000)	src.GiveMedal(new/obj/Medals/Millennial)
	//if(!src.CapsuleChars)	src.CapsuleChars=list(new/obj/CapsuleChars/Piccolo)
	if(!src.Friends)	src.Friends=list()
	if(SaveVersion<66)	src.RemovePerk("UnShakable")
	if(SaveVersion<69)
		var/LevelsGained=src.GetTrackedStat("Levels from Flag Wars Capture",src.RecordedTracked)
		if(LevelsGained)
			src.Level-=LevelsGained
			src.RecordedTracked-="Levels from Flag Wars Capture"
			src.TrackStat("Removed FW Levels",LevelsGained)
		src.FullRespec()
	else if(SaveVersion<70)	if(src.GetTrackedStat("Character Rebirths",src.RecordedTracked))	src.FullRespec()
	if(!src.WishesMade)	src.WishesMade=0
	if(SaveVersion<73)
		src.VolumeEffect=100
		src.VolumeMenu=100
		src.VolumeVoice=100
		src.VolumeMusic=100
	return 1

mob/proc/RemovePerk(var/Perk2Remove)
	if(Perk2Remove in src.UnlockedPerks)
		src.PerkPoints+=1;src.UnlockedPerks-=Perk2Remove
		var/PerkSlotLoc=src.SlottedPerks.Find(Perk2Remove)
		if(PerkSlotLoc)	src.SlottedPerks[PerkSlotLoc]="Empty"