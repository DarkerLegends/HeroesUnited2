var/list/SubList=list()
mob/var/Subscriber=0

mob/verb/SubscribeMenu()
	set hidden=1
	switch(alert("Zidz Productionz Subscription","Subscribe","More Info","Check Sub","Subscribe Now"))
		if("Check Sub")	usr.SubCheck()
		if("Subscribe Now")	usr<<link("http://www.angelfire.com/hero/straygames/Subscribe.html")

proc/LoadSubs(var/Loop=1)
	var/http[]=world.Export("http://hassanjalil.angelfire.com/subscription.txt")
	if(!http)	//Site could not be contacted
		if(Loop)	spawn(600)	LoadSubs()
		return
	var/F=file2text(http["CONTENT"])
	if(copytext(F,1,2)!="B")	//Invalid site reached?
		if(Loop)	spawn(600)	LoadSubs()
		return
	SubList=list()
	var/counter=1
	while(findtext(F,"\n",counter,0))
		var/SubLine=copytext(F,counter,findtext(F,"\n",counter,0))
		var/list/SplitList=Split(SubLine,"/")
		for(var/x in SplitList)	SubList+=x
		counter=findtext(F,"\n",counter,0)+1
	world<<"[ServerTag] Subscriber List Successfully Loaded"
	ActivateNewSubs()
	if(Loop)	spawn(36000)	LoadSubs()

proc/ActivateNewSubs()
	for(var/mob/M in Players)
		if(M.Subscriber)		if(!SubKeyCheck(M.key))
			M.RemoveSub();world<<"[M]'s Subscription Expired =("
		else	if(SubKeyCheck(M.key))
			M.SubCheck();world<<"[M]'s Subscription is now Active =D"

mob/proc/ResetSubBonuses()
	src.DisplayNameColor=initial(src.DisplayNameColor)
	src.NameColor=initial(src.NameColor)
	src.FontColor=initial(src.FontColor)
	src.FontFace=initial(src.FontFace)
	src.name=src.key;src.AddName()

mob/proc/RemoveSub()
	src.Subscriber=0
	src.ResetSubBonuses()
	src.verbs-=typesof(/mob/Subscriber/verb)

proc/SubKeyCheck(var/Key2Check)
	var/CurrentDate=text2num(time2text(world.timeofday,"YYMMDD"))
	var/KeyLocation=SubList.Find(Key2Check,1,0)
	if(KeyLocation)
		var/ExpDate=SubList[KeyLocation+1]
		var/Converted=copytext(ExpDate,7,9)+copytext(ExpDate,1,3)+copytext(ExpDate,4,6)
		var/ExpDateNum=text2num(Converted)
		if(ExpDateNum-CurrentDate>0)	return 1

mob/proc/SubCheck()
	SubInfo()
	var/CurrentDate=text2num(time2text(world.timeofday,"YYMMDD"))
	src.verbs+=/mob/Subscriber/verb/Subscribe
	var/KeyLocation=SubList.Find(src.key,1,0)
	if(KeyLocation)
		var/ExpDate=SubList[KeyLocation+1]
		var/Converted=copytext(ExpDate,7,9)+copytext(ExpDate,1,3)+copytext(ExpDate,4,6)
		var/ExpDateNum=text2num(Converted)
		if(ExpDateNum-CurrentDate>0)
			src.Subscriber=1
			src.GiveMedal(new/obj/Medals/Subscriber)
			src.verbs+=typesof(/mob/Subscriber/verb)
			if(src.client.IsByondMember())	src.GiveMedal(new/obj/Medals/SubMember)
			src.TrackStat("Days Subscribed",time2text(world.timeofday,"YYYYMMMDD"),"List")

mob/proc/SubExpirationCheck(/**/)
	var/KeyLocation=SubList.Find(src.key,1,0)
	if(KeyLocation)
		var/ExpDate=SubList[KeyLocation+1]
		var/Converted=copytext(ExpDate,7,9)+copytext(ExpDate,1,3)+copytext(ExpDate,4,6)
		var/ExpDateNum=text2num(Converted)
		var/CurrentDate=text2num(time2text(world.timeofday,"YYMMDD"))
		if(ExpDateNum-CurrentDate<=0)
			src.FontColor=initial(src.FontColor);src.FontFace=initial(src.FontFace)

mob/proc/SubInfo(/**/)
	src<<""
	var/CurrentDate=text2num(time2text(world.timeofday,"YYMMDD"))
	var/KeyLocation=SubList.Find(src.key,1,0)
	if(KeyLocation)
		var/ExpDate=SubList[KeyLocation+1]
		var/Converted=copytext(ExpDate,7,9)+copytext(ExpDate,1,3)+copytext(ExpDate,4,6)
		var/ExpDateNum=text2num(Converted)
		if(ExpDateNum-CurrentDate>0)
			src<<"You are Subscribed to Stray Games"
			src<<"Your Subscription Expires on: [ExpDate]"
			src<<"Current Date: [time2text(world.timeofday,"MM-DD-YY")]"
		else
			src.ResetSubBonuses()
			src<<"Your Subscription to Stray Games Expired on [ExpDate]"
			src<<"Current Date: [time2text(world.timeofday,"MM-DD-YY")]"
			src<<{"<a href="http://www.angelfire.com/hero/straygames/SubscriberInfo.html">Click here to Renew your Subscription!</a>"}
	else
		src<<"<b><font color=red>You are not Subscribed to Stray Games..."
		src<<"<b><font color=gray>Subscribe today for special in-game rewards!"
		src<<{"<b><a href="http://www.angelfire.com/hero/straygames/SubscriberInfo.html">Click here for more info</a>"}
	src<<""


mob/verb/View_Subscribers()
	set hidden=1
	var/text="<center><body bgcolor=gray><table bgcolor=gray border=1 bordercolor=black>"
	text+="<tr><td colspan=2><center><b>Subscriber List</b><br>[SubList.len/2] Total Subscribers"
	text+="<tr><td>Current Date<td>[time2text(world.timeofday,"MM-DD-YY")]"
	text+="<tr><td><b>Key<td><center><b>Expires<tr>"
	var/KeyLink="";var/OnName=0
	for(var/t in SubList)
		OnName=!OnName
		if(OnName)	KeyLink="[t]"
		else	text+="<td>[KeyLink]	<td>[t]<tr>"
	usr<<browse("[text]","window=ViewSubscribers")