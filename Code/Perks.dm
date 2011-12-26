var/list/AllPerks=list()
proc/PopulatePerks()
	AllPerks=typesof(/obj/Perks)-/obj/Perks
	for(var/v in AllPerks)
		AllPerks+=new v;AllPerks-=v
	AllPerks=SortDatumList(AllPerks,"name",High2Low=1)

mob/var/list/SlottedPerks
mob/var/list/UnlockedPerks

mob/proc/DisplayPerks()
	if(!src.SlottedPerks)	src.SlottedPerks=list("Empty","Locked Slot","Locked Slot")
	if(!src.UnlockedPerks || !src.UnlockedPerks.len)	src.UnlockedPerks=list("Empty")
//	winset(src,"LevelWindow.PerksGrid","cells=1x[AllPerks.len-1]")
	var/counter=0
	for(var/v in src.SlottedPerks)
		counter+=1
		for(var/obj/Perks/P in AllPerks)	if(P.name==v)
			src<<output(P,"LevelWindow.Perk[counter]Grid:1,1")
			src<<output(P.desc,"LevelWindow.Perk[counter]Grid:2,1")
			break

	counter=0
	for(var/obj/Perks/P in AllPerks)
		if(P.invisibility)	continue
		else	counter+=1
		if(P.name!="Empty" && (P.name in src.SlottedPerks))
			P.icon_state="Lock"
			P.mouse_drag_pointer=null
		else
			if(P.name in src.UnlockedPerks)
				P.icon_state="UnLocked"
				P.mouse_drag_pointer="Lock"
			else
				P.icon_state="Locked"
				P.mouse_drag_pointer=null
		src<<output(P,"LevelWindow.PerksGrid:1,[counter]")
	//	src<<output(P.desc,"LevelWindow .PerksGrid:2,[counter]")
	winset(src,"LevelWindow.PerkP","text=\"[src.PerkPoints]\"")
	winset(src,"LevelWindow","is-visible=true")
	usr.UpdateTraits()

mob/proc/HasPerk(var/Perk2Have)
	if(src.InTournament && global.TournPerks=="Disabled")	return
	if(Perk2Have in src.SlottedPerks)	return 1
mob/verb/BuyPerk()
	set name=".BuyPerk"
	//PerkInfo
	var/PpMsg="\nYou Gain 1 Perk Point every 10,000 Levels"
	if(usr.PerkPoints>=1)
		if(alert(usr,"Spend 1 of your [usr.PerkPoints] Perk Points to Unlock [src.SelectedPerk]?[PpMsg]","Purchase Perk","Unlock","Cancel")=="Unlock")
			if(usr.PerkPoints<1 || (src.SelectedPerk in usr.UnlockedPerks))	return
			if(src.SelectedPerk=="Locked Slot")
				if(!("Locked Slot" in usr.SlottedPerks))	return
				usr.SlottedPerks-="Locked Slot"
				usr.SlottedPerks+="Empty"
			else
				usr.UnlockedPerks+=src.SelectedPerk
				usr.TrackStat("Perks Unlocked","[usr.UnlockedPerks.len]/[global.AllPerks.len]")
				if(usr.UnlockedPerks.len>=global.AllPerks.len-1)	usr.GiveMedal(new/obj/Medals/Perkfect)
			usr.PerkPoints-=1;usr.DisplayPerks()
	else	alert(usr,"You don't have any Perk Points![PpMsg]","No Points!")
obj/Perks
	icon='Other.dmi'
	icon_state="Locked"
	mouse_drag_pointer="Lock"
	Click()
		if(src.name in usr.UnlockedPerks)	{winset(usr,"LevelWindow.BuyPerk","is-disabled=true")}
		else	{winset(usr,"LevelWindow.BuyPerk","is-disabled=false")}
		usr.SelectedPerk=src.name
		usr<<output(null, "LevelWindow.PerkInfo")
		usr<<output("[src.name]: [src.desc]", "LevelWindow.PerkInfo")
	MouseDrop(over_object,src_location,over_location,src_control,over_control,params)
		var/DropSlot
		if(findtext(over_control,"Perk1Grid"))	DropSlot=1
		else if(findtext(over_control,"Perk2Grid"))	DropSlot=2
		else if(findtext(over_control,"Perk3Grid"))	DropSlot=3
		if(DropSlot)
			if(usr.SlottedPerks[DropSlot]=="Locked Slot")	return
			if(src.name!="Empty" && (src.name in usr.SlottedPerks))	return
			if(!(src.name in usr.UnlockedPerks))	return
			usr.SlottedPerks[DropSlot]=src.name
			usr.DisplayPerks()


	Locked_Slot
		invisibility=1
		mouse_drag_pointer=null
		desc="Purchase to Unlock a New Perk Slot."

	Empty
		icon_state="UnLocked"
		desc="No Perk Slotted.  No Effect Gained."
	Breathless
		desc="You can survive indefinitely without an air supply."
	Last_Gasp
		desc="Prevents your PL from dropping to 0 when taking excessive damage."
	Keep_It_Up
		desc="Prevents Reverting when Hit with less than 1 Bar of Ki."
	//UnShakable
	//	desc="You won't be stunned when hit, but will attack half as fast."
//	Fighting_Spirit
//		desc="You can't be KOed, but can still be Destroyed.  Guarding Disabled at 0 PL."
	Power_Charge
		desc="Doubles the Rate at which you Charge PL, but Halves Ki Rate."
	Energy_Charge
		desc="Doubles the Rate at which you Charge Ki, but Halves PL Rate."
	Energy_Boost
		desc="You Get an Additional 1% Ki Gained from Melee Combat."
	Teleport_Efficiency
		desc="Manual Teleport Counters require Half as much Ki"
	//KnockBack_Resistance
	//	desc="You can't be Thrown by Teleport Counters or Other Special Attacks."
	Adrenaline_Rush
		desc="Recover 10% of your PL and Ki whenever you Destroy an Enemy."
	Adrenaline_Rush_II
		desc="Recover 10% of your PL and Ki whenever you Knock Out an Enemy."
	Warrior
		desc="Your Melee Attacks Deal 110% Damage, but Energy Attacks Deal 50%."
	//Flash_Finish
	//	desc="Instantly Launch Special Attacks at 50% Damage"
	//BulletProof
	//	desc="Ki Blasts Bounce off of you, but Other Attacks Deal 2x Damage. (PvP Only)"
	Energy_Shield
		desc="Take 10% Less Damage, Consumes 10% Ki Each Hit."
	Ultimate_Power
		desc="Damage Multiplier Based on Max PL instead of Transformation"
	Heightened_Senses
		desc="Slows Any Ki Blasts Fired Nearby"
	//Beam_BreakThrough
	//	desc="Your Beams will BreakThrough Opponents Guard"
	Boost
		desc="Provides a +0.1 Damage Multiplier"
	Energy_Absorb
		desc="Gain 5% Ki when Blocking Energy Attacks"
	Ki_Stun
		desc="Doubles Hit Stun Duration on Opponents with 0% Ki"
	After_Image
		desc="Automatically Teleport Counter.  Consumes 2 Ki Bars"
	Perpetual_Energy
		desc="Automatically Recover 1% Ki per Second"
	/*Regeneration
		desc="Automatically Recover 1% PL per Second"*/
	Auto_Experience
		desc="Automatically Gain 1% Exp per Second"
	Graceful_Recovery
		desc="Recover from KO with Double the PL and Ki"
	Training_Focus
		desc="Raises the Max Exp for P.Bags and Shadow Sparring by 10"
	Auto_Aim
		desc="The Final Attack in your Combo will Face your Target"
	//Rush_Combo
	//	desc="Combos Knock Back in 4 instead of 5 Attacks"
	//Beam_Fanatic
	//	desc="Force Opponents into Beam Battles"
	//Taunt
	//	desc="Force Opponents into Beam Battles when Launching a Beam"
	//Beam_Reflex
	//	desc="Automatically Trigger Beam Battles against Attackers"
	//Weakling
	//	desc="Teleport Counters won't Knock Back your Opponents"
	Spirit_Crusher
		desc="KOed Opponents will Require Double Effort to Recover"
	//Wide_Awake
	//	desc="Halve the Effort Required for KO Recovery"
	Quick_Learner
		desc="Increases all Experience Earned by 10%"
	Draining_Touch
		desc="Successful Melee Attacks Steal 1% of your Opponents Ki"
	Bottled_Rage
		desc="Recover Double the Amount of Ki from Taking Damage"
	Intense_Training
		desc="Gain an Additional 10% Exp, but Lose 0.1 Damage Multiplier"
	Hold_Charge
		desc="Beams will not Fire when Fully Charged, Until Released"
	IT_KameHameHa
		desc="Teleport Beam Attack if Hit while Fully Charged.  Consumes All Ki"
	Pull
		desc="Automatically Pick Up Zenie from Chests and Enemies"
	Pickpocket
		desc="Successfull Melee Attacks will Steal 10 Zenie"
	//Combat_Shield
	//	desc="Guard Meter will still Recharge while Hit-Stunned"
//	Flash_Combo
	//	desc="Attack Faster, but Double the Time between Combos"