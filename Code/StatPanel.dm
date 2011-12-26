mob/var/AFK
var/obj/AfkIcon/AfkIcon=new
obj/AfkIcon
	pixel_x=8
	pixel_y=8
	icon='Other.dmi'
	icon_state="AFK"
	layer=FLOAT_LAYER

mob/Stat()
	if(statpanel("Stats"))
		if(!src.AFK)
			var/mob/StatMob=src.GetFusionMob()
			if(StatMob.CurrentMission)
				stat("<u>Mission Goals</u>")
				stat("Bosses:","0/1")
				stat("Enemies:","[round(StatMob.GetTrackedStat("NPCs Killed",StatMob.TempTracked))]/[StatMob.CurrentMission.EnemyCount]")
				stat("Chests:","[round(StatMob.GetTrackedStat("Chests Opened",StatMob.TempTracked))]/[StatMob.CurrentMission.ChestCount]")
				stat("Hazards:","0/0")
				stat("Obstacles:","0/0")
				stat("DragonBalls:","0/0")
				stat("Side Quests:","0/0")
				stat("<u>Character Stats</u>")
			stat("Level:","[FullNum(src.Level)]")
			stat("Experience:","[src.Exp]%")
			stat("Training Exp:","[FullNum(src.TrainingExp)]%")
			stat("Damage:","x[StatMob.CalcDamMult()]")
			stat("Power Level:","[FullNum(StatMob.PL)] ([round(StatMob.PL/StatMob.MaxPL*100)]%)")
			stat("Ki Energy:","[FullNum(StatMob.Ki)] ([round(StatMob.Ki/StatMob.MaxKi*100)]%)")
			stat("Strength:","[FullNum(StatMob.Str)]")
			stat("Defense:","[FullNum(StatMob.Def)]")
			stat("Zenie:","[FullNum(StatMob.Zenie)]")
			stat("$ Points:","[FullNum(StatMob.CashPoints)]")
			stat("Wishes:","[src.WishesMade] Made Today")
			if(src.z)	stat("Location:","[StatMob.x], [StatMob.y], [MapNames["[StatMob.z]"]]")
		else
			stat("You have been Idle for 5+ Minutes")
			stat("AFK Stat Panel Mode Conserves CPU Usage")
			stat("Level:","[src.Level]")
			stat("Experience:","[src.Exp]%")
			stat("Training Exp:","[src.TrainingExp]%")

	if(!src.AFK)
		if(statpanel("Inventory"))
			if(src.z==10)
				stat("<u>TW Materials:")
			stat("<u>Parts Inventory:")
			stat(src.PartsInventory)
	/*	if(statpanel("Capsules"))
			//stat("Characters ([src.CapsuleChars.len]/[global.AllCapsuleChars.len])")
			//stat(global.CapsuleCharGuide)
			stat(src.CapsuleChars)
			stat("Upgrades (0/0)")
			stat("Vehicles (0/0)")
			stat("Deployables (0/0)")*/

		if(statpanel("Medals"))
			stat(VMP)
			stat("<u>You've Earned [src.Medals.len] of [AllMedals.len] Medals")
			stat(src.MedalObjs)
			stat("")
			stat("<u>[AllMedals.len-src.Medals.len] Medals Remaining")
			stat(AllMedals-src.MedalObjs)

		if(statpanel("Controls"))
			stat("Arrow Keys:","Movement")
			stat("Double Tap:","Sprint/Sonic Flight")
			stat("1-6:","Change Ki Blast")
			stat("Shift+Up Arrow:","Fly")
			stat("Shift+Down Arrow:","Land")
			stat("F:","Fast Attack")
			stat("S:","Strong Attack - Unfinished")
			stat("Hold G:","Guard")
			stat("Tap G:","KO Recovery (When KOed)")
			stat("Tap G:","Teleport Counter -1 Bar")
			stat("D:","Ki Blast -1/2 Bar")
			stat("Shift+D:","Beam -1 Bar")
			stat("Hold Shift+D:","Charge Beam Attack")
			stat("Hold A:","Power Up")
			stat("Shift+A:","Transform >= 3 Bars")
			stat("Ctrl+A:","Step Transform >= 3 Bars")
			stat("Shift+Z:","Full Revert")
			stat("Ctrl+Z:","Step Revert")
			stat("M:","Mini Map")

		if(statpanel("Players"))
			stat("[Players.len] Players Online:")
			stat(Players)

		if(statpanel("Friends"))
			stat("<u>[src.OnlineFriends.len] Friends Online")
			stat(src.OnlineFriends)
			stat("<u>[src.Friends.len] Friends")
			stat(src.Friends)

	if(statpanel("Server"))
		stat("Host:","[world.host]")
		stat("Version:","[GameVersion].0")
		stat("Usage:","[world.cpu]%")
		stat("Players:","[Players.len]")
		stat("Up Time:","[Hours]:[Minutes]:[Seconds]")
		stat("Time Zone:","[time2text(world.timeofday,"hh:mm:ss")]")

/*var/obj/ClickableStatObj/ClickableStatObj=new
obj/ClickableStatObj
	name="Click Here to View Stats"
	Click()
		var/LabelText=""
		var/mob/StatMob=usr.GetFusionMob()
		if(StatMob.CurrentMission)
			LabelText+="Mission Goals\n"
			LabelText+="Bosses:    0/1\n"
			LabelText+="Enemies:    [round(StatMob.GetTrackedStat("NPCs Killed",StatMob.TempTracked))]/[StatMob.CurrentMission.EnemyCount]\n"
			LabelText+="Chests:    [round(StatMob.GetTrackedStat("Chests Opened",StatMob.TempTracked))]/[StatMob.CurrentMission.ChestCount]\n"
			LabelText+="Hazards:    0/0\n"
			LabelText+="Obstacles:    0/0\n"
			LabelText+="DragonBalls:    0/0\n"
			LabelText+="Side Quests:    0/0\n"
			LabelText+="\nCharacter Stats\n"
		LabelText+="Level:    [FullNum(usr.Level)]\n"
		LabelText+="Experience:    [usr.Exp]%\n"
		LabelText+="Damage:    x[StatMob.CalcDamMult()]\n"
		LabelText+="Power Level:    [FullNum(StatMob.PL)] ([round(StatMob.PL/StatMob.MaxPL*100)]%)\n"
		LabelText+="Ki Energy:    [FullNum(StatMob.Ki)] ([round(StatMob.Ki/StatMob.MaxKi*100)]%)\n"
		LabelText+="Strength:    [FullNum(StatMob.Str)]\n"
		LabelText+="Defense:    [FullNum(StatMob.Def)]\n"
		LabelText+="Zenie:    [FullNum(StatMob.Zenie)]\n"
		LabelText+="$ Points:    [FullNum(StatMob.CashPoints)]\n"
		if(StatMob.z)	LabelText+="Location:    [StatMob.x], [StatMob.y], [MapNames["[StatMob.z]"]]"
		winset(usr,"StatPanelWindow.StatLabel","text=\"[LabelText]\"")
		winset(usr,"StatPanelWindow","pos=100,100;size=488x488;is-visible=true")
		return ..()*/