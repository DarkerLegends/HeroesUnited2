mob/var/Countering=0
mob/var/mob/CounterBeamMob
mob/verb
	CounterAttack(/**/)
		set hidden=1
		src=src.GetFusionMob()
		if(src.HitStun)	for(var/mob/M in oview(1))
			if(M.Attacking && src.CanPVP(M))
				src.dir=get_dir(src,M)
				flick("punch2",src)
				M.HitStun(10,src);src.Throw(M,5,src.dir)
				PlaySound(view(),'HitHeavy.ogg')
		if(!src.CanAct())	return
		src.Countering=1
		spawn(6)	src.Countering=0
		if(src.CounterBeam())	return
		flick("punch2",src)
		PlaySound(view(),pick('Swing1.ogg','Swing2.ogg'))


	StepRevert(/**/)
		set hidden=1
		src=src.GetFusionMob()
		src.CompleteTutorial("Reverting")
		if(src.CurTrans>=1)
			src.CurTrans-=1
			flick("revert",src)
			src.ApplyTransDatum()
			src.UpdatePartyIcon()
			src.UpdateFaceHUD()
	Revert(/**/)
		set hidden=1
		src=src.GetFusionMob()
		src.CompleteTutorial("Reverting")
		if(src.CurTrans>=1)
			src.CurTrans=0
			src.TransDatum=null
			flick("revert",src)
			src.icon=src.Character.icon
			src.UpdatePartyIcon()
			src.UpdateFaceHUD()
	FullTransform()
		set hidden=1
		var/NewLevel=0
		src=src.GetFusionMob()
		if(!src.CanAct())	return
		var/datum/TransDatum/NewTrans
		var/datum/TransDatum/NextTrans
		src.CompleteTutorial("Transformations")
		for(var/datum/TransDatum/D in src.Character.Transes)	if(src.MaxPL>=D.ReqPL && src.HasKiPercent(60))
			NewLevel+=1;NewTrans=D
			if(src.Character.Transes.len>NewLevel)	NextTrans=src.Character.Transes[NewLevel+1]
			else	NextTrans=null
		if(NewTrans && src.CurTrans<NewLevel)
			src.CurTrans=NewLevel-1
			src.Transform()
		else	if(NextTrans)
			src<<"Requires a Power Level of [FullNum(NextTrans.ReqPL)]"
			PlaySound(src,'PowerUpEnd.ogg')
	Transform()
		set hidden=1
		src=src.GetFusionMob()
		if(!src.CanAct())	return
		src.CompleteTutorial("Transformations")
		if(src.Character.Transes.len>src.CurTrans)
			if(!src.HasKiPercent(60))
				PlaySound(view(),'PowerUpEnd.ogg');return
			var/datum/TransDatum/NextTrans=src.Character.Transes[src.CurTrans+1]
			if(src.MaxPL<NextTrans.ReqPL)
				src<<"Requires a Power Level of [FullNum(NextTrans.ReqPL)]"
				PlaySound(src,'PowerUpEnd.ogg');return
			src.CurTrans+=1
			flick("transform",src)
			src.ApplyTransDatum()
			if(findtext("[src.icon]","SS1") && src.Character.name=="Goku")	src.GiveMedal(new/obj/Medals/HopeOfTheUniverse)
			else	if(findtext("[src.icon]","SS2"))	src.GiveMedal(new/obj/Medals/Ascended)
			else	if(findtext("[src.icon]","SS3"))	src.GiveMedal(new/obj/Medals/EvenFurtherBeyond)
			else	if(findtext("[src.icon]","SS4"))	src.GiveMedal(new/obj/Medals/SuperSaiyan4)
			PlaySound(view(),'EnergyStart.ogg')
			sleep(8)
			src.UpdateFaceHUD()
			spawn()	src.ScreenShake()
			PlaySound(view(),'ActivateSpecial.ogg')
			for(var/mob/M in oview(1))	if(M.icon_state!="koed")
				if(src.CanPVP(M))
					M.HitStun(5,src)
					src.KnockBack(M,src)
					PlaySound(view(),pick('HitLight1.ogg','HitLight2.ogg'))
	Attack(/**/)
		set hidden=1;set instant=1
		src=src.GetFusionMob()
		if(src.GuardTapping)
			src.GuardTapping=0
			src.GuardTapCooling=1
			spawn(6)	src.GuardTapCooling=0
		if(!src.CanAct())	return
		if("G" in src.KeysTapped)	return
		var/MaxCombo=5;if(src.HasPerk("Rush Combo"))	MaxCombo=4
		//if(src.PL/src.MaxPL*100<25 && src.HasPerk("Anger Unleashed"))	MaxCombo=999999
		if(src.ComboCount>=MaxCombo)	return
		src.CompleteTutorial("Attacking")
		PlaySound(view(),pick('Swing1.ogg','Swing2.ogg'))
		var/AttackTime=3
		//if(src.HasPerk("UnShakable"))	AttackTime=6
		if(src.HasPerk("Flash Combo"))	AttackTime=2
		src.Attacking=1;spawn(AttackTime)	src.Attacking=0
		var/list/L=list("punch1","punch2","kick1")-src.LastAttack
		var/ThisAttack=pick(L);src.LastAttack=ThisAttack
		flick(ThisAttack,src)
		src.ComboCount+=1;var/ThisCombo=src.ComboCount
		var/ComboCoolDown=5
		if(src.HasPerk("Flash Combo"))	ComboCoolDown=10
		if(src.ComboCount>=MaxCombo)	spawn(10)	src.ComboCount=0
		else	spawn(ComboCoolDown)	if(src.ComboCount==ThisCombo)	src.ComboCount=0
		if(src.ComboCount==1 && src.Target && MyGetDist(src,src.Target)==1)	src.dir=get_dir(src,src.Target)
		if(src.ComboCount==MaxCombo && src.Target && MyGetDist(src,src.Target==1) && src.HasPerk("Auto Aim"))	src.dir=get_dir(src,src.Target)
		var/turf/GetStep=get_step(src,src.dir);src.DestroyCheck(GetStep)
		for(var/obj/Training/TimedAttacks/T in GetStep)	T.Attacked(src)
		for(var/mob/M in GetStep)	if(M.density==src.density)
			if(M.icon_state=="koed")	continue
			if(!src.CanPVP(M))	continue
			if(!M.CanBeHit())	continue
			src.TargetMob(M);M.TargetMob(src)
			M.dir=get_dir(M,src)
			var/Sound2Play='Hit3.ogg'
			switch(src.ComboCount)
				if(1)	Sound2Play='Hit3.ogg'
				if(2,4)	Sound2Play='Hit0.ogg'
				if(3)	Sound2Play='Hit4.ogg'
				else	Sound2Play=pick('Hit3.ogg','Hit0.ogg','Hit4.ogg')
			if(src.ComboCount>=MaxCombo)	Sound2Play='HitHeavy.ogg'
			PlaySound(view(),Sound2Play)
			if(M.GuardTap(src))	continue
			if(!M)	return
			src.AddKiPercent(5)
			if(src.HasPerk("Energy Boost"))	src.AddKiPercent(1)
			if(M.icon_state=="Guard")
				ShowEffect(M,"HyperCombat",16,16)
				M.Blocked("Melee",src)
				M.AddKiPercent(1)
				continue
			if(M.Attacking)	ShowEffect(M,"HyperCombat",16,16)
			else
				var/BaseDmg=src.Str
				if(src.HasPerk("Warrior"))	BaseDmg*=1.1
				src.StandardDamage(M,BaseDmg,1)
				if(src.HasPerk("Pickpocket"))	if(M.Zenie>=10)
					PlaySound(view(M),'Rupee.ogg')
					M.Zenie-=10;src.Zenie+=10;src.TrackStat("Zenie Stolen",10)
					if(src.GetTrackedStat("Zenie Stolen",src.RecordedTracked)==1000)	src.GiveMedal(new/obj/Medals/Thief)
				if(src.HasPerk("Draining Touch"))	if(M.UseKiPercent(1))	src.AddKiPercent(1)
				if(src.ComboCount==MaxCombo)	src.Throw(M,5,src.dir)
	StrongAttack(/**/)
		set hidden=1;set instant=1
		src=src.GetFusionMob()
		src.PressKey("S")
		while(!src.CanAct())
			if("S" in src.KeysHeld)	sleep(1)
			else	return
		if(!src.HoldingKey("S"))	return
		src.StrongAttacking=1
		ShowEffect(src,"MeleeCharge",0,0)
		PlaySound(view(),'ActivateSpecial.ogg')
		src.StrongAttackCharge=0
		src.StrongAttacking=rand(1,999999)
		var/ThisAttack=src.StrongAttacking
		while(src.StrongAttackCharge<10 && src.StrongAttacking==ThisAttack)
			src.StrongAttackCharge+=1;sleep(1)
		if(src.StrongAttackCharge>=10)	src.StrongAttackRelease()
	StrongAttackRelease()
		set hidden=1;set instant=1
		src=src.GetFusionMob();src.StrongAttacking=0;src.ReleaseKey("S")
		for(var/obj/Effect/E in src.loc.contents)	if(E.name=="Effect: MeleeCharge")	{E.loc=null;break}
		if(src.StrongAttackCharge<10)	{src.StrongAttackCharge=0;return}
		else	src.StrongAttackCharge=0
		src.CompleteTutorial("Strong Attacks")
		flick("punch1",src);PlaySound(view(),pick('Swing1.ogg','Swing2.ogg'))
		if(src.Target && MyGetDist(src,src.Target)==1)	src.dir=get_dir(src,src.Target)
		var/turf/GetStep=get_step(src,src.dir);src.DestroyCheck(GetStep)
		for(var/mob/M in GetStep)	if(M.density==src.density)
			if(M.icon_state=="koed")	continue
			if(!src.CanPVP(M))	continue
			if(!M.CanBeHit())	continue
			src.TargetMob(M);M.TargetMob(src)
			M.dir=get_dir(M,src)
			if(M.GuardTap(src))	continue
			PlaySound(view(),'HitHeavy.ogg')
			if(M.icon_state=="Guard")	M.Blocked("Strong",src,100)
			else
				src.StandardDamage(M,src.Str,1)
				src.Throw(M,5,src.dir)
				src.AddKiPercent(5)
	PowerUp(/**/)
		set hidden=1
		src=src.GetFusionMob()
		if(!src.CanAct())	return
		if(src.PL>=src.MaxPL && src.Ki>=src.MaxKi)	return
		if(src.PoweringUp || src.Training || src.ITing)	return
		src.CompleteTutorial("Power Up")
		src.PoweringUp=1
		while(src.PoweringUp)
			if(src.Ki>=src.MaxKi && src.PL>=src.MaxPL)
				PlaySound(view(),null,channel=7)
				PlaySound(view(),null,channel=8)
				PlaySound(src,'PowerUpEnd.ogg')
				flick("powerup",src)
				break
			if(src.icon_state!="powerup")
				src.AddAura()
				src.icon_state="powerup"
				PlaySound(view(),'EnergyStart.ogg',channel=7)
				PlaySound(view(),'EnergyLoop.ogg',repeat=1,channel=8)
			var/PlAmt=1;var/KiAmt=1
			if(src.HasPerk("Power Charge"))	{PlAmt*=2;KiAmt/=2}
			if(src.HasPerk("Energy Charge"))	{PlAmt/=2;KiAmt*=2}
			var/PowerPL=0;var/PowerKi=0
			switch(src.PowerMode)
				if("Both")	{PowerPL=1;PowerKi=1}
				if("PL Only")	PowerPL=1
				if("Ki Only")	PowerKi=1
				if("PL then Ki")
					PowerPL=1;if(src.PL>=src.MaxPL)	PowerKi=1
				if("Ki then PL")
					PowerKi=1;if(src.Ki>=src.MaxKi)	PowerPL=1
			if(PowerPL)	src.AddPlPercent(PlAmt)
			if(PowerKi)	src.AddKiPercent(KiAmt)
			sleep(1)
		PlaySound(view(),null,channel=7)
		PlaySound(view(),null,channel=8)
		src.RemoveAura();src.PowerUpRelease()
		if(src.icon_state=="powerup")	src.ResetIS()
	PowerUpRelease()
		set hidden=1
		src=src.GetFusionMob()
		src.PoweringUp=0
	Guard(var/ShiftKey as null|num)
		set hidden=1;set instant=1
		src=src.GetFusionMob()
		src.PressKey("G")
		//if(!src.GuardLeft)	return
		if(src.CounterBeamMob)	return
		if(src.StrongAttacking)	return
		if(src.icon_state=="Guard")	return
		if(src.ButtonComboing || src.Training)	return
		if(src.icon_state=="koed" || src.icon_state=="Beam")	return
		if(src.icon_state=="KnockBack")
			src.TrackStat("Throw Cancels",1)
			if(src.GetTrackedStat("Throw Cancels",src.RecordedTracked)==10)	src.GiveMedal(new/obj/Medals/eBrake)
			src.ThrownDamage=null;src.EndKnockBack()
			PlaySound(view(),'ThrowStop.ogg')
		src.CancelBeamCharge()
		src.CompleteTutorial("Guard")
		src.CompleteTutorial("Start Sparring")
		if(src.PL>0)	src.icon_state="Guard"
	GuardRelease(var/ShiftKey as null|num)
		set hidden=1;set instant=1
		src=src.GetFusionMob()
		if(src.icon_state=="koed" && src.CanRecover)
			src.KoCount+=1
			src.CanRecover=0
			spawn(1)	src.CanRecover=1
			if(src.KoCount>=src.KoTime)	src.KoRecovery()
		else
			if(src.icon_state=="Guard")	src.ResetIS()
			if(!ShiftKey && !src.GuardTapCooling)
				src.GuardTapping+=1
				spawn(2)	if(src.GuardTapping>0)	src.GuardTapping-=1
				if(src.Target && src.Target.TeleCountering==src && src.GuardTap(src.Target))	src.Target.ResetTeleCounters()
	KiBlast()
		set hidden=1;set instant=1
		src=src.GetFusionMob()
		if(!src.CanAct())	return
		var/Damage
		if(src.KbType=="HealingKB")
			Damage=src.UsePlPercent(10)
			src.PL=max(1,src.PL)
		else
			var/KiReq=10
			if(src.KbType=="HomingKB")	KiReq=20
			Damage=src.UseKiPercent(KiReq)
		if(!Damage)	{PlaySound(src,'PowerUpEnd.ogg');return}
		src.Charging=1
		spawn(2)	src.Charging=0
		PlaySound(view(),pick('KiBlast1.ogg','KiBlast2.ogg'))
		var/BlastHand=(src.LastBlast ? "KiBlast2" : "kiblast")
		src.LastBlast=!src.LastBlast
		flick("[BlastHand]",src)
		var/obj/Blasts/KiBlast/K=new(src,Damage,src.KbType)
		K.pixel_x=src.GetBlastOffX()
		K.pixel_y=src.GetBlastOffY()
	ChargeBeam()
		set hidden=1
		src=src.GetFusionMob()
		if(!src.CanAct())	return
		if(src.CounterBeam())	return
		if(!src.UseKiPercent(20))	{PlaySound(src,'PowerUpEnd.ogg');return}
		if(src.HasPerk("Flash Finish"))	src.icon_state="charge"
		else
			src.Charging=1;src.icon_state="charge"
			src.ForceBeamBattles()
			var/CharSpecials/ThisSpecial=src.GetBeamSpecial()
			PlaySound(view(),ThisSpecial.ChargeSound,channel=5,VolChannel="Voice")
			PlaySound(view(),'EnergyLoop.ogg',repeat=1,channel=8,VolChannel="Effect")
			src.BeamOverCharge=0
			for(var/i=1;i<=ThisSpecial.ChargeTime+20;i++)
				if(src.icon_state!="charge")	break
				if(i>ThisSpecial.ChargeTime)
					if(!src.Charging)	break
					else
						if(!src.UseKiPercent(1))	break
						else	src.BeamOverCharge+=1
				sleep(1)
			while(src.Charging && (src.HasPerk("Hold Charge") || src.HasPerk("IT KameHameHa")))
				if(src.BeamOverCharge!=20)	break
				if(src.CounterBeamMob)	break
				sleep(1)
			if(ThisSpecial.ChargeTime+src.BeamOverCharge<10)
				PlaySound(view(),'ActivateSpecial.ogg')
				sleep(10-(ThisSpecial.ChargeTime+src.BeamOverCharge))
			PlaySound(view(),null,channel=8)
		if(!src.HitStun && src.icon_state=="charge")
			src.ForceBeamBattles()
			src.Beam()
	ChargeBeamRelease()
		set hidden=1
		src=src.GetFusionMob()
		src.Charging=0
	Fly()
		set hidden=1
		src=src.GetFusionMob()
		if(src.icon_state=="Guard" || src.icon_state=="charge")	src.dir=NORTH
		if(src.icon_state=="powerup" || src.Training)	return
		if(src.InTournament)	return
		if(!src.CanAct())	return
		if(src.density)
			src.density=0;src.layer=6
			step(src,NORTH)
			src.icon_state="fly"
			src.overlays+=FlightShadow
	Land()
		set hidden=1
		src=src.GetFusionMob()
		if(src.icon_state=="Guard" || src.icon_state=="charge")	src.dir=SOUTH
		if(src.icon_state=="powerup" || src.Training)	return
		if(!src.CanAct())	return
		if(!src.density)
			step(src,SOUTH)
			ForceCancelFlight()
			src.CompleteTutorial("Flight")