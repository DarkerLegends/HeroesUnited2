var/list/AllStats=list()
proc/PopulateStats()
	AllStats=typesof(/obj/Stats)-/obj/Stats
	for(var/v in AllStats)
		AllStats+=new v
		AllStats-=v

mob/verb/AdvanceStat(var/Tag as null|text)
	set hidden=1
	var/obj/Stats/S=locate(Tag)
	if(!S.Advances)	alert("Due to Pending Updates:  This Stat Cannot be Advanced Yet.","Error")
	else
		if(usr.TraitPoints>=1)
			var/Points2Add=round(input("You have [usr.TraitPoints] Stat Points \nHow many do you want to add?","Advance Stat",usr.TraitPoints) as num)
			if(Points2Add<=0 || usr.TraitPoints<Points2Add)	return
			if(!usr.Traits)	usr.Traits=list()
			if(!(S.name in usr.Traits))	usr.Traits+=S.name
			if(usr.vars["[S.Advances]"]+(S.Amt*Points2Add)>999999)
				var/Difference=999998-usr.vars["[S.Advances]"]
				Points2Add=round(Difference/S.Amt)+1
			usr.Traits[S.name]=text2num(usr.Traits[S.name])
			usr.Traits[S.name]+=Points2Add
			usr.TraitPoints-=Points2Add
			usr.vars["[S.Advances]"]+=S.Amt*Points2Add
			usr.vars["[S.Advances]"]=min(999999,usr.vars["[S.Advances]"])
			if(usr.vars["[S.Advances]"]>=999999)	usr.GiveMedal(new/obj/Medals/StatCap)
			if(S.Advances=="MaxPL" && usr.MaxPL>9000)	usr.GiveMedal(new/obj/Medals/ItsOver9000)
			if(usr.MaxPL>=999999 && usr.MaxKi>=999999 && usr.Str>=999999 && usr.Def>=999999)	usr.GiveMedal(new/obj/Medals/PerfectWarrior)
			usr.UpdatePlHUD();usr.UpdateKiHUD()
			usr.CompleteTutorial("Stat Points")
			S.Click()
			usr.UpdateTraits()
		else	alert("Not Enough Stat Points!","Error")
mob/verb/UseTrait(var/Tag as null|text)
	set hidden=1
	var/obj/Stats/S=locate(Tag)
	if(!S.suffix)	return
	winset(usr,"StatWindow.NameLabel","text=\"[S.name]\"")
	winset(usr,"StatWindow.SuffixLabel","text=\"[S.suffix]\n[S.desc]\"")
	winset(usr,"StatWindow.AdvanceStatBtn","command=\"AdvanceStat [S.tag]\"")
	var/NextText="No Advancement Data Available"
	if(S.Advances)
		var/Numby=usr.vars[S.Advances]
		if(isnum(Numby))	Numby=FullNum(Numby)
		NextText="Current [S.name]: [Numby]"
	winset(usr,"StatWindow.NextLabel","text=\"[NextText]\"")
	winset(usr,"StatWindow","size=440x184;pos=50,75;is-visible=true")
mob/proc/UpdateTraits()
	winset(src,"LevelWindow.TP","text=\"[FullNum(src.TraitPoints)]")
	winset(src,"LevelWindow.MaxPL","text=\"[FullNum(src.MaxPL)]")
	winset(src,"LevelWindow.MaxKi","text=\"[FullNum(src.MaxKi)]")
	winset(src,"LevelWindow.MaxStr","text=\"[FullNum(src.Str)]")
	winset(src,"LevelWindow.MaxDef","text=\"[FullNum(src.Def)]")
obj/Stats
	var/Advances
	var/Amt=1
	icon='HUD.dmi'
	icon_state="Stats+"
	New()
		src.tag="[src.name]"
		return ..()
	Click()
		if(!src.suffix)	return
		winset(usr,"StatWindow.NameLabel","text=\"[src.name]\"")
		winset(usr,"StatWindow.SuffixLabel","text=\"[src.suffix]\n[src.desc]\"")
		winset(usr,"StatWindow.AdvanceStatBtn","command=\"AdvanceStat [src.tag]\"")
		var/NextText="No Advancement Data Available"
		if(src.Advances)
			var/Numby=usr.vars[src.Advances]
			if(isnum(Numby))	Numby=FullNum(Numby)
			NextText="Current [src.name]: [Numby]"
		winset(usr,"StatWindow.NextLabel","text=\"[NextText]\"")
		winset(usr,"StatWindow","size=440x184;pos=50,75;is-visible=true")

	Power_Level
		Amt=10
		Advances="MaxPL"
		suffix="Increases your Maximum Power Level by 10."
		desc="Increases how much total damage you can take before getting KOed or Destroyed."
	Ki
		Amt=20
		Advances="MaxKi"
		suffix="Increases your Maximum Ki by 20."
		desc="Increases damage dealt by your Ki Attacks."
	Strength
		Amt=2
		Advances="Str"
		suffix="Increases your Maximum Strength by 2."
		desc="Increases damage dealt by your Melee Attacks."
	Defense
		Amt=1
		Advances="Def"
		suffix="Increases your Maximum Defense by 1."
		desc="Decreases damage taken from Attacks."