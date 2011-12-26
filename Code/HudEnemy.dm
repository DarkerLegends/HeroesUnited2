obj/HUD
	layer=10
	EnemyPlBar
		layer=11
		icon='EnemyPlBar1.dmi'
		screen_loc="13:14,17:2"
	EnemyKiBar
		layer=11
		icon='EnemyKiBars.dmi'
		screen_loc="13:12,17:-1"
	EnemyFaceIcon
		layer=11
		icon_state="face"
		screen_loc="17:-7,17:-6"

mob/proc/UpdateEnemyHUD()
	src.UpdateEnemyKiHUD()
	src.UpdateEnemyPlHUD()
	src.UpdateEnemyFaceHUD()


mob/proc/UpdateEnemyFaceHUD()
	for(var/client/C in src.ControlClients)
		for(var/obj/HUD/EnemyFaceIcon/I in C.screen)
			if(src.Target)	I.icon=src.Target.icon
			else	I.icon=null
			return

/*mob/proc/UpdateEnemyGuardHUD()
	for(var/client/C in src.ControlClients)
		if(!ismob(C.mob.Target))
			for(var/obj/O in C.mob.EnemyGuardBarList)	O.icon_state=""
			return
		var/counter
		for(var/obj/HUD/EnemyGuardBar/G in C.mob.EnemyGuardBarList)
			//G.icon_state="[min(32,100-C.mob.Target.GuardLeft-counter*32)]"
			counter+=1*/

mob/var/list/EnemyPlBars[4]
mob/proc/UpdateEnemyPlHUD()
	for(var/client/C in src.ControlClients)
		if(!ismob(src.Target))
			for(var/obj/O in C.mob.EnemyPlBars)	O.icon_state="invis"
			return
		var/ThisPercent=round(src.Target.PL/src.Target.MaxPL*100)
		for(var/i=1;i<=4;i++)
			if(!C.mob.EnemyPlBars[i])
				var/obj/HUD/EnemyPlBar/PLB=new
				PLB.screen_loc="15:[9-(32*(i-1))],17:-7"
				if(i==2 || i==3)	PLB.icon='EnemyPlBar2.dmi'
				if(i==4)	PLB.icon='EnemyPlBar3.dmi'
				C.screen+=PLB
				C.mob.EnemyPlBars[i]=PLB
			var/obj/HUD/PlBar/PLB=C.mob.EnemyPlBars[i]
			PLB.icon_state="[max(0,ThisPercent-(32*(i-1)))]"

mob/var/obj/HUD/KiBar/EnemyKiBar
mob/proc/UpdateEnemyKiHUD()
	for(var/client/C in src.ControlClients)
		if(!ismob(src.Target) && C.mob.EnemyKiBar)
			C.mob.EnemyKiBar.icon_state="invis"
			return
		if(!C.mob.EnemyKiBar)
			C.mob.EnemyKiBar=new/obj/HUD/EnemyKiBar
			C.screen+=C.mob.EnemyKiBar
		var/NewIS="[round(src.Target.Ki/src.Target.MaxKi*100)]"
		if(C.mob.EnemyKiBar.icon_state!=NewIS)
			C.mob.EnemyKiBar.icon_state=NewIS