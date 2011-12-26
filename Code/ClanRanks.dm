mob/var/datum/ClanRank/EditClanRank

datum/ClanRank
	var/name="UnNamed Rank"
	var/Level=1
	var/list/Powers=list()
	New(var/ThisRank)
		if(ThisRank=="Leader")
			src.Level=100
			src.name=ThisRank
			src.Powers+=AllClanRankPowers
		else	if(ThisRank)
			src.Level=0
			src.name=ThisRank
		return ..()

var/list/AllClanRankPowers=list("Invite","Kick","Promote","Demote","Create Ranks","Edit Ranks","Buy Upgrades","Rename Clan","Edit Emblem","Change Color","Management","Clear Log")
mob/proc/UpdateClanRankWindow()
	winset(src,"ClanRankWindow","title=\"Clan Rank - [src.EditClanRank.name]\"")
	winset(src,"ClanRankWindow.TitleLabel","text=\" Level [src.EditClanRank.Level] Rank: [src.EditClanRank.name]\n Select the Powers for this Rank:\"")
	var/ButtonNames=""
	for(var/v in AllClanRankPowers)
		if(v in src.EditClanRank.Powers)	ButtonNames+="ClanRankWindow.[ckeyEx(v)]Button.is-checked=true;"
		else	ButtonNames+="ClanRankWindow.[ckeyEx(v)]Button.is-checked=false;"
	winset(src,null,ButtonNames)

mob/proc/SetClanRank(var/RankName)
	src.ClanRank=null
	if(src.Clan)	for(var/datum/ClanRank/C in src.Clan.Ranks)	if(C.name==RankName)	{src.ClanRank=C;break}
	if(!src.ClanRank)	src.ClanRank=new/datum/ClanRank(RankName)
	src.ResetSuffix();src.LeftClan();src.JoinedClan()

mob/proc/HasClanRankPower(var/Power)
	if(src.Clan && (Power in src.ClanRank.Powers))	return 1

mob/verb/OpenClanRanks()
	set hidden=1
	var/HTML="<body bgcolor=[rgb(0,0,64)]><center><table bgcolor=[rgb(255,128,0)] border=1 width=100%>"
	HTML+="<tr><td colspan=100%><center><b><u>Ranks</u> <a href='?src=\ref[src];action=CreateRank;clan=\ref[src.Clan]'>\[Create New Rank\]</a>"
	for(var/datum/ClanRank/C in src.Clan.Ranks)
		HTML+="<tr><td><b>[C.name]<td><a href='?src=\ref[src];action=EditRank;Rank=\ref[C];clan=\ref[src.Clan]'>Edit Rank</a><td><a href='?src=\ref[src];action=DeleteRank;Rank=\ref[C];clan=\ref[src.Clan]'>Delete Rank</a>"
		HTML+="<tr><td colspan=100%>Level [C.Level] Rank : "
		if(!C.Powers.len)	HTML+="No Powers"
		else	for(var/v in C.Powers)	HTML+="[v], "
	src<<browse(HTML,"window=ClanRankListWindow.ClanRankBrowser")
	winset(src,"ClanRankListWindow","is-visible=true;pos=100,100;size=400x400;focus=true")

mob/verb
	RenameClanRank()
		set hidden=1
		var/datum/Clan/ThisClan=src.Clan
		var/datum/ClanRank/ThisRank=src.EditClanRank
		var/PreName=src.EditClanRank.name
		src.EditClanRank.name=html_encode(copytext(input("Input New Clan Rank Name:","Rename Clan Rank",src.EditClanRank.name) as text,1,25))
		if(src.Clan!=ThisClan || src.EditClanRank!=ThisRank)	return
		if(src.EditClanRank.name=="Leader")	src.EditClanRank.name="UnNamed Rank"
		for(var/datum/ClanRank/C in src.Clan.Ranks-src.EditClanRank)	if(C.name==src.EditClanRank.name)	src.EditClanRank.name="[src.EditClanRank.name](1)"
		for(var/v in src.Clan.Members)	if(src.Clan.Members[v]==PreName)	src.Clan.Members[v]=src.EditClanRank.name
		src.UpdateClanRankWindow()
	ChangeClanRankLevel()
		set hidden=1
		src.EditClanRank.Level=input("Input a Rank Level : 1 to 99","Rank Level",src.EditClanRank.Level) as num
		src.EditClanRank.Level=min(src.ClanRank.Level-1,min(99,max(1,round(src.EditClanRank.Level))))
		src.UpdateClanRankWindow()
	ToggleRankAccess(var/Power2Toggle as null|text)
		set hidden=1
		if(Power2Toggle in src.ClanRank.Powers)
			if(Power2Toggle in src.EditClanRank.Powers)	src.EditClanRank.Powers-=Power2Toggle
			else	src.EditClanRank.Powers+=Power2Toggle
		else
			alert("Cannot Modify Powers You Don't Have","Nope")
			src.UpdateClanRankWindow()
