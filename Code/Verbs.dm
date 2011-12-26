mob/Player/verb/Friend()
	set src in world
	set category=null
	if(usr==src)	{usr<<"You can't Friend Yourself =(";return}
	if(src.key in usr.Friends)	{usr<<"[src] is Already on your Friend List =D";return}
	usr.Friends+=src.key
	usr.OnlineFriends+=src
	usr<<"<b><font color=green>[src] Added to your Friend List"
	src<<"<b><font color=green>[usr] Added you to their Friend List"
	usr.GiveMedal(new/obj/Medals/Friendly)
mob/Player/verb/IT_To()
	set src in world
	if((usr.InstanceObj && usr.InstanceObj.IsPvpType()) || (usr.InstanceObj && usr.InstanceObj.IsPvpType()))	{usr<<"Disabled in PvP Instances";return}
	if(usr.InstanceObj || src.InstanceObj)	if(usr.InstanceObj!=src.InstanceObj)	{usr<<"[src] is in another Instance";return}
	if(usr.CurrentCP || src.CurrentCP)	if(usr.CurrentCP!=src.CurrentCP)	{usr<<"[src] is in another Mission";return}
	if(src.z!=usr.z)	{usr<<"[src] is in another Zone";return}
	if(!(usr.key in src.Friends))	{usr<<"[src] must Friend You First...";return}
	usr.Fly();src.loc.DblClick()

mob/verb
	Message()
		set src in world
		usr.PM(src)
	Respawn()
		src=src.GetFusionMob()
		if(src.GhostMode==2)
			src.GhostMode=0
			src.AddKiPercent(100)
			src.AddPlPercent(100)
			src.ApplyTransDatum()
			src.ResetIS()
			src.UpdateHUDText("TrainingDesc")
	View_Forums()
		set hidden=1
		src<<link("http://www.byond.com/members/ZIDDY99/forum")
		src.SetFocus("MainWindow.MainMap")
	Lag_Options()
		set hidden=1
		set category="Options"
		winset(usr,"LagOptionsWindow.HideTransBtn","is-checked=[(src.see_invisible ? "false" : "true")]")
		winset(usr,"LagOptionsWindow.MuteSoundsBtn","is-checked=[(src.VolumeMuteAll  ? "true" : "false")]")
		winset(usr,"LagOptionsWindow","size=464x424;pos=100,100;is-visible=true")

	Who()
		set hidden=1
		var/counter=0
		var/AfkCount=0
		var/SubCount=0
		var/MemCount=0
		var/BothCount=0
		var/TotalLevels=0
		var/TotalPlayTime=0
		winset(src,"WhoWindow.WhoGrid","cells=4x[Players.len]")
		//usr<<"<b>Players Online:"
		var/TF="<b><u><center>"
		//usr<<output("[TF]Rank","WhoWindow.WhoTitleGrid:1,1")
		usr<<output("[TF]Player","WhoWindow.WhoTitleGrid:1,1")
		usr<<output("[TF]Tags","WhoWindow.WhoTitleGrid:2,1")
		usr<<output("[TF]Descriptor","WhoWindow.WhoTitleGrid:3,1")
		usr<<output("[TF]Play Time","WhoWindow.WhoTitleGrid:4,1")
		var/list/SortedPlayers=SortDatumList(Players,"Level")
		for(var/mob/M in SortedPlayers)
			counter+=1
			TotalLevels+=M.Level
			TotalPlayTime+=M.PlayTimeHours
			var/PreSubCount=SubCount
			var/SubTag;if(M.Subscriber)	{SubCount+=1;SubTag="\[Sub\]"}
			var/MemTag=""
			if(M.client.IsByondMember())
				if(SubCount!=PreSubCount)	{SubCount-=1;BothCount+=1}
				else	MemCount+=1
				MemTag="\[Mem\]"
			var/AfkTag="";if(M.AFK)	{AfkTag="\[AFK\]";AfkCount+=1}
			var/ClanTag=""
			if(M.Clan)
				ClanTag="<background color=[rgb(255,234,213)]><br><font color=[M.Clan.Color]>[M.Clan]"
				winset(usr,"WhoWindow.WhoGrid","style='body{background-color:[rgb(255,234,213)]}'")
			usr<<output("<center>[M][ClanTag]","WhoWindow.WhoGrid:1,[counter]")
			winset(usr,"WhoWindow.WhoGrid","style='body{background-color:[rgb(0,0,64)]}'")
			usr<<output("<center>[AfkTag][SubTag][MemTag]","WhoWindow.WhoGrid:2,[counter]")
			usr<<output("<center>Level [FullNum(M.Level)]<br>[M.Character.Race]","WhoWindow.WhoGrid:3,[counter]")
			usr<<output("<center>[M.DisplayPlayTime()]","WhoWindow.WhoGrid:4,[counter]")
		usr<<output("<b>Average:","WhoWindow.AverageGrid:1,1")
		usr<<output("<center><b>\[Avg\]","WhoWindow.AverageGrid:2,1")
		usr<<output("<center><b>Level [FullNum(TotalLevels/counter)]","WhoWindow.AverageGrid:3,1")
		usr<<output("<center><b>[FullNum(TotalPlayTime/counter)] Hours","WhoWindow.AverageGrid:4,1")
		//usr<<"<b>[counter] Players Online	[AfkCount] AFK		[counter-SubCount-MemCount-BothCount] Regular Players"
		//usr<<"<b>[SubCount] Subscribers		[MemCount] Members	[BothCount] Sub Members"
		usr<<output("<b>[counter] Total","WhoWindow.PlayerCountGrid:1,1")
		usr<<output("<b>[AfkCount] AFK","WhoWindow.PlayerCountGrid:2,1")
		usr<<output("<b>[round(AfkCount/counter*100)]% AFK","WhoWindow.PlayerCountGrid:3,1")
		usr<<output("<b>[counter-AfkCount] Active","WhoWindow.PlayerCountGrid:4,1")
		usr<<output("<b>[counter-SubCount-MemCount-BothCount] Players","WhoWindow.PlayerCountGrid:1,2")
		usr<<output("<b>[SubCount] Subscribers","WhoWindow.PlayerCountGrid:2,2")
		usr<<output("<b>[MemCount] Members","WhoWindow.PlayerCountGrid:3,2")
		usr<<output("<b>[BothCount] Sub Members","WhoWindow.PlayerCountGrid:4,2")
		winset(src,"WhoWindow","pos=100,100;size=422x422;is-visible=true")

	ClanChat(var/t as text)
		set hidden=1
		src.SendChat(t,src.ChatPane)
	Chat(var/t as text)
		set hidden=1
		src.SendChat(t,src.ChatPane)

	LogoutLink()
		set hidden=1
		if(LogoutLink)	src<<link(LogoutLink)

mob/proc/SendChat(var/t,var/Channel="GlobalChatPane")
	set hidden=1
	t=SpamGuard(t);if(!t)	return
	var/ClanTag;if(src.Clan)	ClanTag="<font color=[src.Clan.Color] size=1>{[src.Clan.name]}</font size>"
	var/SubFont="</b>";if(src.Subscriber)	SubFont="<font color=[src.FontColor] face='[src.FontFace]'>"
	var/FullMsg="<b><font color=[src.NameColor]><a href='?src=\ref[src];action=ChatClick'>\icon[src]</a>[src]:[SubFont] [t]"
	if(Channel=="ChatPaneClan")
		if(src.Clan)
			src.TrackStat("Clan Messages Sent",1)
			ClanTag="<font color=[src.Clan.Color] size=1>{[src.ClanRank]}</font size>"
			src.Clan.OnlineMembers<<output("[ClanTag][FullMsg]","ChatPaneClan.Output")
	else	if(Channel=="ChatPaneGlobal" || Channel=="ChatPaneChat")
		src.TrackStat("Messages Sent",1)
		world<<"[ClanTag][FullMsg]"
		for(var/mob/M in Players)	M<<output("[ClanTag][FullMsg]","ChatPaneChat.Output")
	else	if(Channel=="ChatPaneParty")
		for(var/mob/M in src.Party)	M<<output("<font size=1>{Party x[src.Party.len]}</font size>[FullMsg]","[Channel].Output")
	else	if(Channel=="ChatPaneRP")
		for(var/mob/M in Players)	M<<output("[FullMsg]","[Channel].Output")
	else	for(var/mob/M in Players)	M<<output("[ClanTag][FullMsg]","[Channel].Output")

proc/SortDatumList(var/list/Orig,var/Stat,var/ByListLen=0,var/High2Low=0)
	var/list/L=list();L+=Orig
	var/list/SortedList=list()
	while(L.len)
		var/datum/HighestDatum
		if(!ByListLen)	for(var/datum/D in L)
			if(!High2Low)	if(!HighestDatum || D.vars[Stat]>HighestDatum.vars[Stat])	HighestDatum=D
			else	if(!HighestDatum || D.vars[Stat]<HighestDatum.vars[Stat])	HighestDatum=D
		else
			var/HighestLen
			for(var/datum/D in L)
				var/list/ThisLen=D.vars[Stat];ThisLen=ThisLen.len
				if(!High2Low)	if(!HighestDatum || ThisLen>HighestLen)	{HighestDatum=D;HighestLen=ThisLen}
				else	if(!HighestDatum || ThisLen<HighestLen)	{HighestDatum=D;HighestLen=ThisLen}
		L-=HighestDatum;SortedList+=HighestDatum
	return SortedList