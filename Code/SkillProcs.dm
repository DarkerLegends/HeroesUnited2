mob/proc/HitStun(var/StunTime,var/mob/Stunner)
	src.DropFlag("Hit by [Stunner]")
	if(src.icon_state=="koed")	return
	if(src.Ki<src.MaxKi*20/100)	if(!src.HasPerk("Keep It Up"))	src.Revert()
	//if(src.HasPerk("UnShakable"))	return
	src.HitStun+=1
	if(src.CounterBeamMob)
		var/mob/M=src.CounterBeamMob
		src.CounterBeamMob=null;M.HitStun(0,Stunner)
	flick("HitStun",src)
	src.PowerUpRelease()
	src.CancelBeamCharge()
	src.StrongAttackRelease()
	if(src.Ki<=0 && Stunner && Stunner.HasPerk("Ki Stun"))	StunTime*=2
	spawn(StunTime)	src.HitStun-=1
	src.ResetIS()
	return 1

mob/proc/CancelBeamCharge(/**/)
	if(src.icon_state=="charge")
		src.Charging=0;src.ResetIS()
		PlaySound(view(),null,channel=5)

mob/proc/CounterBeam(var/mob/TauntTarget)
	for(var/mob/M in oview(src))
		if(M.icon_state=="charge")	if(!TauntTarget || M==TauntTarget)
			if(get_dist(src,M)>=3 && (M.x==src.x || M.y==src.y) && src.CanPVP(M))
				src.Charging=1
				M.CounterBeamMob=src
				src.CounterBeamMob=M
				src.dir=get_dir(src,M)
				src.icon_state="charge"
				return 1

mob/proc/CanAct(/**/)
	if(src.HitStun)	return
	if(src.ThrownBy)	return
	if(src.Charging)	return
	if(src.GhostMode)	return
	if(src.Attacking)	return
	if(src.PoweringUp)	return
	if(src.Countering)	return
	if(src.ButtonComboing)	return
	if(src.StrongAttacking)	return
	if(src.TeleCounteringID)	return
	if(src.icon_state=="koed")	return
	if(src.icon_state=="Beam")	return
	if(src.icon_state=="Guard")	return
	if(src.icon_state=="charge")	return
	if(src.SparCmds && src.SparCmds.len)	return
	if(src.Training && src.Training!="Punching Bags")	return
	if(global.TournStatus=="Face-Off" && src.InTournament)	return
	return 1

mob/proc/AddZenie(var/Zenie2Add)
	src.Zenie+=Zenie2Add;src.TrackStat("Zenie Collected",Zenie2Add)

mob/proc/AddExp(var/Exp2Add,var/Reason)
	if(Exp2Add<=0)	return
	for(var/client/C in src.ControlClients)
		Exp2Add=Exp2Add/src.ControlClients.len
		if(C.mob.HasPerk("Quick Learner"))	Exp2Add*=1.1
		if(C.mob.HasPerk("Intense Training"))	Exp2Add*=1.1
		if(C.mob.HasClanUpgrade("Fast Track"))	Exp2Add+=Exp2Add*C.mob.HasClanUpgrade("Fast Track")*0.02
		C.mob.Exp+=round(Exp2Add)
		C.mob.LevelCheck(Reason)
		C.mob.UpdateExpBar()

mob/proc/AddPlPercent(var/Percent)
	src.PL+=round(src.MaxPL*Percent/100)
	src.PL=min(src.PL,src.MaxPL)
	src.UpdatePlHUD()
	if(round(src.PL/src.MaxPL*100)<=20)	src.ShowTutorial(Tutorials["Power Up"])

mob/proc/UsePlPercent(var/Percent)
	var/AmtNeeded=round(src.MaxPL*Percent/100)
	if(src.PL<AmtNeeded)	return
	src.PL-=AmtNeeded
	src.UpdatePlHUD()
	if(round(src.PL/src.MaxPL*100)<=20)	src.ShowTutorial(Tutorials["Power Up"])
	return AmtNeeded

mob/proc/TakePlPercent(var/Percent)
	src.PL-=round(src.MaxPL*Percent/100)
	src.PL=max(0,src.PL)
	src.UpdatePlHUD()

mob/proc/AddKiPercent(var/Percent)
	src.Ki+=round(src.MaxKi*Percent/100)
	src.Ki=min(src.Ki,src.MaxKi)
	src.UpdateKiHUD()
	if(round(src.Ki/src.MaxKi*100)<=20)	src.ShowTutorial(Tutorials["Power Up"])

mob/proc/HasKiPercent(var/Percent)
	var/KiNeeded=round(src.MaxKi*Percent/100)
	if(src.Ki<KiNeeded)	return
	else	return 1

mob/proc/TakeKiPercent(var/Percent)
	src.Ki-=round(src.MaxKi*Percent/100)
	src.Ki=max(0,src.Ki)
	src.UpdateKiHUD()

mob/proc/UseKiPercent(var/Percent)
	var/KiNeeded=round(src.MaxKi*Percent/100)
	if(src.Ki<KiNeeded)	return
	src.Ki-=KiNeeded
	src.UpdateKiHUD()
	if(round(src.Ki/src.MaxKi*100)<=20)	src.ShowTutorial(Tutorials["Power Up"])
	return KiNeeded

mob/var/KoTime
mob/proc/KnockOut(var/mob/Killer,var/Cause)
	if(src.PL<=0)
		if(src.icon_state=="koed")	return
		if(src.HasPerk("Fighting Spirit"))	return
		src.Revert()
		src.KoTime=10
		src.KoCount=0
		src.icon_state="koed"
		src.Ki=0;src.UpdateKiHUD()
		src.ShowTutorial(Tutorials["KO Recovery"])
		if(Killer)
			Killer.ShowTutorial(Tutorials["Finishers"])
			//if(src.HasPerk("Wide Awake"))	src.KoTime/=2
			if(Killer.HasPerk("Spirit Crusher"))	src.KoTime*=2
			if(Killer.HasPerk("Adrenaline Rush II"))
				Killer.AddKiPercent(10)
				Killer.AddPlPercent(10)

mob/proc/KoRecovery()
	src.CompleteTutorial("KO Recovery")
	var/RecoveryPercent=20;if(src.HasPerk("Graceful Recovery"))	RecoveryPercent*=2
	src.AddPlPercent(RecoveryPercent)
	src.AddKiPercent(RecoveryPercent)
	src.ResetIS()

mob/proc/DeathCheck(var/mob/Killer,var/DeathTag="by an Unknown Force?",var/DamageType)
	if(src.PL<=0)
		Killer.CompleteTutorial("Finishers")
		if(Killer.HasPerk("Adrenaline Rush"))
			Killer.AddKiPercent(10)
			Killer.AddPlPercent(10)
		var/DeathMode="Player Death"
		if(src.Dueling)
			if(src.DuelFlag)
				src.TrackStat("[src.DuelFlag.DuelType] Duels Lost",1)
				src.Dueling.TrackStat("[src.DuelFlag.DuelType] Duels Won",1)
			src<<"Duel Ended; You Died!"
			src.Dueling<<"Duel Ended; [src] Died!"
			if(src.DuelFlag)	DeathMode="[src.DuelFlag.DuelType] Duel"
			else	DeathMode="??? Duel"
			//src.Dueling.GiveMedal(new/obj/Medals/Duelicious)
			src.EndDuel()
		if(src.ControlClients)
			if(!Killer)
				src.TrackStat("Deaths by Mysterious Strangers?",1)
				world<<"<b><font color=black>Player Death:<font color=red> [src] was Killed by a Mysterious Stranger?"
			else
				if(src.InstanceObj && src.InstanceObj.PvpType)
					src.TrackStat("[initial(src.InstanceObj.name)] Deaths",1)
					Killer.TrackStat("[initial(src.InstanceObj.name)] Kills",1)
					DeathMode=initial(src.InstanceObj.name)
					if(istype(src.InstanceObj,/obj/TurfType/Instances/GenericInstance))	DeathMode=src.InstanceObj.name
					world<<"<b><font color=black>[DeathMode]:<font color=red> [src] was Defeated by [Killer]"
				else
					if(Killer==src)
						src.TrackStat("Deaths [DeathTag]",1)
						world<<"<b><font color=black>Player Death:<font color=red> [src] was Killed [DeathTag]"
					else
						if(Killer.ControlClients)
							src.TrackStat("Deaths by PvP",1)
							Killer.TrackStat("PvP Kills",1)
						else	src.TrackStat("Deaths by NPC",1)
						if(src.InTournament)	DeathMode="World Tournament"
						world<<"<b><font color=black>[DeathMode]:<font color=red> [src] was Killed by [Killer]"
			var/GoGhostMode
			if(src.CurrentMission)	GoGhostMode=1
			if(src.InstanceObj && src.InstanceObj.DeathMode=="Ghost")	GoGhostMode=1
			if(GoGhostMode)	src.GhostMode()
			else
				src.ExitCP()
				src.IsDead=1
				src.overlays-=global.Halo
				src.overlays+=global.Halo
				src.CancelButtonCombo()
				src.loc=locate(366,20,2)
				src.LoseTournRound("Defeated",Killer)
				src.ShowTutorial(Tutorials["Alpha Revival"])
		else
			if(Killer.Owner)	Killer.Owner.TrackStat("Companion Kills",1)
			Killer.TrackStat("NPCs Killed",1)
			if(!src.Owner)
				spawn(-1)	Killer.SpawnPart(src.loc)
				spawn(-1)	Killer.SpawnZenie(src.loc,1)
			Killer.AddExp(round(src.CalcDamMult()*100),"Kills")
			if(Killer.CurrentCP)
				//Killer.CheckMissionUnlocks(src,Killer.CurrentMission,DamageType)
				if(Killer.CurrentCP.Boss==src.name)	Killer.CompleteMission()
			if(src.Owner)
				src.LoseTournRound("Defeated",Killer)
				src.LeaveParty()
			if(!initial(src.z))	del src
			src.loc=locate(initial(src.x),initial(src.y),initial(src.z))
		src.Revert();src.ResetIS()
		src.AddPlPercent(100);src.AddKiPercent(100)
		if(src.CurTut && src.CurTut.name=="KO Recovery")	{src.PL=0;src.KnockOut(src,"Death")}
		else	src.KoRecovery()

proc/VaryDamage(var/Damage,var/Percent)
	Percent=round(Damage*(Percent/100))
	return Damage+rand(-Percent,Percent)

proc/KiPercentDifference(var/mob/A,var/mob/D)
	var/MaxVariant=0.5	//A=Attacker, D=Defender
	return min(MaxVariant,max(-MaxVariant,((A.Ki/A.MaxKi)-(D.Ki/D.MaxKi))))

mob/proc/CalcDamMult(/**/)
	var/TransBoost=0
	if(src.HasPerk("Ultimate Power"))
		if(src.MaxPL>=999999)	TransBoost=0.6
		else	if(src.MaxPL>=750000)	TransBoost=0.5
		else	if(src.MaxPL>=500000)	TransBoost=0.4
		else	if(src.MaxPL>=250000)	TransBoost=0.3
		else	if(src.MaxPL>=100000)	TransBoost=0.2
		else	if(src.MaxPL>=1000)	TransBoost=0.1
	else	if(src.TransDatum)
		if(src.TransDatum.ReqPL>=999999)	TransBoost=0.5
		else	if(src.TransDatum.ReqPL>=750000)	TransBoost=0.5
		else	if(src.TransDatum.ReqPL>=500000)	TransBoost=0.4
		else	if(src.TransDatum.ReqPL>=250000)	TransBoost=0.3
		else	if(src.TransDatum.ReqPL>=100000)	TransBoost=0.2
		else	if(src.TransDatum.ReqPL>=1000)	TransBoost=0.1
	if(src.Subscriber)	TransBoost+=0.1
	if(src.HasPerk("Boost"))	TransBoost+=0.1
	if(src.HasPerk("Intense Training"))	TransBoost-=0.1
	if(src.HasClanUpgrade("Clan Boost"))	TransBoost+=0.1
	if(src.ControlClients && src.ControlClients.len>=2)	TransBoost+=0.3
	return src.DamageMultiplier+TransBoost

mob/proc/StandardDamage(var/mob/M,var/Damage,var/Controlled=0,var/DamageType)
	Damage-=M.Def
	Damage=src.GetDamageOffsets(M,Damage)
	src.Damage(M,Damage,Controlled,DamageType=DamageType)
	return Damage

mob/proc/GetDamageOffsets(var/mob/M,var/Damage)
	Damage+=Damage*(KiPercentDifference(src,M)/10)
	var/Dif=max(0.5,1+src.CalcDamMult()-M.CalcDamMult())
	Damage=VaryDamage(Damage*Dif,5)
	return Damage

mob/proc/DoBalancedDamage(var/mob/M)
	if(src.DuelFlag && src.DuelFlag==M.DuelFlag && M.DuelFlag.DuelType=="Balanced")	return 1
	if(src.InTournament && M.InTournament && global.TournDamage=="Balanced")	return 1
	if(M.InstanceObj && M.InstanceObj.IsPvpType("Balanced"))	return 1
	if(!M.ControlClients || !src.ControlClients)	return 1

mob/proc/Damage(var/mob/M,var/Damage,var/Controlled=0,var/DeathTag="Mysteriously?",var/DamageType)
	if(!M.CanBeHit())	return
	if(src.DoBalancedDamage(M))
		Damage=round(M.MaxPL/20)	//Balanced Damage - 20 Hits to Kill
		if(!M.ControlClients)	Damage*=2	//Doubled PvE Damage due to Blocking
		if(DamageType=="Beam")	Damage*=1+(src.BeamOverCharge/20)	//Over Charged Beam Damage
		Damage=src.GetDamageOffsets(M,Damage)
	//if(src.ControlClients && M.HasPerk("BulletProof"))	Damage*=2
	if(M.HasPerk("Energy Shield") && M.UseKiPercent(10))	Damage*=0.9
	Damage=round(max(0,Damage))
	DamageShow(M,Damage)
	M.CombatTime();M.AddKiPercent(1)
	if(M.HasPerk("Bottled Rage"))	M.AddKiPercent(1)
	var/LastGaspDmg=0;if(M.PL>1 && M.HasPerk("Last Gasp"))	LastGaspDmg=1
	M.PL=max(LastGaspDmg,M.PL-Damage)
	M.TrackStat("Damage Taken",Damage)
	src.TrackStat("Damage Dealt",Damage)
	if(Controlled)	M.KnockOut(src,"Damage")
	else	M.DeathCheck(src,DeathTag,DamageType)
	if(M && Damage>0)	M.HitStun(5,src)
	if(M && round(M.PL/M.MaxPL*100)<=20)	M.ShowTutorial(Tutorials["Power Up"])
	if(M)	{M.UpdatePlHUD();M.ShowTutorial(Tutorials["Guard"])}
	return Damage

mob/proc/KnockBack(var/mob/M,var/SrcLoc)
	if(MyGetDist(src,M)>world.view-1)	return
	var/turf/T=get_step(M,get_dir(SrcLoc,M))
	if(T.Enter(M))
		M.loc=T;T.Entered(M)

mob/proc/EndKnockBack(/**/)
	if(src.ThrownDamage!=null)	src.ThrownBy.StandardDamage(src,src.ThrownDamage,1)
	src.dir=BackDir(src.dir)
	src.ThrownBy=null
	src.ResetIS()

mob/proc/Throw(var/mob/M,var/ThrowDist,var/ThrowDir)
	if(M.HasPerk("KnockBack Resistance"))	return
	spawn(-1)
		var/Dist=1
		M.ThrownBy=src
		M.ThrownDamage=src.Str-M.Def
		while(M && Dist<=ThrowDist && M.ThrownBy)
			flick("KnockBack",M)
			M.icon_state="KnockBack"
			step(M,ThrowDir);Dist+=1
			sleep(1)
		if(M)
			M.ThrownBy=null
			if(M.icon_state=="KnockBack")
				M.dir=BackDir(M.dir)
				M.ResetIS()

mob/proc
	ResetIS(/**/)
		if(src.density)
			if(src.Sprinting)	src.icon_state="Sprint"
			else	src.icon_state=""
		else	src.icon_state="fly"
		if(!src.GhostMode && src.PL<=0)	src.KnockOut(src,"Reset")

	GetBlastOffX()	//Used for which hand a ki blast comes from
		var/OffX=0
		if(src.dir==NORTH)
			if(src.LastBlast)	OffX=8
			else	OffX=-8
		if(src.dir==SOUTH)
			if(src.LastBlast)	OffX=-8
			else	OffX=8
		return OffX
	GetBlastOffY()
		var/OffY=0
		if(src.dir==EAST || src.dir==WEST)
			if(src.LastBlast)	OffY=4
			else	OffY=-4
		return OffY