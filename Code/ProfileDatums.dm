var/list/LastDatumList=list()

proc/ProfileDatums()
	set background=1
	for(var/datum/D)
		if(!LastDatumList.Find("[D.type]"))	LastDatumList+="[D.type]"
		LastDatumList["[D.type]"]+=1
	for(var/datum/D in world)
		if(isturf(D) || isarea(D))	continue
		if(!LastDatumList.Find("[D.type]"))	LastDatumList+="[D.type]"
		LastDatumList["[D.type]"]+=1

mob/Test/verb/Profile_Datums()
	set category="Test"
	set background=1
	usr<<"Starting Datum Profiler..."
	var/list/DatumList=list()
	var/TotalCount=0
	for(var/datum/D)
		if(!DatumList.Find("[D.type]"))	DatumList+="[D.type]"
		DatumList["[D.type]"]+=1;TotalCount+=1
	for(var/datum/D in world)
		if(isturf(D) || isarea(D))	continue
		if(!DatumList.Find("[D.type]"))	DatumList+="[D.type]"
		DatumList["[D.type]"]+=1;TotalCount+=1
	var/UpOutput="<center><table border=1>"
	UpOutput+="<tr><td><b>Total Datum Count<td><b>[FullNum(TotalCount)]"
	UpOutput+="<tr><td><b>Datum Type<td><b>UP Type Count"
	var/DownOutput="<table border=1><tr><td><b>Datum Type<td><b>DOWN Type Count"
	var/NewOutput="<table border=1><tr><td><b>Datum Type<td><b>NEW Type Count"
	var/HtmlOutput="<table border=1><tr><td><b>Datum Type<td><b>SAME Type Count"
	for(var/v in DatumList)
		if(v in LastDatumList)
			if(LastDatumList[v]<DatumList[v])
				var/OT="";if(DatumList[v]>=100)	OT="<font color=red>"
				UpOutput+="<tr><td>[v]<td><b>[OT][DatumList[v]] (Up From) [LastDatumList[v]]"
			else
				if(LastDatumList[v]>DatumList[v])
					var/OT="";if(DatumList[v]>=100)	OT="<font color=red>"
					DownOutput+="<tr><td>[v]<td><i>[OT][DatumList[v]] (Down From) [LastDatumList[v]]"
				else
					var/OT="";if(DatumList[v]>=100)	OT="<font color=red>"
					HtmlOutput+="<tr><td>[v]<td>[OT][DatumList[v]]"
		else
			var/OT="";if(DatumList[v]>=100)	OT="<font color=red>"
			NewOutput+="<tr><td>[v]<td>[OT][DatumList[v]] (New)"
	LastDatumList=list();LastDatumList+=DatumList
	UpOutput+="</table>";DownOutput+="</table>";NewOutput+="</table>";HtmlOutput+="</table>"
	usr<<browse(UpOutput+DownOutput+NewOutput+HtmlOutput,"window=Profile Datums")
	usr<<"Datum Profiler Complete!"