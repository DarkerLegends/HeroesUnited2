obj/HUD
	icon='HUD.dmi'
	layer=10
	MouseEntered()
		if(src.desc)
			var/list/SplitList=Split(src.screen_loc,",")
			for(var/v in SplitList)
				var/PreListSize=SplitList.len
				SplitList+=Split(v,":")
				if(SplitList.len==PreListSize+1)	SplitList+=0
			var/X=text2num(SplitList[3]);var/Xoff=text2num(SplitList[4])
			var/Y=text2num(SplitList[5]);var/Yoff=text2num(SplitList[6])
			X=(X-1)*32;Y=(18-Y)*32
			winset(usr,"SmallInfoWindow.NameLabel","text=\"[src.name]\"")
			winset(usr,"SmallInfoWindow.DescLabel","text=\"[src.desc]\"")
			winset(usr,"SmallInfoWindow","pos=[16+X+Xoff],[38+Y-Yoff];is-visible=true")
			winset(usr,"MainWindow.MainMap","focus=true")
	MouseExited()
		if(src.desc)	winset(usr,"SmallInfoWindow","is-visible=false")
	HudBG
		name="Character HUD"
		icon='HudBG.png'
		desc="This HUD displays general stats about your character.  Power, Ki, Exp, Alignment, Icon and Name."
	HudProtection
		mouse_opacity=0
		layer=30;screen_loc="6:-7,10:-1 to 13,10"
		icon='HudProtection.dmi';icon_state="Color"
		New()
			var/list/RandomIcons=list()
			while(RandomIcons.len<100)
				var/icon/I=initial(src.icon)+rgb(rand(0,256),rand(0,256),rand(0,256))
				if(!(I in RandomIcons))	RandomIcons+=I
			spawn()	while(1)
				src.icon=pick(RandomIcons)
				sleep(10)
	TextBG
		icon='HudBG.dmi'
	HudBarBG
		icon='HudBarBG.png'
	GuardBar
		layer=11
		mouse_opacity=0
		icon='GuardBar.dmi'
	EnemyGuardBar
		layer=11
		mouse_opacity=0
		icon='EnemyGuardBar.dmi'
	EnemyGuardBarBG
		icon='EnemyGuardBarBG.png'
	KiBar
		layer=11
		mouse_opacity=0
		icon='KiBars.dmi'
		screen_loc="4:23,17:-2"
	PlBar
		layer=11
		mouse_opacity=0
		icon='PlBar1.dmi'
	FaceIcon
		layer=11
		mouse_opacity=0
		icon_state="face"
		screen_loc="1:7,17:-8"
	ExpBar
		layer=11
		mouse_opacity=0
		icon='ExpBar.dmi'
		screen_loc="2:11,17:5"
	AlignmentBar
		layer=11
		mouse_opacity=0
		icon='AlignmentBar.dmi'
		screen_loc="3:18,17:5"
	KiBlastType
		Click()
			if(src.desc)
				usr.SelectKbType(src.icon_state)
		New(var/IS,var/SL)
			src.icon_state="[IS]"
			screen_loc=SL
	SelectedKiBlastType
		layer=11
		mouse_opacity=0
		icon_state="SelectedKB"
		New(var/SL)
			screen_loc=SL
	Level_Up
		icon_state="LevelUp"
		screen_loc="9,1"
		desc="Click to Distribute the Stat and Perk Points you've Earned Leveling!"
		MouseEntered()
			src.desc="[initial(src.desc)]\n[FullNum(usr.TraitPoints)] Stat + [FullNum(usr.PerkPoints)] Perk Points"
			return ..()
		Click()
			winset(usr,"LevelWindow","pos=100,10")
			usr.DisplayPerks()
	Click2Instance
		var/Instance2
		MouseEntered()
			var/PlayerCount=0
			for(var/obj/TurfType/Instances/I in InstanceDatum.Instances[src.Instance2])
				for(var/mob/M in I.InstancePlayers)	PlayerCount+=1
			src.desc="[initial(src.desc)]\n[PlayerCount] Players Currently PvPing Here."
			return ..()
		Click()
			usr.ChangeInstance(src.Instance2)
		PvP_Arena
			icon_state="PVP"
			screen_loc="5:3,16:4"
			Instance2="PvpArenas"
			desc="Join other Players for some free for all PvP!"
		Clan_PvP_Arena
			icon_state="ClanPVP"
			screen_loc="5:19,16:4"
			Instance2="ClanPvpArenas"
			desc="Join your Clan Mates for Team Based PvP!"
		Balanced_PvP_Arena
			icon_state="BalancedPVP"
			screen_loc="6:3,16:4"
			Instance2="BalancedPvpArenas"
			desc="Join other Players in PvP where Everyone Deals Equal Damage!"
	Exit_Arena
		icon_state="ExitInstance"
		screen_loc="6:19,16:4"
		desc="Return to the World Map from a PvP Arena or Mission..."
		Click()
			usr=usr.GetFusionMob()
			if(!usr.CanAct())	{usr<<"Cannot relocate at this time...";return}
			if(usr.z==10)	{usr<<"Use the Clan Wars Panel to Exit";return}
			if(usr.InstanceObj && usr.InstanceObj.PvpType)	usr.ExitCP()
			if(usr.CurrentCP)	usr.ExitCP()	//Exit Missions
	Subscribe
		icon_state="SubHUD"
		screen_loc="11,1"
		desc="Become a Stray Games Subscriber for Special Benefits!  Click for More Info..."
		Click()	usr<<link("http://www.angelfire.com/hero/straygames/Subscribe.html")

var/list/KbTypes=list("DeathKB"="1:5,16:-11","StunKB"="1:21,16:-12","GuardBreakKB"="2:5,16:-12","ControlledKB"="2:21,16:-12","HomingKB"="3:5,16:-12","HealingKB"="3:21,16:-12")
var/list/KbDescs=list(\
	"Death Blast"="Deals standard damage.  Will kill an opponent if it depletes their PL.",\
	"Stunner"="Deals no damage, but stuns an opponent for twice as long.",\
	"Guard Breaker"="Breaks Guard Twice as Fast.  Has no Effect Unless Opponent is Guarding.",\
	"Controlled Blast"="Deals standard damage, but will only KO opponents.",\
	"Homing Blast"="Deals standard damage.  Consumes 1 Ki Bar.  Follows Target at Half Speed.",\
	"Healing Blast"="Recovers 10% PL and Revives Fallen Allies.  Consumes 10% PL.",)

var/list/HudBgList=list()
proc/GenerateHudBgList()
	var/Width=5;var/HudY=17
	for(var/HudX=1;HudX<=Width;HudX++)
		var/obj/HUD/HudBG/H=new
		H.icon_state="[HudX-1],[HudY-16]";HudBgList+=H
		H.screen_loc="[HudX]:3,[HudY]:-2"
		if(HudX>=Width && HudY>=17)	{HudX-=Width;HudY-=1}
	Width=5;HudY=17
	for(var/HudX=1;HudX<=Width;HudX++)
		var/obj/HUD/HudBG/H=new;H.icon='HudBGR.png'
		H.icon_state="[HudX-1],[HudY-16]";HudBgList+=H
		H.desc="";H.screen_loc="[HudX+12]:-2,[HudY]:-2"
		if(HudX>=Width && HudY>=17)	{HudX-=Width;HudY-=1}

var/list/HudBarBgList=list()
proc/GenerateHudBarBgList()
	var/StartX=6
	for(var/HudX=StartX;HudX<=StartX+6;HudX++)
		var/obj/HUD/HudBarBG/H=new
		H.icon_state="[HudX-StartX],0"
		H.screen_loc="[HudX],1:2";HudBarBgList+=H

/*mob/var/list/GuardBarList=list()
mob/var/list/EnemyGuardBarList=list()
mob/proc/GenerateGuardBarList()
	var/StartX=1
	for(var/HudX=StartX;HudX<=StartX+3;HudX++)
		var/obj/HUD/GuardBar/H=new
		H.screen_loc="[HudX]:23,16:-4"
		src.GuardBarList+=H
		H.icon_state="32"
	StartX=14
	for(var/HudX=StartX;HudX<=StartX+3;HudX++)
		var/obj/HUD/EnemyGuardBar/H=new
		H.screen_loc="[HudX]:5,16:-2"
		src.EnemyGuardBarList+=H
		H.icon_state="32"

var/list/GuardBarBGsList=list()
proc/GenerateGuardBarBGsList()
	var/StartX=1
	for(var/HudX=StartX;HudX<=StartX+3;HudX++)
		H.icon_state="[HudX-StartX],0"
		H.screen_loc="[HudX]:3,16:4";GuardBarBGsList+=H
	StartX=13
	for(var/HudX=StartX;HudX<=StartX+3;HudX++)
		var/obj/HUD/EnemyGuardBarBG/H=new
		H.icon_state="[HudX-StartX],0"
		H.screen_loc="[HudX]:29,16:6";GuardBarBGsList+=H*/

var/list/TrainingBgList=list()
proc/GenerateTrainingBgList()
	var/Start=6;var/End=13
	for(var/HudX=Start;HudX<=End;HudX++)
		var/obj/HUD/TextBG/H=new
		if(HudX==Start)	H.icon_state="FullL"
		else	if(HudX==End)		H.icon_state="FullR"
		else	H.icon_state="FullM"
		H.screen_loc="[HudX]:-10,10:-1"
		TrainingBgList+=H
	TrainingBgList+=new/obj/HUD/QuitTraining

mob/proc/AddTrainingBG(var/CanQuit=1)
	if(!TrainingBgList.len)	GenerateTrainingBgList()
	for(var/client/C in src.ControlClients)
		C.screen-=TrainingBgList
		C.screen+=TrainingBgList
		if(!CanQuit)	C.screen-=TrainingBgList[TrainingBgList.len]

mob/proc/RemoveTrainingBG()
	for(var/client/C in src.ControlClients)	C.screen-=TrainingBgList

var/obj/HUD/HudProtection/HudProtection=new
mob/proc/AddHudProtection(/**/)
	for(var/client/C in src.ControlClients)	C.screen+=HudProtection
mob/proc/RemoveHudProtection(/**/)
	for(var/client/C in src.ControlClients)	C.screen-=HudProtection

mob/proc/AddHUD()
	for(var/client/C in src.ControlClients)
		if(!HudBgList.len)	GenerateHudBgList()
		if(!HudBarBgList.len)	GenerateHudBarBgList()
		C.screen+=HudBgList
		C.screen+=HudBarBgList
		C.screen+=new/obj/HUD/FaceIcon
		C.mob.WriteHUDText(2,12,17,14,"PlayerName","No Target")
		C.mob.UpdateHUDText("PlayerName",AtName(src.name))
		C.screen+=new/obj/HUD/EnemyFaceIcon
		C.mob.WriteReverseHUDText(16,12,17,12,"EnemyName","No Target")
		C.mob.UpdateReverseHUDText("EnemyName","No Target")
		for(var/v in KbTypes)
			var/obj/HUD/KiBlastType/KBH=new(v,KbTypes[v])
			KBH.name=KbDescs[KbTypes.Find(v)]
			KBH.desc=KbDescs[KBH.name]
			C.screen+=KBH
		C.screen+=new/obj/HUD/SelectedKiBlastType(KbTypes[C.mob.KbType])
		C.screen+=new/obj/HUD/Level_Up
		C.screen+=new/obj/HUD/Click2Instance/PvP_Arena
		C.screen+=new/obj/HUD/Click2Instance/Clan_PvP_Arena
		C.screen+=new/obj/HUD/Click2Instance/Balanced_PvP_Arena
		C.screen+=new/obj/HUD/Player_vs_Player
		C.screen+=new/obj/HUD/Clan_Management
		C.screen+=new/obj/HUD/Exit_Arena
		C.screen+=new/obj/HUD/Subscribe
		C.screen+=global.WorldTournHUD
		C.screen+=global.WishHUD
		C.mob.UpdateKiHUD()
		C.mob.UpdatePlHUD()
		C.mob.UpdateExpBar()
		C.mob.UpdateFaceHUD()
		C.mob.UpdateAlignmentBar()
		//Training HUD
		C.mob.WriteHUDText(6,0,10,16,"TrainingDesc","Attack when {F} Appears to Increase EXP")
		C.mob.WriteHUDText(8,0,10,4,"TrainingCombo","+999% EXP per Attack")
		C.mob.UpdateHUDText("TrainingDesc");C.mob.UpdateHUDText("TrainingCombo")

mob/proc/KiBlastHUD()
	for(var/client/C in src.ControlClients)
		PlaySound(C.mob,'Click.ogg',VolChannel="Menu")
		for(var/obj/HUD/SelectedKiBlastType/O in C.screen)	O.screen_loc=KbTypes[src.KbType]

mob/proc/UpdateFaceHUD()
	for(var/mob/M in src.Targeters)	M.UpdateEnemyFaceHUD()
	for(var/client/C in src.ControlClients)
		for(var/obj/HUD/FaceIcon/I in C.screen)
			I.icon=src.icon;return

mob/var/list/PlBars[4]
mob/proc/UpdatePlHUD()
	for(var/mob/M in src.Targeters)	M.UpdateEnemyPlHUD()
	for(var/mob/M in src.Party)	M.UpdatePartyPL(src)
	for(var/client/C in src.ControlClients)
		var/ThisPercent=round(src.PL/src.MaxPL*100)
		for(var/i=1;i<=4;i++)
			if(!C.mob.PlBars[i])
				var/obj/HUD/PlBar/PLB=new
				PLB.screen_loc="2:[25+(32*(i-1))],17:-10"
				if(i==2 || i==3)	PLB.icon='PlBar2.dmi'
				if(i==4)	PLB.icon='PlBar3.dmi'
				C.screen+=PLB
				C.mob.PlBars[i]=PLB
			var/obj/HUD/PlBar/PLB=C.mob.PlBars[i]
			PLB.icon_state="[max(0,ThisPercent-(32*(i-1)))]"

/*mob/proc/UpdateGuardHUD()
	for(var/mob/M in src.Targeters)	M.UpdateEnemyGuardHUD()
	for(var/client/C in src.ControlClients)
		for(var/i=0;i<=3;i++)
			var/obj/HUD/GuardBar/G=C.mob.GuardBarList[i+1]
			G.icon_state="[min(32,src.GuardLeft-i*32)]"*/

mob/var/obj/HUD/KiBar/KiBar
mob/proc/UpdateKiHUD()
	for(var/mob/M in src.Targeters)	M.UpdateEnemyKiHUD()
	for(var/mob/M in src.Party)	M.UpdatePartyKi(src)
	for(var/client/C in src.ControlClients)
		if(!C.mob.KiBar)
			C.mob.KiBar=new/obj/HUD/KiBar
			C.screen+=C.mob.KiBar
		var/NewIS="[round(src.Ki/src.MaxKi*100)]"
		if(C.mob.KiBar.icon_state!=NewIS)
			C.mob.KiBar.icon_state=NewIS

mob/var/obj/HUD/ExpBar/ExpBar
mob/proc/UpdateExpBar()
	for(var/mob/M in src.Targeters)	M.UpdateEnemyKiHUD()
	for(var/client/C in src.ControlClients)
		if(!C.mob.ExpBar)
			C.mob.ExpBar=new/obj/HUD/ExpBar
			C.screen+=C.mob.ExpBar
		var/NewIS="[round(src.Exp/100*32)]"
		if(C.mob.ExpBar.icon_state!=NewIS)
			C.mob.ExpBar.icon_state=NewIS

mob/var/obj/HUD/AlignmentBar/AlignmentBar
mob/proc/UpdateAlignmentBar()
	for(var/mob/M in src.Targeters)	M.UpdateEnemyKiHUD()
	for(var/client/C in src.ControlClients)
		if(!C.mob.AlignmentBar)
			C.mob.AlignmentBar=new/obj/HUD/AlignmentBar
			C.screen+=C.mob.AlignmentBar
		var/NewIS="[round(src.Alignment/100*32)]"
		if(C.mob.AlignmentBar.icon_state!=NewIS)
			C.mob.AlignmentBar.icon_state=NewIS