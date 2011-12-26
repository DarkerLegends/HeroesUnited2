mob/var
	list/TempTracked	//Reset for Current Goals
	list/ThisPlayTracked	//Tracks Play Session
	list/RecordedTracked	//All-Time Tracked

mob/proc
	GetTrackedStat(var/Stat,var/list/List)
		if(Stat in List)	return List[Stat]
	ResetTrackedStats(var/list/Tracks)
		for(var/v in Tracks)	if(v in src.TempTracked)	src.TempTracked[v]=null
	TrackStat(var/Stat,var/Value,var/TrackingType="Total",var/Listing="Once")
		if(!src.ControlClients && !src.Owner)	return
		if(!src.TempTracked)	src.TempTracked=list()
		if(!src.ThisPlayTracked)	src.ThisPlayTracked=list()
		if(!src.RecordedTracked)	src.RecordedTracked=list()
		for(var/v in list("TempTracked","ThisPlayTracked","RecordedTracked"))
			var/list/L=src.vars[v]
			if(!(Stat in L))	L+=Stat
			if(TrackingType=="List")
				if(!L[Stat])	L[Stat]=list()
				if(Listing=="Once")	if(!(Value in L[Stat]))
					L[Stat]+=Value
					if(v=="RecordedTracked")
						if(Stat=="Days Played" && src.Level>1)	src.AddExp(100*100,"Daily Level Reward")
						if(Stat=="Days Subscribed" && src.Level>1)	src.AddExp(100*1000,"Daily Subscriber Level Reward")
				else	L[Stat]+=Value
			else
				if(isnum(Value))
					if(TrackingType=="Highest")	if(L[Stat]==null || L[Stat]<Value)	L[Stat]=Value
					else	if(TrackingType=="Lowest")	if(L[Stat]==null || L[Stat]>Value)	L[Stat]=Value
					else	L[Stat]+=Value
				else	L[Stat]=Value

proc/islist(var/L)
	return istype(L,/list)

mob/verb/Sense()
	set src in world
	set category=null
	var/HTML="<title>[src]'s Stat Tracking</title><body bgcolor=black><center>"
	var/Fmt="<font color=[rgb(255,128,0)]>"
	var/TdR="<td align=right>"
	var/TdC="<td><center>"
	HTML+="<table bgcolor=[rgb(0,0,64)] border=1 width=100%>"
	HTML+="<tr>[TdC][Fmt]<b>Stat[TdC][Fmt]<b>Active[TdC][Fmt]<b>Session[TdC][Fmt]<b>Total"
	for(var/v in src.RecordedTracked)
		var/list/L=list("ActiveStat","SessionStat","TotalStat")
		L["ActiveStat"]=src.GetTrackedStat(v,src.TempTracked)
		L["SessionStat"]=src.GetTrackedStat(v,src.ThisPlayTracked)
		L["TotalStat"]=src.GetTrackedStat(v,src.RecordedTracked)
		for(var/s in L)
			if(isnum(L[s]))	L[s]=FullNum(L[s])
			else	if(L[s]==null)	L[s]="-"
			else	if(islist(L[s]))	{var/list/LenList=L[s];L[s]="[LenList.len]"}
		HTML+="<tr><td>[Fmt][v]<b>:[TdR][Fmt][L["ActiveStat"]][TdR][Fmt][L["SessionStat"]][TdR][Fmt][L["TotalStat"]]"
	HTML+="</table>"
	usr<<browse(HTML,"window=PlayerStats")