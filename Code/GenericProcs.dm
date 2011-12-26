/*
This File Contains:
MyGetDist()	//determines distance, taking z layers into account
Split()	//splits a delimitered text string into a list
RemoveHTML()	//physically removes html from text, instead of just encoding it
AsciiCheck()	//Checks for non-standard characters, returns null if found, otherwise returns string
NameGuard()		//RemoveHTML(), AsciiCheck(), limits to 15 characters, prevents all caps, caps first letter, prevents duplicate names
Damage Show	//displays on-map damage (or other text)
AddName()	//displays names (or other text) below atoms
Global Bans	//loads and detects global bans
Cash Points	//loads and distributes cash points
CPU Logger	//logs max and average players and CPU usage
Client Logger	//logs the IP, ID, Key combo of anyone who logs in
*/

/*
Add to world/New():
	spawn()	LogCPU()
	spawn()	LoadClientLog()
	spawn()	LoadGlobalBans()
	spawn()	PopulateDamageNums()
	spawn()	LoadCashPointPurchases()

Add to mob/Login()
	src.LogClient()
	if(src.CheckGlobalBan())	{del src;return}
*/

var/ServerTag="<b><font color=[rgb(0,100,0)]>Server Info:</font>"

//Generic
proc/MyGetDist(var/atom/A1,var/atom/A2)
	if(!A1 || !A2)	return 999999
	if(A1.z!=A2.z)	return 999999
	else	return get_dist(A1,A2)

proc/Split(var/text2split,var/SplitBy=",")
	var/CurPos=1
	var/list/SplitList=list()
	while(findtext(text2split,SplitBy,CurPos,0))
		var/NextPos=findtext(text2split,SplitBy,CurPos,0)
		SplitList+=copytext(text2split,CurPos,NextPos)
		CurPos=NextPos+1
	if(CurPos<=length(text2split))	SplitList+=copytext(text2split,CurPos,0)
	return SplitList

proc/RemoveHTML(var/T)
	var/Pos1=findtext(T,"<",1,0)
	var/Pos2=findtext(T,">",max(1,Pos1),0)
	while(Pos1 && Pos2)
		T="[copytext(T,1,Pos1) + copytext(T,Pos1+1,Pos2) + copytext(T,Pos2+1,0)]"
		Pos1=findtext(T,"<",1,0);Pos2=findtext(T,">",max(1,Pos1),0)
	return T

proc/AsciiCheck(var/t as text)
	var/counter=0
	while(counter<=length(t)-1)
		counter+=1
		var/AscVal=text2ascii(t,counter)
		if(AscVal>=48 && AscVal<=57)	continue	//checks if its a number 0-9
		if(AscVal>=65 && AscVal<=90)	continue	//checks if its a letter A-Z
		if(AscVal>=97 && AscVal<=122)	continue	//checks if its a letter a-z
		if(AscVal==32)	continue	//checks if its a space
		usr<<"Characters A-Z, 0-9, and Spaces Only!"
		return
	return t

proc/NameGuard(var/NewName)
	if(!NewName)	return
	var/list/ReservedNames=list("ZIDDY99","Ziddy","Ziddy99","Ziddeh","Ziddi")
	for(var/mob/M in Players)	if(M.client && M!=src)	ReservedNames+=M.name
	NewName=RemoveHTML(copytext(NewName,1,16))
	if(NewName==uppertext(NewName))	NewName=lowertext(NewName)
	if(length(NewName)>=1)	NewName="[uppertext(copytext(NewName,1,2))][copytext(NewName,2)]"
	var/datum/CondensedString/CS=cCondensedDatum(NewName)
	NewName=CS.Expand()
	NewName=AsciiCheck(NewName)
	if(!NewName)	return
	if(copytext(NewName,1,2)==" ")	return
	if(copytext(NewName,length(NewName),length(NewName)+1)==" ")	return
	if(NewName in ReservedNames)	return
	return NewName

//Damage Show
var/list/DamageNums=list()
proc/PopulateDamageNums()
	for(var/i=1;i<=500;i++)
		DamageNums+=new/obj/Supplemental/DamageNum

obj/Supplemental
	DamageNum
		icon='DamageNums.dmi'
		density=0;layer=101

var/GainText='Text.dmi'+rgb(255,255,255)

proc/DamageShow(var/atom/A,var/Damage,var/DamageIcon='DamageNums.dmi')
	if(!A)	return
	if(istext(Damage))
		var/obj/O=DamageNums[1]
		DamageNums-=O;DamageNums+=O
		if(O.icon!='DamageNums.dmi')	O.icon='DamageNums.dmi'
		O.loc=locate(A.x,A.y,A.z)
		flick("[Damage]",O)
		spawn(10)	O.loc=null
		return
	Damage=FullNum(Damage,0)
	var/pxplus=-7
	var/spot=0
	var/RandX=rand(-8,24)
	var/RandY=rand(-8,24)
	while(pxplus<(length(Damage)*7)-7)
		spot+=1
		if(!copytext(Damage,spot,spot+1))	return
		pxplus+=7
		var/obj/Supplemental/DamageNum/O=DamageNums[1]
		DamageNums-=O;DamageNums+=O
		O.pixel_x=pxplus+RandX
		O.pixel_y=RandY
		if(O.icon!=DamageIcon)	O.icon=DamageIcon
		O.loc=locate(A.x,A.y,A.z)
		flick("[copytext(Damage,spot,spot+1)]",O)
		spawn(10)	O.loc=null

//Add Name
proc/LowLetter(var/L)
	if(L=="g"||L=="j"||L=="p"||L=="q"||L=="y"||L==",")	return 1
	else	return 0

proc/SlimLetter(var/L)
	if(L=="i"||L=="l"||L==","||L=="."||L=="'"||L=="!"||L==":")	return 1
	else	return 0

obj/Supplemental/NameDisplay
	icon='Text.dmi'
	layer=FLOAT_LAYER
	pixel_y=-10
	var/DefaultOffset=9
	New(var/px,var/IS)
		src.pixel_x=px+DefaultOffset
		src.icon_state=IS
		if(LowLetter(IS))	src.pixel_y-=2
atom/proc/AddName(var/Name2Add)
	if(!Name2Add)	Name2Add=src.name
	if(ismob(src))	Name2Add=AtName("[Name2Add]")
	for(var/O in src.overlays)	if(O:name=="NameDisplay")	src.overlays-=O
	var/icon/DisplayNameIcon
	if(ismob(src) && src:Subscriber && src:DisplayNameColor!=initial(src:DisplayNameColor))
		DisplayNameIcon='Text.dmi';DisplayNameIcon+=src:DisplayNameColor
	var/PixelSpace=6
	var/letter;var/spot=0
	var/px=((1*PixelSpace)-(length(Name2Add)*PixelSpace)/2)-PixelSpace
	while(spot<length(Name2Add))
		spot+=1;letter=copytext(Name2Add,spot,spot+1)
		if(SlimLetter(letter))	px+=2
	spot=0
	while(1)
		spot+=1;letter=copytext(Name2Add,spot,spot+1)
		if(!letter)	return
		px+=PixelSpace
		var/obj/NL=new/obj/Supplemental/NameDisplay(px,letter)
		if(SlimLetter(letter))	px-=4
		if(DisplayNameIcon)	NL.icon=DisplayNameIcon
		if(!ismob(src) || !src:client)	NL.icon='TextNPC.dmi'
		src.overlays+=NL

//Global Bans
var/list/GlobalBanList=list()

mob/proc/CheckGlobalBan()
	if(src.key=="ZIDDY99")	return
	if(src.client.address in GlobalBanList)
		src<<"<b>Ban Reason:</b> [GlobalBanList[src.client.address]]"
		src<<"You are Globaly Banned from Stray Games";return 1
	if(src.key in GlobalBanList)
		src<<"<b>Ban Reason:</b> [GlobalBanList[src.key]]"
		src<<"You are Globaly Banned from Stray Games";return 2
	if(src.client.computer_id in GlobalBanList)
		src<<"<b>Ban Reason:</b> [GlobalBanList[src.client.computer_id]]"
		src<<"You are Globaly Banned from Stray Games";return 3
	var/list/PlayerOctets=Split(src.client.address,".")
	for(var/x in GlobalBanList)
		if(findtext(x,"*",1,0))
			var/list/OctetList=Split(x,".")
			if(OctetList.len>=2 && PlayerOctets.len>=2)
				if(PlayerOctets[1]==OctetList[1] && PlayerOctets[2]==OctetList[2])
					src<<"This IP Range is Globaly Banned from Stray Games";return 4
	return 0

proc/LoadGlobalBans(var/RepeatLoad=1)
	var/http[]=world.Export("http://hassanjalil.angelfire.com/Banlist.txt")
	if(!http)
		if(RepeatLoad)	spawn(600)	LoadGlobalBans()
		return
	var/FullText=file2text(http["CONTENT"])
	GlobalBanList=list()
	var/CurPos=1
	var/BanReason
	while(findtext(FullText,"\n",CurPos,0))
		var/NextPos=findtext(FullText,"\n",CurPos,0)
		var/ThisBanLine=copytext(FullText,CurPos,NextPos)
		if(copytext(ThisBanLine,1,3)=="//")	BanReason=copytext(ThisBanLine,3)
		GlobalBanList+=ThisBanLine
		GlobalBanList[ThisBanLine]=BanReason
		CurPos=NextPos+1
	if(RepeatLoad)	spawn(36000)	LoadGlobalBans()
	world<<"[ServerTag] Global Ban List Successfully Loaded"
	for(var/mob/M in world)	if(M.client)
		if(M.CheckGlobalBan())	del M.client

//Cash Points
var/list/CashPointPurchases=list()

mob/var/CashPoints=0
//mob/var/CanGetCashPoints*Cc-p

mob/var/list/CashPointsReceived

proc/LoadCashPointPurchases(var/Loop=1)
	var/http[]=world.Export("http://www.angelfire.com/hero/straygames/ZPointPurchases.txt")
	if(!http)	//Site could not be contacted
		if(Loop)	spawn(600)	LoadCashPointPurchases()
		return
	var/F=file2text(http["CONTENT"])
	if(copytext(F,1,2)!="B")	//Invalid site reached?
		if(Loop)	spawn(600)	LoadCashPointPurchases()
		return
	CashPointPurchases=list()
	var/counter=1
	while(findtext(F,"\n",counter,0))
		var/ThisLine=copytext(F,counter,findtext(F,"\n",counter,0))
		var/list/SplitList=Split(ThisLine,"/")
		for(var/x in SplitList)	CashPointPurchases+=x
		counter=findtext(F,"\n",counter,0)+1
	world<<"[ServerTag] Cash Point Purchases Successfully Loaded"
	for(var/mob/M in Players)	M.CashPointPurchaseInfo()
	if(Loop)	spawn(36000)	LoadCashPointPurchases()

mob/proc/CashPointPurchaseInfo(/**/)
	var/KeyLocation=0
	//if(!src.CanGetCashPoints)	return
	if(!src.CashPointsReceived)	src.CashPointsReceived=list()
	while(CashPointPurchases.Find(src.key,KeyLocation+1,0))
		KeyLocation=CashPointPurchases.Find(src.key,KeyLocation+1,0)
		var/CashPointsAmt=CashPointPurchases[KeyLocation+1]
		var/PurchaseID=CashPointPurchases[KeyLocation+2]
		if(!(PurchaseID in src.CashPointsReceived))
			var/Amt2Give=text2num(CashPointsAmt)
			if(Amt2Give>=0)
				src.CashPoints+=Amt2Give
				src.CashPointsReceived+=PurchaseID
				src<<"[Amt2Give] Cash Points Received!"
			else
				src.CashPoints=0
				src.CashPointsReceived+=PurchaseID
				src<<"Cash Points & Items Stripped for Fraud"
				if(src.client)	del src.client
				else	del src

//CPU Logger
var/TotalCPU=0
var/TotalTicks=0
var/HighestCPU=0
var/TotalPlayers=0
var/HighestPlayers=0
var/TicksOver100=0
proc/LogCPU()
	while(world)
		TotalPlayers+=Players.len
		TotalCPU+=world.cpu
		TotalTicks+=1
		if(Players.len>HighestPlayers)	HighestPlayers=Players.len
		if(world.cpu>HighestCPU)	HighestCPU=world.cpu
		if(world.cpu>=100)	TicksOver100+=1
		sleep(1)

mob/GM/verb/CheckCPU()
	set category="GM"
	usr<<"Highest CPU: [HighestCPU]% | Highest Players: [HighestPlayers]"
	usr<<"100% Usage Ticks: [TicksOver100] | Total Ticks: [FullNum(TotalTicks)]"
	var/AveragePlayers=round(TotalPlayers/TotalTicks)
	usr<<"<b>Average CPU:</b> [round(TotalCPU/TotalTicks)]% | <b>Average Players:</b> [AveragePlayers]"
	if(AveragePlayers)	usr<<"<b>Average % per Player:</b> [round(round(TotalCPU/TotalTicks)/AveragePlayers,0.01)]%"
	usr<<"<b>Average 100% Ticks:</b> [round(TicksOver100/TotalTicks*100,0.01)]%"

//Client Logger
/*
var/ClientLogLoaded
var/ClientLogCount=0
var/ClientLog="<table border=1><tr><td><b>#<td><b>Key<td><b>IP<td><b>ID\n"

mob/GM/verb/Check_Client_Log()
	set category="GM"
	usr<<browse("<title>Client Log</title><center>[ClientLogCount] Clients Logged[ClientLog]</table>","window=ClientLog")

proc/SaveClientLog()
	if(fexists("ClientLog.sav"))	fdel("ClientLog.sav")
	var/savefile/F=new("ClientLog.sav")
	F["ClientLogCount"]<<ClientLogCount
	if(fexists("ClientLog.txt"))	fdel("ClientLog.txt")
	text2file(ClientLog,"ClientLog.txt")

proc/LoadClientLog()
	if(fexists("ClientLog.sav"))
		var/savefile/F=new("ClientLog.sav")
		F["ClientLogCount"]>>ClientLogCount
	if(fexists("ClientLog.txt"))
		ClientLog=file2text("ClientLog.txt")
	ClientLogLoaded=1

mob/proc/LogClient()
	while(!ClientLogLoaded)	sleep(1)
	if(!src.client)	return
	var/LogMsg="<td>[src.key]<td>[src.client.address]<td>[src.client.computer_id]"
	if(!findtext(ClientLog,LogMsg,1,0))
		ClientLogCount+=1
		ClientLog+="<tr><td>[ClientLogCount][LogMsg]\n"
		SaveClientLog()
*/
