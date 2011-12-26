var/list/GlobalMuteList=list()

mob/proc/IsMuted()
	if(src.CheckGlobalMute())	return 1

mob/proc/CheckGlobalMute()
	if(src.client.address in GlobalMuteList)
		src<<"<b>Mute Reason:</b> [GlobalMuteList[src.client.address]]"
		src<<"You are Globaly Muted in Stray Games";return 1
	if(src.key in GlobalMuteList)
		src<<"<b>Mute Reason:</b> [GlobalMuteList[src.key]]"
		src<<"You are Globaly Muted in Stray Games";return 2
	if(src.client.computer_id in GlobalMuteList)
		src<<"<b>Mute Reason:</b> [GlobalMuteList[src.client.computer_id]]"
		src<<"You are Globaly Muted in Stray Games";return 3
	var/list/PlayerOctets=Split(src.client.address,".")
	for(var/x in GlobalMuteList)
		if(findtext(x,"*",1,0))
			var/list/OctetList=Split(x,".")
			if(OctetList.len>=2 && PlayerOctets.len>=2)
				if(PlayerOctets[1]==OctetList[1] && PlayerOctets[2]==OctetList[2])
					src<<"<b>Mute Reason:</b> [GlobalMuteList[x]]"
					src<<"This IP Range is Globaly Muted in Stray Games";return 4
	return 0

proc/LoadGlobalMutes(var/RepeatLoad=1)
	var/http[]=world.Export("http://www.angelfire.com/hero/straygames/GlobalMutes.txt")
	if(!http)
		if(RepeatLoad)	spawn(600)	LoadGlobalMutes()
		return
	var/FullText=file2text(http["CONTENT"])
	GlobalMuteList=list()
	var/CurPos=1
	var/MuteReason="Unknown"
	while(findtext(FullText,"\n",CurPos,0))
		var/NextPos=findtext(FullText,"\n",CurPos,0)
		var/ThisMuteLine=copytext(FullText,CurPos,NextPos)
		if(copytext(ThisMuteLine,1,3)=="//")	MuteReason=copytext(ThisMuteLine,3)
		GlobalMuteList+=ThisMuteLine
		GlobalMuteList[ThisMuteLine]=MuteReason
		CurPos=NextPos+1
	if(RepeatLoad)	spawn(36000)	LoadGlobalMutes()
	world<<"[ServerTag] Global Mute List Successfully Loaded"