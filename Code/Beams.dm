obj/Supplemental/Beam
	density=0
	var/mob/Owner
	icon='Effects.dmi'

mob/var/list/BeamParts
mob/proc/ClearBeam()
	for(var/obj/B in src.BeamParts)	B.loc=null
	src.BeamParts=list()

mob/proc/BeamHit(var/mob/Beamer,var/DamageMult=1)
	for(var/i=1;i<=5;i++)
		if(!Beamer)	return
		if(DamageMult==2)	Beamer.BeamOverCharge=20
		if(MyGetDist(src,Beamer)>world.view)	return
		if(Beamer.BeamOverCharge<20)	if(src.GuardTap(Beamer))	return
		if(!src.GhostMode)	{src.TargetMob(Beamer);Beamer.TargetMob(src)}
		PlaySound(view(src),pick('Hit0.ogg','Hit1.ogg','Hit2.ogg','Hit3.ogg','Hit4.ogg'))
		if(src.icon_state!="Guard" || Beamer.BeamOverCharge==20)
			var/FullDamage=GetPercent(20,Beamer.MaxKi)-src.Def
			if(Beamer.HasPerk("Flash Finish"))	FullDamage/=2
			FullDamage*=1+(Beamer.BeamOverCharge/20)
			Beamer.StandardDamage(src,FullDamage*DamageMult,DamageType="Beam")
			src.HitStun(10,Beamer)
		else	if(src.icon_state=="Guard")	src.Blocked("Beam",Beamer)
		sleep(3)

atom/proc/OffsetBack()
	switch(src.dir)
		if(1)	src.pixel_y=-16
		if(2)	src.pixel_y=16
		if(4)	src.pixel_x=-16
		if(8)	src.pixel_x=16

mob/proc/CreateBeamPart(var/Loc)
	var/obj/Supplemental/Beam/B=new(Loc)
	B.Owner=src;src.BeamParts+=B
	B.dir=src.dir;B.layer=src.layer
	var/CharSpecials/ThisSpecial=src.GetBeamSpecial()
	B.icon_state="[ThisSpecial.icon_state]Mid"

mob/proc/ForceBeamBattles()
	for(var/mob/M in oview(src))	if(src.HasPerk("Beam Fanatic") || M.HasPerk("Beam Fanatic"))	M.CounterBeam(src)

mob/proc/BeamBattle(var/mob/CounterBeamer)
	src.ButtonComboing=1
	spawn(5)
		src.ButtonComboing=0
		if(!CounterBeamer)	return
		if(!src.BeamParts.len || !CounterBeamer.BeamParts.len)	return
		var/CharSpecials/ThisSpecial=src.GetBeamSpecial()
		var/obj/BeamHead=src.BeamParts[src.BeamParts.len]
		var/obj/CounterBeamHead=CounterBeamer.BeamParts[CounterBeamer.BeamParts.len]
		while(BeamHead && CounterBeamer && MyGetDist(BeamHead.loc,CounterBeamer.loc)>1)
			if(src.StartButtonCombo(CanFail=1))
				if(!BeamHead || !CounterBeamer)	break
				if(MyGetDist(BeamHead.loc,CounterBeamer.loc)>=10)	break
				for(var/obj/Supplemental/Beam/B in CounterBeamHead.loc)	if(findtext(B.icon_state,"mid"))	B.loc=null
				src.CreateBeamPart(BeamHead.loc)
				step(BeamHead,BeamHead.dir);step(CounterBeamHead,BeamHead.dir)
				CounterBeamHead.dir=CounterBeamer.dir
				PlaySound(view(BeamHead),'EnergyStart.ogg')
				if(MyGetDist(BeamHead.loc,CounterBeamer.loc)<=1)
					src.CounterBeamMob=null
					CounterBeamer.CounterBeamMob=null
					src.TrackStat("Beam Battles Won",1)
					CounterBeamer.TrackStat("Beam Battles Lost",1)
					if(src.GetTrackedStat("Beam Battles Won",src.RecordedTracked)==10)	src.GiveMedal(new/obj/Medals/BeamBattler)
					src.CreateBeamPart(BeamHead.loc);step(BeamHead,BeamHead.dir)
					BeamHead.icon_state="[ThisSpecial.icon_state]Hit"
					CounterBeamer.ClearBeam();CounterBeamer.CancelButtonCombo()
					CounterBeamer.BeamHit(src,2);break
			else	if(!BeamHead || !CounterBeamer)	break
		src.ClearBeam();src.ResetIS()

mob/proc/CancelBeamBattle()
	var/mob/CounterBeamer=src.CounterBeamMob
	if(src.CounterBeamMob)
		src.CounterBeamMob=null
		src.ResetIS();src.ClearBeam()
		src.CancelButtonCombo()
		CounterBeamer.CounterBeamMob=null
		CounterBeamer.ResetIS()
		CounterBeamer.ClearBeam()
		CounterBeamer.CancelButtonCombo()

mob/proc/Beam(/**/)
	if(src.icon_state=="Beam")	return
	var/MaxDist=8
	src.Charging=0
	src.ClearBeam()
	var/Loco=src.loc
	src.icon_state="Beam"
	var/CharSpecials/ThisSpecial=src.GetBeamSpecial()
	if(ThisSpecial.FireSound)	PlaySound(view(),ThisSpecial.FireSound,VolChannel="Voice")
	if(src.CounterBeamMob)
		spawn(-1)	src.BeamBattle(src.CounterBeamMob)
		src.dir=get_dir(src,src.CounterBeamMob)
		src.CounterBeamMob.Beam()
		MaxDist=round(get_dist(src,src.CounterBeamMob)/2)
	for(var/i=1;i<=MaxDist;i++)
		Loco=get_step(Loco,src.dir)
		var/obj/Supplemental/Beam/B=new(Loco)
		B.Owner=src;src.BeamParts+=B
		B.dir=src.dir;B.layer=src.layer+0.1
		var/SpotTag="Mid"
		if(i==1)
			SpotTag="Start"
			if(ThisSpecial.icon_state=="BBK")	B.AddBBKOverlays()
		if(i==MaxDist)
			if(MaxDist==8)	SpotTag="Head"
			else
				SpotTag="Battle"
				if((get_dist(src,src.CounterBeamMob)-1)%2)	B.OffsetBack()
		B.icon_state="[ThisSpecial.icon_state][SpotTag]"
		if(!src.CounterBeamMob)
			for(var/mob/M in B.loc)
				if(src.CanPVP(M))
					B.icon_state="[ThisSpecial.icon_state]Hit"
					spawn()	if(M)	M.BeamHit(src)
					goto END
			if(!B.loc.Enter(src))
				B.icon_state="[ThisSpecial.icon_state]Hit"
				src.DestroyCheck(B.loc)
				goto END
	END
	if(!src.CounterBeamMob)
		sleep(15)
		src.ClearBeam()
		src.ResetIS()

atom/proc/AddBBKOverlays()
	switch(src.dir)
		if(NORTH)
			var/obj/O=new;O.icon='Effects.dmi';O.layer=FLOAT_LAYER
			O.icon_state="BBKL";O.pixel_x=-32;src.overlays+=O
			O.icon_state="BBKR";O.pixel_x=32;src.overlays+=O
		if(SOUTH)
			var/obj/O=new;O.icon='Effects.dmi';O.layer=FLOAT_LAYER
			O.icon_state="BBKL";O.pixel_x=-32;src.overlays+=O
			O.icon_state="BBKR";O.pixel_x=32;src.overlays+=O
		if(EAST)
			var/obj/O=new;O.icon='Effects.dmi';O.layer=FLOAT_LAYER
			O.icon_state="BBKL";O.pixel_y=-32;src.overlays+=O
			O.icon_state="BBKR";O.pixel_y=32;src.overlays+=O
		if(WEST)
			var/obj/O=new;O.icon='Effects.dmi';O.layer=FLOAT_LAYER
			O.icon_state="BBKL";O.pixel_y=-32;src.overlays+=O
			O.icon_state="BBKR";O.pixel_y=32;src.overlays+=O