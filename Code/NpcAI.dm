mob/proc/MatchFlight(var/mob/M)
	if(src.density!=M.density)
		if(src.density==1)	src.Fly()
		else
			var/CanLand=0;src.density=1
			var/turf/T=get_step(src,SOUTH)
			if(T.Enter(src))	CanLand=1
			src.density=0;if(CanLand)	src.Land()

mob/CombatNPCs
	var/GuardAI=1
	var/turf/StartLoc
	var/HasForcedTarget
	proc/CombatAI()
		while(1)
			var/SleepTime=1
			if(src.CanAct() || src.StrongAttacking)
				if(src.HasForcedTarget && !src.StartTarget)	{del src;return}
				if(src.StartTarget && MyGetDist(src,src.StartTarget)>world.view)	{src.StartTarget.SparringPartner=null;del src;return}
				if(!initial(src.z) || src.z==initial(src.z))
					if(src.StartTarget)	src.Target=src.StartTarget
					if(src.Target && MyGetDist(src,src.Target)>world.view)	src.Target=null
					if(!src.Target)	for(var/mob/M in oview())
						if(M.GhostMode || M.Team==src.Team)	continue
						if(src.Owner && !src.Owner.CanPVP(M))	if(!src.InTournament || !M.InTournament)	continue
						for(var/mob/T in view(M)-src.Owner)	if(T.Team==src.Team && T.Target==M)	goto SKIPTARG
						src.Target=M;break
						SKIPTARG
					if(src.Target)
						src.CancelSmartFollow()
						var/mob/Player/M=src.Target
						if(rand(1,100)<=10 && src.Target.TeleCountering==src)	{src.Guard();src.GuardRelease();goto GOTO}
						if(src.Ki<round(src.MaxKi*10/100) && (get_dist(src,M)>2 || M.PL<=0))	{spawn(-1)	src.PowerUp();goto GOTO}
						else	src.PowerUpRelease()
						src.MatchFlight(M)
						if(src.loc==M.loc)	step_rand(src)
						src.dir=get_dir(src,M)
						if(M.icon_state=="charge" && (M.x==src.x || M.y==src.y) && get_dist(src,M)>=3 && rand(1,100)<=50)	{src.ChargeBeam();goto GOTO}
						if(M.PL<=0)
							if(!M.HasPerk("Fighting Spirit"))	sleep(20)
							src.KiBlast();goto GOTO
						if(M in get_step(src,src.dir))
							if(M.icon_state=="Guard")	if(rand(1,100)<=25)	{spawn(-1)	src.StrongAttack();goto GOTO}
							else	if(src.StrongAttacking)	{src.StrongAttackRelease();sleep(rand(1,3))}
							src.Attack();goto GOTO
						if(MyGetDist(src,M)>1)	{step_to(src,M);SleepTime=4;goto GOTO}
					else	if(src.Owner)
						if(src.InTournament || src.Owner.InTournament)
							if(global.TournRegMode!="Parties")	src.LeaveParty()
							goto NoFOLLOW
						src.MatchFlight(src.Owner)
						if(!src.SmartFollowTarget)	src.SmartFollow(src.Owner,rand(1,3))
						NoFOLLOW
					GOTO
				if(!src.Target)
					SleepTime=5
					src.ResetIS()
					src.AddPlPercent(100)
					src.AddKiPercent(100)
					if(src.StartLoc  && src.z==src.StartLoc.z)	src.loc=src.StartLoc
			else	if(src.GuardAI)
				if(src.HitStun || src.JustBlocked || src.icon_state=="KnockBack")	if(rand(1,5)==1)	src.Guard()
				else	if(src.icon_state=="Guard")	src.GuardRelease(rand(1,100)<=50 ? 0 : 1)
			if(src.icon_state=="koed")	{src.GuardRelease();SleepTime=rand(3,5)}
			sleep(SleepTime)