obj/NPCs
	density=1
	icon='NPCs.dmi'
	layer=MOB_LAYER
	New()
		src.AddName()
		return ..()
	Banker
		icon_state="Banker"
		verb/Balance()
			set src in oview()
			alert("You have [FullNum(usr.BankedZenie)] Zenie in the Bank!","[src]")
		verb/Deposit()
			set src in oview()
			var/Amt=min(usr.Zenie,input("How much Zenie would you like to Deposit?\nYou currently have [FullNum(usr.BankedZenie)] Zenie in the Bank.","[src]",usr.Zenie) as num)
			if(Amt<=0)	return
			usr.Zenie-=Amt;usr.BankedZenie+=Amt
			if(usr.BankedZenie>999999)	usr.GiveMedal(new/obj/Medals/Millionaire)
			src.Balance()
		verb/Withdraw()
			set src in oview()
			var/Amt=min(usr.BankedZenie,input("How much Zenie would you like to Withdraw?\nYou currently have [FullNum(usr.BankedZenie)] Zenie in the Bank.","[src]",usr.BankedZenie) as num)
			if(Amt<=0)	return
			usr.Zenie+=Amt;usr.BankedZenie-=Amt
			src.Balance()
	Master_Roshi
		icon_state="MasterRoshi"
		verb/Start_Mission()
			set category=null
			set src in oview()
			var/datum/Missions/M=input("Select a Mission:","Mission Select") as null|anything in AllMissions
			if(!M || MyGetDist(usr,src)>8)	return
			usr<<"Generating instance..."
			if(!GenerateConceptPieceMap(usr,M))	usr<<"All Mission Instances are being Used!"
			else
				usr.CompleteTutorial("Missions")
				usr.TrackStat("Missions Attempted",1)
				usr.ShowTutorial(Tutorials["Clearing Missions"])
				usr.ShowTutorial(Tutorials["Mission Completion"])