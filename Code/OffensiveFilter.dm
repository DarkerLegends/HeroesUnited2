var/list/OffensiveWords=list()
proc/LoadOffensiveWords(var/Loop=1)
	var/http[]=world.Export("http://www.angelfire.com/hero/straygames/OffensiveWords.txt")
	if(!http)	//Site could not be contacted
		if(Loop)	spawn(600)	LoadOffensiveWords()
		return
	var/F=file2text(http["CONTENT"])
	if(copytext(F,1,2)!="B")	//Invalid site reached?
		if(Loop)	spawn(600)	LoadOffensiveWords()
		return
	OffensiveWords=params2list(file2text(http["CONTENT"]))
	OffensiveWords=SortTextByLen(OffensiveWords)
	world<<"[ServerTag] Offensive Word List Successfully Loaded"
	for(var/mob/M in Players)	M.LastSays=list()
	if(Loop)	spawn(36000)	LoadOffensiveWords()

proc/SortTextByLen(var/list/L)
	var/list/SortedL=list()
	while(L.len>=1)
		var/CurWord=L[1]
		for(var/v in L)
			if(length(v)>length(CurWord))	CurWord=v
		L-=CurWord;SortedL+=CurWord
	return SortedL

mob/GM/verb/Refresh_Offensive()
	set category="GM"
	LoadOffensiveWords(0)

proc/FilterMessage(var/t)
	t=" [t] "
	LOOP;for(var/v in OffensiveWords)	if(findtext(t,v))	{t=ReplaceOffensive(t,v);goto LOOP}
	return copytext(t,2,length(t))

datum/CondensedString
	var/PreLen
	var/String=""
	var/CondensedString=""
	var/list/SpecialChars=list()
	proc/Condense()
		if(!src.CondensedString)	src.CondensedString=src.String
		for(var/i=src.SpecialChars.len;i>=1;i--)
			src.CondensedString=copytext(src.CondensedString,1,text2num(src.SpecialChars[i]))+copytext(src.CondensedString,text2num(src.SpecialChars[i])+1)
		return src.CondensedString
	proc/Expand()
		if(!src.CondensedString)	{src.CondensedString=src.String;return src.CondensedString}
		for(var/v in src.SpecialChars)
			var/Position=text2num(v)
			var/ReplaceLetter=ascii2text(src.SpecialChars[v])
			if(copytext(src.CondensedString,max(1,Position-1),Position)=="©" && copytext(src.CondensedString,Position,Position+1)=="©")	ReplaceLetter="©"
			src.CondensedString=copytext(src.CondensedString,1,Position)+ReplaceLetter+copytext(src.CondensedString,Position)
		return src.CondensedString

proc/cCondensedDatum(var/t,var/preLen)
	var/datum/CondensedString/CS=new
	CS.String=t;CS.PreLen=preLen
	var/counter=0
	var/LastAscii
	while(counter<=length(t)-1)
		counter+=1
		var/AscVal=text2ascii(t,counter)
		if(LastAscii!=AscVal)
			LastAscii=AscVal
			if(AscVal>=65 && AscVal<=90)	continue//checks if its a letter A-Z
			if(AscVal>=97 && AscVal<=122)	continue//checks if its a letter a-z
		LastAscii=AscVal
		CS.SpecialChars+="[counter]"
		CS.SpecialChars["[counter]"]=AscVal
	CS.String=FilterMessage(CS.String)
	CS.Condense();CS.CondensedString=FilterMessage(CS.CondensedString)
	return CS

proc/CondenseString(var/t)	//Cuts out all non-standard characters
	var/counter=0
	var/LastAscii
	while(counter<=length(t)-1)
		counter+=1
		var/AscVal=text2ascii(t,counter)
		if(LastAscii!=AscVal)
			LastAscii=AscVal
			if(AscVal>=65 && AscVal<=90)	continue//checks if its a letter A-Z
			if(AscVal>=97 && AscVal<=122)	continue//checks if its a letter a-z
		LastAscii=AscVal
		t=copytext(t,1,counter)+copytext(t,counter+1)
		counter-=1
	return t

proc/ReplaceOffensive(var/FullString,var/Find)
	var/NewString=""
	var/Found=findtext(FullString,Find)
	var/Replace="";for(var/i=1;i<=length(Find);i++)	Replace+="©"//pick(list("@","#","$","%","&","©"))
	if(Found)
		NewString+=copytext(FullString,1,Found)
		NewString+=Replace
		NewString+=copytext(FullString,Found+length(Find))
		Found=findtext(FullString,Find,Found+1)
		return	NewString
	else	return FullString


proc/RepeatSpam(var/t)
	var/counter=0
	var/Repeats=0
	var/LastLetter
	while(counter<=length(t)-1)
		counter+=1
		var/AscVal=text2ascii(t,counter)
		if(LastLetter!=AscVal)
			Repeats=0;LastLetter=AscVal
		else	{Repeats+=1;if(Repeats>=7)	return 1}
	return 0

mob/var/tmp/LastSay
mob/var/tmp/Spamming
mob/var/tmp/MsgCount=0
mob/var/tmp/list/LastSays=list()
mob/proc/SpamGuard(var/t)
	t=copytext(t,1,250)
	t=TrimSpaces(t)
	if(t==uppertext(t))	t=lowertext(t)
	if(t==src.LastSay)	{src<<"No need to repeat yourself...";return}
	//if(length(t)>=3 && length(src.LastSay)>=3)
	//	if(findtext(t,src.LastSay))	{src<<"It seems like you just said this...";return}
	//	if(findtext(src.LastSay,t))	{src<<"Seems like you just said this...";return}
	src.LastSay=t
	if(src.Spamming)	{src<<"You Must Wait Before Sending Another Message";return}
	if(RepeatSpam(t))	{src<<"Message Filtered as Spam: Repeating Letters!";return}
	var/StringChain="";for(var/v in src.LastSays)	StringChain+=v
	var/datum/CondensedString/CS=cCondensedDatum(StringChain+t,length(StringChain)+1)
	src.MsgCount+=1
	if(src.MsgCount>=10)
		src.MsgCount=0;src.Spamming=1;spawn(6000)	if(src)	src.Spamming=0
		src<<"You have Exceeded your Message Limit, You Must Wait Before Sending Another Message";return
	spawn(200)	if(src)	src.MsgCount-=1
	src.LastSays+=t
	if(src.LastSays.len>10)	src.LastSays=src.LastSays.Copy(2,0)
	var/ReturnValue=html_encode(copytext(CS.Expand(),CS.PreLen))
	text2file("[time2text(world.timeofday,"hhmmss")]:[src]([src.client.computer_id])[ReturnValue]","ChatLogs/[time2text(world.timeofday,"YYYYMMMDD")].txt")
	return ReturnValue