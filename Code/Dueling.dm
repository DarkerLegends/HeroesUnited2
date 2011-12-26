mob/var
	DuelOutID
	mob/Dueling
	list/DuelIgnores
	list/DuelRequests
	obj/Supplemental/DuelFlag/DuelFlag

obj/Supplemental/DuelFlag
	density=0
	var/DuelType="Balanced"
	icon='Other.dmi';icon_state="DuelFlag"

mob/proc/DuelRangeCheck()
	if(src.DuelFlag)
		if(MyGetDist(src,src.DuelFlag)>world.view)	if(!src.DuelOutID)	spawn()	src.DuelRangeCount(src.DuelFlag)
		else	src.DuelOutID=0

mob/proc/DuelRangeCount(var/obj/ThisDuelFlag)
	src<<"<b><font color=red>You have left the Duel Area!"
	src<<"<b><font color=red>Return to the Duel Area within 10 Seconds!"
	var/ThisID=rand(1,999999)
	src.DuelOutID=ThisID
	sleep(100);if(!ThisDuelFlag || src.DuelOutID!=ThisID)	return
	if(MyGetDist(src,DuelFlag)>world.view)
		src.TrackStat("[src.DuelFlag.DuelType] Duels Fled",1)
		src.Dueling.TrackStat("[src.DuelFlag.DuelType] Duels Canceled",1)
		src<<"Duel Canceled; You Fled!"
		src.Dueling<<"Duel Canceled; [src] Fled!"
		src.EndDuel()

mob/proc/EndDuel(/**/)
	if(src.Dueling)	src.Dueling.Dueling=null
	if(src.DuelFlag)	del src.DuelFlag
	src.Dueling=null

mob/verb/Duel(/**/)
	set hidden=1
	set category=null
	set src in oview()
	var/DuelType=alert("Select Duel Type","Duel","Balanced","Stat Based")
	if(src.FusionMob)	{usr<<"[src] has Fused!";return}
	//if(usr.InstanceLoc || src.InstanceLoc)	{usr<<"You cannot Duel on Instance Maps!";return}
	if(!src.ControlClients)	{usr<<"You cannot Duel NPCs!";return}
	if(src.IgnoreDuels)	{usr<<"[src] is Ignoring all Duel Requests";return}
	if(usr.Dueling)	{usr<<"You are already Dueling with [usr.Dueling]";return}
	if(src.Dueling)	{usr<<"[src] is already Dueling with [src.Dueling]";return}
	if(usr in src.DuelRequests)	{usr<<"You Already Sent [src] a Duel Request!";return}
	if(usr.key in src.DuelIgnores)	{usr<<"[src] is Ignoring Your Duel Requests";return}
	usr<<"Duel Request Sent to [src]"
	if(!src.DuelRequests)	src.DuelRequests=list()
	src.DuelRequests+=usr
	src.PopupHUD(new/obj/HUD/Popups/Duel_Request(usr,DuelType),"[DuelType] Duel Request from [usr]")

mob/proc/AcceptDuel(var/mob/M,var/DuelType)
	var/Choice=alert(src,"[M] has Challenged you to a [DuelType] PvP Duel!","Duel Request","Accept","Decline","Ignore")
	src=src.GetFusionMob()
	src.DuelRequests-=M;if(!M)	{src<<"Challenger has Logged Out...";return}
	M=M.GetFusionMob()
	if(Choice!="Accept")
		M<<"[src] has Declined your Duel Request..."
		if(Choice=="Ignore")
			if(!src.DuelIgnores)	src.DuelIgnores=list()
			src.DuelIgnores+=M.key
		return
	if(M.Dueling || src.Dueling)	{src<<"Already Dueling!";return}
	if(M.InstanceLoc || src.InstanceLoc)	{src<<"You cannot Duel on Instance Maps!";return}
	if(MyGetDist(M,src)>world.view)	{M<<"Challenger out of Range...";src<<"Challenger out of Range...";return}
	if(M.InTournament || src.InTournament)	{src<<"Can't Duel while in the World Tournament!";return}
	M<<"[src] has Accepted your Duel Request!"
	M.Dueling=src;src.Dueling=M
	M.DuelOutID=0;src.DuelOutID=0
	var/obj/Supplemental/DuelFlag/D=new(M.loc)
	D.DuelType=DuelType
	D.icon_state="[DuelType]DuelFlag"
	M.DuelFlag=D;src.DuelFlag=D
	D.name="[M] vs [src]";D.AddName()