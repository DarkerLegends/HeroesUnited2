mob/var
	Training=0
	TrainingID=0
	TrainingExp=0
	TrainingCombo=0
	TrainingStrike=0
	GravityTraining=0
	StopFocusTraining=0

mob/Player/var/obj/HUD/TimedF/TimedF=new
obj/HUD
	QuitTraining
		icon='HUD.dmi'
		icon_state="Quit"
		screen_loc="13:22,10:-1"
		Click()
			usr=usr.GetFusionMob();usr.ForceCancelTraining()
			for(var/client/C in usr.ControlClients)	C.screen-=src
	TimedF
		icon='Other.dmi'
		icon_state="F"
		layer=12

mob/proc/GetMaxTrainingCombo(var/TrainingType)
	var/MaxTrainingCombo=100
	if(TrainingType=="Shadow Sparring")
		if("Shadow Spar Master" in src.Medals)	MaxTrainingCombo+=10
	if(TrainingType=="Punching Bags")
		if("P.Bag Master" in src.Medals)	MaxTrainingCombo+=10
	if(src.HasPerk("Training Focus"))	MaxTrainingCombo+=10
	if(src.Subscriber)	MaxTrainingCombo+=10
	return MaxTrainingCombo

mob/proc/UpdateHubScore()
	spawn()
		var/Medals2Reg=0;if(src.Medals)	Medals2Reg=src.Medals.len
		var/Perks2Reg=0;if(src.UnlockedPerks)	Perks2Reg=src.UnlockedPerks.len
		var/Params=list2params(list("Level"=FullNum(src.GetRebirthLevel(),0),"Zenie"=FullNum(src.GetTrackedStat("Zenie Collected",src.RecordedTracked),0),"Play Time"=src.DisplayPlayTime(),"Date"=time2text(world.timeofday,"YYYYMMDD"),"Perks"="[Perks2Reg]/[global.AllPerks.len-1]","Medals"="[Medals2Reg]/[global.AllMedals.len]"))
		world.SetScores(src.key,Params)

mob/proc/LevelCheck(var/Reason)
	if(src.client && src.Exp>=100)
		if(src.Level>=999999)	{src.Exp=99;return}
		var/PreLevel=src.Level
		var/LevelsGained=round(src.Exp/100)
		LevelsGained=min(LevelsGained,999999-src.Level)
		src.Exp-=LevelsGained*100;src.Level+=LevelsGained
		if(src.Exp>99 && src.Level>=999999)	src.Exp=99
		src.TraitPoints+=LevelsGained*3
		src.TrackStat("Levels Gained",LevelsGained)
		src.TrackStat("Levels from [Reason]",LevelsGained)
		src<<"<b><font color=blue>Your Level has Increased by [FullNum(LevelsGained)] to [FullNum(src.Level)]![Reason ? " ([Reason])" : ""]"
		src<<"<b><font color=blue>Your Stat Points has Increased by [FullNum(LevelsGained*3)] to [FullNum(src.TraitPoints)]!"
		if(PreLevel<2 && src.Level>=2)	src.GiveMedal(new/obj/Medals/Ding)
		if(PreLevel<100 && src.Level>=100)	src.GiveMedal(new/obj/Medals/Centennial)
		if(PreLevel<1000 && src.Level>=1000)	src.GiveMedal(new/obj/Medals/Millennial)
		if(src.Level>=999999)	src.GiveMedal(new/obj/Medals/LevelCap)
		var/PerkPointsGained=round(src.Level/10000)-round(PreLevel/10000)
		if(PerkPointsGained)
			src.PerkPoints+=PerkPointsGained
			src.GiveMedal(new/obj/Medals/Perky)
			src<<"<b><font color=blue>You Gained [PerkPointsGained] Perk Point(s)!"
		src.ShowTutorial(Tutorials["Stat Points"])
		src.ScoreBoardRecord()
		src.UpdateHubScore()
		src.ResetSuffix()

mob/var/list/SparCmds
mob/proc/ShadowSpar()
	src.AddHudProtection()
	src.Training="Shadow Sparring"
	src.SparCmds=list();src.AddTrainingBG()
	src.UpdateHUDText("TrainingDesc","Press the Correct Combo to Increase EXP")
	for(var/i=1;i<=5;i++)	src.SparCmds+=pick(1,2,4,8)
	src.SparTextOffsetX=rand(-1,1)
	src.SparTextOffsetY=rand(-1,1)
	src.UpdateShadowSpar()

mob/proc/UpdateShadowSpar()
	var/String=""
	for(var/i=src.SparCmds.len;i<5;i++)	String+="  "
	for(var/v in src.SparCmds)	switch(v)
		if(1)	String+="ô "
		if(2)	String+="ö "
		if(4)	String+="ò "
		if(8)	String+="º "
	src.UpdateHUDText("TrainingCombo","[String] +[src.TrainingCombo]% EXP")

mob/var/tmp/SparTextOffsetX=0
mob/var/tmp/SparTextOffsetY=0
mob/var/tmp/ShadowSparInpt
mob/var/tmp/LastShadowSparTime
mob/var/tmp/list/ShadowSparTimes
mob/proc/LogShadowSparTimes()
	if(!src.ShadowSparTimes)	src.ShadowSparTimes=list()
	src.ShadowSparTimes+=world.time-src.LastShadowSparTime
	src.TrackStat("Fastest Spar Combo",world.time-src.LastShadowSparTime,"Lowest")
	src.LastShadowSparTime=world.time
	if(src.ShadowSparTimes.len>=6)
		src.ShadowSparTimes=src.ShadowSparTimes.Copy(2)
		var/Matches=0;var/TooFast=0
		for(var/v in src.ShadowSparTimes)
			if(v<5)	{TooFast=v;break}
			if(v==src.ShadowSparTimes[1])	Matches+=1
		if(TooFast || Matches==src.ShadowSparTimes.len)
			var/Msg2Log="Matching Shadow Spar Times of [src.ShadowSparTimes[1]]"
			if(TooFast)	Msg2Log="Too Fast at [TooFast]"
			world.log<<"* [Msg2Log] by [src.key]"
			src.ShadowSparTimes=list()
			BLOCKSPAR
			src.ShadowSparInpt=rand(1,999999)
			var/ThisInput=input("You have Triggered a Macro Block\nInput the Following # to Continue: [src.ShadowSparInpt]","Shadow Spar Block") as num
			if(ThisInput!=src.ShadowSparInpt)	goto BLOCKSPAR
			src.ShadowSparInpt=0

mob/proc/ShadowAttack(var/Dir)
	if(!src.SparCmds)	return
	if(Dir==src.SparCmds[1])
		src.dir=Dir
		PlaySound(view(),pick('Swing1.ogg','Swing2.ogg'))
		flick(pick("punch1","punch2","kick1"),src)
		src.SparCmds.Cut(1,2);src.UpdateShadowSpar()
		if(!src.SparCmds.len)
			if(!src.ShadowSparInpt)
				src.TrackStat("Button Combos Completed",1)
				src.TrainingExp+=src.TrainingCombo;src.LogShadowSparTimes()
				if(src.TrainingCombo==99 && !src.GravityTraining)	src.GiveMedal(new/obj/Medals/ShadowSparMaster)
				src.TrainingCombo=min(src.GetMaxTrainingCombo("Shadow Sparring"),src.TrainingCombo+1)
			src.ShadowSpar()
	else
		PlaySound(src,'NoBuzz.ogg')
		src.TrackStat("Button Combos Failed",1)
		if(!src.GravityTraining)	{src.AddTrainingExp();src.ForceCancelTraining()}
		else	src.Damage(src,round(src.MaxPL/10),0,"by Intense Gravity while Shadow Sparring")

mob/proc/ForceCancelTraining(/**/)
	if(src.Training)
		if(src.Training=="Focus Training")	src.StopFocusTraining=1
		else
			src.Training=0
			src.TrainingCombo=0
			src.TrainingStrike=0
			src.GravityTraining=0
			src.SparCmds=list()
			src.AddTrainingExp()
			for(var/client/C in src.ControlClients)
				C.screen-=src:TimedF	//TimedF : mob/Player/var
				C.mob.RemoveTrainingBG()
				C.mob.RemoveHudProtection()
				C.mob.UpdateHUDText("TrainingDesc")
				C.mob.UpdateHUDText("TrainingCombo")

mob/proc/AddTrainingExp()
	if(src.TrainingExp>=100000)	src.GiveMedal(new/obj/Medals/FocusedTrainer)
	src.AddExp(src.TrainingExp,"Training Exp");src.TrainingExp=0
	src.CompleteTutorial("Training Exp")

mob/proc
	GravityProc(var/atom/SourceAtom)
		var/Choice=alert("Your Training efforts will not be reset to +0% EXP while Gravity is On.\n\
			However, each mistake you make will cost you 10% of your Power Level.\n\
			You must Disable Gravity in order to safely Stop Training - Otherwise you will Die","Gravity Training","Gravity On","Gravity Off")
		if(MyGetDist(src,SourceAtom)>world.view)	return
		src.CompleteTutorial("Additional Training")
		src=src.GetFusionMob()
		if(Choice=="Gravity On")	src.GravityTraining=1
		else
			src.GravityTraining=0
			if(src.Training=="Punching Bags" || src.Training=="Shadow Sparring")	src.ForceCancelTraining()
	ShadowSparProc(var/atom/SourceAtom)
		src=src.GetFusionMob()
		if(src.Training)	{src<<"You are already [src.Training]";return}
		if(!src.CanAct())	{src<<"You appear to be Busy...";return}
		if(MyGetDist(src,SourceAtom)>world.view)	return
		src.ShowTutorial(Tutorials["Training Exp"])
		src.CompleteTutorial("Additional Training")
		src.TrainingCombo=0
		src.ShadowSpar()
	SparringPartnerProc(var/atom/SourceAtom)
		src=src.GetFusionMob()
		var/list/DamageMults=list("Weak"=0.5,"Balanced"=1,"Strong"=2)
		var/Difficulty=alert("Select Sparring Partner Difficulty","Sparring Partner","Weak","Balanced","Strong")
		var/LevelModifier=DamageMults[Difficulty]
		if(MyGetDist(src,SourceAtom)>world.view)	return
		if(src.Training)	{src<<"You are already [src.Training]";return}
		if(!src.CanAct())	{src<<"You appear to be Busy...";return}
		if(src.SparringPartner)		{src<<"You already have a Sparring Partner";return}
		src.CompleteTutorial("Additional Training")
		var/mob/CombatNPCs/Enemies/Sparring_Partner/P=new(src.loc)
		P.SetCharacter("[pick(AllCharacters)]")
		P.AddName("Spar Bot")
		P.name="[Difficulty] [P.name]"
		P.HasForcedTarget=1;P.StartTarget=src
		P.DamageMultiplier=LevelModifier
		P.LevelScale(round(src.Level*LevelModifier))
		src.Guard(1);src.SparringPartner=P
		src.ShowTutorial(Tutorials["Start Sparring"])
	FocusTrainingProc(var/atom/SourceAtom)
		src=src.GetFusionMob()
		if(src.Training)	{src<<"You are already [src.Training]";return}
		if(!src.CanAct())	{src<<"You appear to be Busy...";return}
		if(MyGetDist(src,SourceAtom)>world.view)	return
		src.ShowTutorial(Tutorials["Training Exp"])
		PlaySound(view(src),'EnergyStart.ogg')
		src.CompleteTutorial("Additional Training")
		src.Training="Focus Training"
		src.icon_state="powerup"
		src.AddAura()
		while(1)
			if(src.StopFocusTraining && src.Training=="Focus Training")
				src.StopFocusTraining=0
				src.Training=0;break
			if(src.Subscriber)	src.TrainingExp+=1
			src.TrainingExp+=1
			sleep(10)
		if(!src)	return
		if(src.Exp+src.TrainingExp>=100)	src.GiveMedal(new/obj/Medals/Lazy)
		src.AddTrainingExp()
		src.ResetIS();src.RemoveAura()

obj/Training
	icon='Other.dmi'
	TimedAttacks
		density=1
		proc/Attacked(var/mob/Player/M)
			if(!M.ControlClients)	return
			flick("[src.icon_state]Hit",src)
			if(!M.Training)
				M.AddHudProtection()
				M.Training="Punching Bags"
				M.TrainingCombo=0
				M.TrainingStrike=1
				M.TrainingID=rand(1,999999)
				M.CompleteTutorial("Training")
				M.AddTrainingBG()
				M.ShowTutorial(Tutorials["Training Exp"])
				M.UpdateHUDText("TrainingDesc","Attack when {F} Appears to Increase EXP")
			else
				if(M.Training!="Punching Bags")	return
				if(M.TrainingStrike)
					if(M.TrainingCombo==99 && !M.GravityTraining)	M.GiveMedal(new/obj/Medals/PBagMaster)
					M.TrainingCombo=min(M.GetMaxTrainingCombo("Punching Bags"),M.TrainingCombo+1)
				else
					PlaySound(M,'NoBuzz.ogg')
					if(M.GravityTraining)	M.Damage(M,round(M.MaxPL/10),0,"by Intense Gravity while Punching Bags")
					else	M.TrainingCombo=0
			if(M.Training)	M.UpdateHUDText("TrainingCombo","+[M.TrainingCombo]% EXP per Attack")
			if(M.TrainingStrike)
				M.TrainingStrike=0
				for(var/client/C in M.ControlClients)	C.screen-=M.TimedF
				M.TrainingExp+=M.TrainingCombo
				PlaySound(view(),'HitHeavy.ogg')
				var/ThisID=M.TrainingID
				sleep(pick(10,20,30));if(!M || M.Training!="Punching Bags" || ThisID!=M.TrainingID)	return
				M.TrainingStrike=1
				M.TimedF.icon_state="F[rand(1,7)]"
				M.TimedF.screen_loc="[9]:[rand(-16,16)],[9]:[rand(-16,16)]"
				for(var/client/C in M.ControlClients)	C.screen+=M.TimedF
				sleep(10);if(!M || M.Training!="Punching Bags" || ThisID!=M.TrainingID)	return
				for(var/client/C in M.ControlClients)
					if(M.TimedF in C.screen)
						PlaySound(M,'NoBuzz.ogg')
						if(M.GravityTraining)	M.Damage(M,round(M.MaxPL/10),0,"by Intense Gravity while Punching Bags")
						else	{M.AddTrainingExp();M.ForceCancelTraining()}
			else	PlaySound(view(),'Hit3.ogg')
		Speed_Bag
			icon_state="SpeedBag"
		Punching_Bag
			icon_state="PunchingBag"