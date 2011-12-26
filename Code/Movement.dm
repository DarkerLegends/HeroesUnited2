mob/var
	Moving
	MN;MS;ME;MW
	QueN;QueS;QueE;QueW
	Sprinting=0
	MovementSpeed=2
	list/SprintDirs

mob/proc/SprintCheck(var/TapDir)
	if(!src.SprintDirs)	src.SprintDirs=list()
	if(TapDir in src.SprintDirs)
		if(!src.Sprinting)
			src.Sprinting=1
			src.MovementSpeed-=1
			if(!src.density)	PlaySound(view(),'EnergyStart.ogg')
			if(!src.icon_state || src.icon_state=="Sprint" || src.icon_state=="fly")	src.ResetIS()
	else
		src.SprintDirs+=TapDir
		spawn(4)	src.SprintDirs-=TapDir

mob/proc/SprintCancel()
	if(!src.Sprinting)	return
	if(!src.MN && !src.MS && !src.ME && !src.MW)
		src.MovementSpeed=initial(src.MovementSpeed)
		src.Sprinting=0
		src.RemoveAura("Fly")
		//PlaySound(view(),'ThrowStop.ogg')
		if(!src.icon_state || src.icon_state=="Sprint" || src.icon_state=="fly")	src.ResetIS()

mob/proc/GetMovementSpeed()
	var/MovementDelay=src.MovementSpeed
	if(src.FlagCaptured)	MovementDelay*=2
	//if(src.GuardLeft<=50)	MovementDelay+=1
	//if(src.GuardLeft<=25)	MovementDelay+=1
	return	max(1,MovementDelay)

mob/proc/CancelMovement()
	src.MN=0;src.MS=0;src.MW=0;src.ME=0
	src.SprintCancel()

mob/Bump(var/atom/A)
	return ..()
	if(src.Sprinting)
		PlaySound(view(),'HitHeavy.ogg')
		spawn()	src.ScreenShake()
		src.CancelMovement()
		src.KnockBack(src,A)
		flick("HitStun",src)
	return ..()

mob/Move(var/turf/NewLoc,NewDir)
	if(src.Sprinting && !src.density && NewLoc.Enter(src))
		src.AddAura("Fly")
		ShowEffect(src.loc,"[src.GetAuraType()]Trail",0,0,NewDir,1)
		if(NewDir==9)	ShowEffect(src.loc,"[src.GetAuraType()]Trail",16,-16,NewDir,1,0)
		if(NewDir==5)	ShowEffect(src.loc,"[src.GetAuraType()]Trail",-16,-16,NewDir,1,0)
		if(NewDir==10)	ShowEffect(src.loc,"[src.GetAuraType()]Trail",16,16,NewDir,1,0)
		if(NewDir==6)	ShowEffect(src.loc,"[src.GetAuraType()]Trail",-16,16,NewDir,1,0)
	return ..()

mob/proc/ResetFocus()
	for(var/client/C in src.ControlClients)
		if(C.eye==locate(289,100,1))	C.eye=C.mob.GetFusionMob()

mob/proc/LogDistanceTraveled()
	src.TrackStat("Distance Traveled",1)
	if(src.Sprinting)
		if(src.density)	src.TrackStat("Distance Sprinted",1)
		else	src.TrackStat("Distance Bursted",1)
	else
		if(src.density)	src.TrackStat("Distance Walked",1)
		else	src.TrackStat("Distance Flown",1)
	if(src.GetTrackedStat("Distance Walked",src.RecordedTracked)>=440000)	src.GiveMedal(new/obj/Medals/Proclaimer)

mob/proc/MovementLoop()
	walk(src,0)
	if(src.Moving)	return;src.Moving=1
	var/FirstStep=1
	while(src.MN || src.ME || src.MW || src.MS || src.QueN || src.QueS || src.QueE || src.QueW)
		if(src.ThrownBy)	{sleep(1);continue}
		if(src.MN || src.QueN)
			if(src.ME || src.QueE)	if(!step(src,NORTHEAST) && !step(src,NORTH))	step(src,EAST)
			else if(src.MW || src.QueW)	if(!step(src,NORTHWEST) && !step(src,NORTH))	step(src,WEST)
			else	step(src,NORTH)
		else	if(src.MS || src.QueS)
			if(src.ME || src.QueE)	if(!step(src,SOUTHEAST) && !step(src,SOUTH))	step(src,EAST)
			else if(src.MW || src.QueW)	if(!step(src,SOUTHWEST) && !step(src,SOUTH))	step(src,WEST)
			else	step(src,SOUTH)
		else	if(src.ME || src.QueE)	step(src,EAST)
		else	if(src.MW || src.QueW)	step(src,WEST)
		src.QueN=0;src.QueS=0;src.QueE=0;src.QueW=0
		if(FirstStep)	{sleep(1);FirstStep=0}
		sleep(src.GetMovementSpeed())
	src.Moving=0

mob/verb
	MoveNorth()
		set hidden=1;set instant=1
		src=src.GetFusionMob()
		src.ResetFocus()
		src.SprintCheck("North")
		src.CompleteTutorial("Movement")
		if(src.SparCmds && src.SparCmds.len)	{src.ShadowAttack(1);return}
		if(src.ButtonCombos && src.ButtonCombos.len)	{src.ButtonHit(1);return}
		src.MN=1;src.MS=0;QueN=1;src.MovementLoop()
	StopNorth()
		set hidden=1;set instant=1
		src=src.GetFusionMob()
		src.MN=0;src.SprintCancel()

	MoveSouth()
		set hidden=1;set instant=1
		src=src.GetFusionMob()
		src.ResetFocus()
		src.SprintCheck("South")
		src.CompleteTutorial("Movement")
		if(src.SparCmds && src.SparCmds.len)	{src.ShadowAttack(2);return}
		if(src.ButtonCombos && src.ButtonCombos.len)	{src.ButtonHit(2);return}
		src.MN=0;src.MS=1;QueS=1;src.MovementLoop()
	StopSouth()
		set hidden=1;set instant=1
		src=src.GetFusionMob()
		src.MS=0;src.SprintCancel()

	MoveEast()
		set hidden=1;set instant=1
		src=src.GetFusionMob()
		src.ResetFocus()
		src.SprintCheck("East")
		src.CompleteTutorial("Movement")
		if(src.SparCmds && src.SparCmds.len)	{src.ShadowAttack(4);return}
		if(src.ButtonCombos && src.ButtonCombos.len)	{src.ButtonHit(4);return}
		src.ME=1;src.MW=0;QueE=1;src.MovementLoop()
	StopEast()
		set hidden=1;set instant=1
		src=src.GetFusionMob()
		src.ME=0;src.SprintCancel()

	MoveWest()
		set hidden=1;set instant=1
		src=src.GetFusionMob()
		src.ResetFocus()
		src.SprintCheck("West")
		src.CompleteTutorial("Movement")
		if(src.SparCmds && src.SparCmds.len)	{src.ShadowAttack(8);return}
		if(src.ButtonCombos && src.ButtonCombos.len)	{src.ButtonHit(8);return}
		src.ME=0;src.MW=1;QueW=1;src.MovementLoop()
	StopWest()
		set hidden=1;set instant=1
		src=src.GetFusionMob()
		src.MW=0;src.SprintCancel()