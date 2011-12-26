var/list/EffectObjs=list()
proc/PopulateEffects()
	for(var/i=1;i<=500,i++)	EffectObjs+=new/obj/Effect
obj/Effect
	layer=7
	icon_state=""
	icon='Effects.dmi'
proc/ShowEffect(var/atom/Loc,var/Effect,var/OffX=0,var/OffY=0,var/Dir,var/Repeat=0,var/RandomOffset=1)
	var/obj/O=EffectObjs[1]
	EffectObjs-=O;EffectObjs+=O
	if(Dir)	O.dir=Dir
	else	O.dir=SOUTH
	O.loc=locate(Loc.x,Loc.y,Loc.z)
	if(RandomOffset)	{O.pixel_x=rand(-OffX,OffX);O.pixel_y=rand(-OffY,OffY)}
	else	{O.pixel_x=OffX;O.pixel_y=OffY}
	O.icon_state=""
	if(Repeat)	O.icon_state="[Effect]"
	else	flick("[Effect]",O)
	O.name="[initial(O.name)]: [Effect]"
	spawn(10)	O.loc=null

obj/Blasts
	density=1
	var/Damage
	var/mob/Owner
	var/IsControlled=0
	icon='Effects.dmi'
	KiBlast
		icon_state="DeathKB"
	New(var/mob/M,var/D,var/IS)
		src.Damage=D
		src.icon_state=IS
		src.density=M.density
		src.Owner=M;layer=M.layer
		src.dir=M.dir;src.loc=M.loc
		if(IS=="ControlledKB")	src.IsControlled=1
		if(!src.density)	src.overlays+=KiBlastShadow
		var/WalkSpeed=1;if(src.icon_state=="HomingKB")	WalkSpeed=2
		for(var/mob/Player/P in oview(world.view,src))	if(P.HasPerk("Heightened Senses"))	{WalkSpeed*=2;break}
		if(src.icon_state=="HomingKB" && M.Target && MyGetDist(M,M.Target)<=world.view)	walk_towards(src,M.Target,WalkSpeed)
		else	walk(src,src.dir,WalkSpeed)
		if(src.icon_state=="HomingKB")	spawn(100)	src.loc=null
	Move()
		if(!src.density || src.icon_state=="HomingKB")
			for(var/mob/M in get_step(src,src.dir))
				if(!M.density || src.icon_state=="HomingKB")	spawn(-1)
					src.Bump(M);return
		return ..()
	Bump(var/atom/A)
		if(istype(A,/obj/Blasts))
			if(A:Owner!=src.Owner)	{walk(src,BackAngleDir(src.dir));return}
		if(istype(A,/turf))	for(var/mob/M in A)
			if(M.density==src.density)	{src.Bump(M);return}
		if(istype(A,/turf/Generic/Water))
			ShowEffect(A,"WaterSplit",Dir=src.dir)
			src.loc=A;return
		if(A && src.Owner)	src.Owner.DestroyCheck(locate(A.x,A.y,A.z))
		if(ismob(A) && src.Owner)
			var/mob/M=A
			if(src.icon_state=="HealingKB")
				src.Owner.TargetMob(M)
				if(M.GhostMode)
					if(M in src.Owner.Party)
						src.Owner.TrackStat("Party Revives",1)
						if(src.Owner.GetTrackedStat("Party Revives",src.Owner.RecordedTracked)==10)	src.Owner.GiveMedal(new/obj/Medals/GhostBuster)
					M.GhostMode=2;M.Respawn()
				else
					if(M.PL<M.MaxPL)
						if(M in src.Owner.Party)
							src.Owner.TrackStat("Party Healed",1)
							if(src.Owner.GetTrackedStat("Party Healed",src.Owner.RecordedTracked)==100)	src.Owner.GiveMedal(new/obj/Medals/Medic)
						DamageShow(M,round(M.MaxPL/10),'HealNums.dmi')
						if(M.icon_state=="koed")	M.KoRecovery()
						else	M.AddPlPercent(10)
			else	if(src.Owner!=M && src.Owner.CanPVP(M))
				//if(src.Owner.ControlClients && M.HasPerk("BulletProof"))	{walk(src,BackAngleDir(src.dir));return}
				M.dir=get_dir(M,src)
				M.TargetMob(src.Owner)
				src.Owner.TargetMob(M)
				if(M.GuardTap(src.Owner))	return
				if(M.Attacking || M.Countering)
					src.Owner=M
					src.icon_state=M.KbType
					src.loc=locate(M.x,M.y,M.z)
					if(M.Countering)	walk(src,BackDir(src.dir))
					else	walk(src,BackAngleDir(src.dir))
					return
				if(M.CanBeHit())
					if(M.icon_state=="Guard")
						M.dir=get_dir(M,src)
						if(src.icon_state=="GuardBreakKB")	if(M.icon_state=="Guard")	M.Blocked("Guard Break KB",src.Owner,20)
						else
							M.Blocked("Ki Blast",src.Owner)
							src.Owner.KnockBack(M,src)
					else	if(src.icon_state!="GuardBreakKB")
						if(src.icon_state=="StunKB")	M.HitStun(10,src.Owner)
						else
							var/BaseDmg=src.Damage;if(src.Owner.HasPerk("Warrior"))	BaseDmg/=2
							src.Owner.StandardDamage(M,BaseDmg,src.IsControlled)
		walk(src,0);src.density=0
		flick("[src.icon_state]Hit",src)
		src.icon_state="invis"
		if(A)	src.loc=locate(A.x,A.y,A.z)
		sleep(2);src.loc=null
		src.icon_state="ErrorKB"

proc/BackDir(var/Dir)
	if(Dir==1)	return 2
	if(Dir==2)	return 1
	if(Dir==4)	return 8
	if(Dir==8)	return 4
	if(Dir==5)	return 10
	if(Dir==6)	return 9
	if(Dir==9)	return 6
	if(Dir==10)	return 5
	return 0

proc/BackAngleDir(var/Dir)
	if(Dir==1)	return pick(6,10)
	if(Dir==2)	return pick(5,9)
	if(Dir==4)	return pick(9,10)
	if(Dir==8)	return pick(5,6)
	if(Dir==10)	return pick(2,8)
	if(Dir==9)	return pick(1,8)
	if(Dir==5)	return pick(1,4)
	if(Dir==6)	return pick(2,4)
	return 0