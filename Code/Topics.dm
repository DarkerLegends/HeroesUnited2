mob/Topic(href,href_list[])
	switch(href_list["action"])
		if("ChatClick")
			switch(input("Select Action:","Player Interaction") as null|anything in list("Add Friend","View Profile","Private Message"))
				if("View Profile")	src.Sense()
				if("Add Friend")	src:Friend()
				if("Private Message")	usr.PM(src)

		if("ViewClan")
			for(var/datum/Clan/G in Clans)	if(G.name==href_list["Clan"])
				var/Text="<title>Clan Roster</title><body bgcolor=black link=[rgb(255,128,0)] alink=[rgb(255,128,0)] vlink=[rgb(255,128,0)]>"
				var/Fmt="<b><font color=[rgb(255,128,0)]>"
				var/MinReqs=""
				for(var/v in G.MinStats)	if(G.MinStats[v])
					if(!MinReqs)	MinReqs="<tr><td colspan=2>[Fmt]Stats Required to Join:<br>"
					MinReqs+="[v]: [G.MinStats[v]]<br>"
				Text+="<center><table border=1 bgcolor=[rgb(0,0,64)] width=100%>"
				Text+="<tr><td colspan=2><center>[Fmt][G.name]<br>[G.Members.len] Members"
				Text+=MinReqs
				Text+="<tr><td><center>[Fmt]Member<td><center>[Fmt]Rank"
				for(var/v in G.Members)
					Text+="<tr><td>[Fmt][v]<td><center>[Fmt][G.Members[v]]"
				src<<browse("[Text]</table>","window=ClanRoster");break
		if("ChangeRank")
			var/datum/Clan/ThisClan=locate(href_list["clan"])
			if(src.Clan && src.Clan==ThisClan && (src.HasClanRankPower("Promote") || src.HasClanRankPower("Demote")))
				var/ThisMemb=href_list["member"]
				if(ThisMemb!=src.key && src.Clan.Members[1]!=ThisMemb)
					var/NewRank=input("Input the New Rank for [ThisMemb]","Set Member Rank",ThisClan.Members[ThisMemb]) as text
					NewRank=html_encode(copytext(NewRank,1,26))
					if(!ThisClan || !NewRank)	return
					if(NewRank=="Leader")	return
					var/datum/ClanRank/NewRankDatum=new()
					var/datum/ClanRank/CurrentRankDatum=new()
					for(var/datum/ClanRank/R in src.Clan.Ranks)	if(R.name==NewRank)	{NewRankDatum=R;break}
					for(var/datum/ClanRank/R in src.Clan.Ranks)	if(R.name==src.Clan.Members[ThisMemb])	{CurrentRankDatum=R;break}
					if(NewRankDatum.Level>=src.ClanRank.Level)	{alert("Cannot Promote Members Past your own Rank!","Fail");return}
					if(NewRankDatum.Level<src.ClanRank.Level)	if(!src.HasClanRankPower("Demote"))	{alert("You don't have Permission to Demote!","Fail");return}
					if(NewRankDatum.Level>CurrentRankDatum.Level)	if(!src.HasClanRankPower("Promote"))	{alert("You don't have Permission to Promote!","Fail");return}
					ThisClan.Members[ThisMemb]=NewRank
					for(var/mob/M in Players)	if(M.key==ThisMemb && M.Clan==ThisClan)
						M<<"Your Rank has been Changed to [NewRank] by [src]"
						M.SetClanRank(NewRank);break
					src.Clan.LogClanLog("[src] Changed [ThisMemb]'s Rank to [NewRank][src.Clan.GetRankLevel(NewRank)]")
					SaveClans();src:Manage_Members()
					alert("[ThisMemb]'s Rank set to [NewRank]","Success!")
				else	alert("You cannot Change the Rank of that Member!","Fail")
			else	alert("Your Clan Rank does not have Access to that Command!","Access Denied")
		if("KickMember")
			var/ThisMemb=href_list["member"]
			var/datum/Clan/ThisClan=locate(href_list["clan"])
			if(alert("Kick [ThisMemb] from [ThisClan]?","Kick Member","Kick","Cancel")=="Cancel")	return
			if(src.Clan && src.Clan==ThisClan && src.HasClanRankPower("Kick"))
				if(ThisMemb!=src.key && src.Clan.Members[1]!=ThisMemb)
					for(var/datum/ClanRank/R in src.Clan.Ranks)	if(R.name==src.Clan.Members[ThisMemb])
						if(R.Level>=src.ClanRank.Level)	{alert("Cannot Kick Members that OutRank You!","Fail");return}
					ThisClan.Members-=ThisMemb
					src.Clan.LogClanLog("[src] Kicked [ThisMemb]")
					for(var/mob/M in Players)	if(M.key==ThisMemb && M.Clan==ThisClan)
						M<<"[src] has Kicked you from the Clan"
						M.Clan.OnlineMembers-=M
						M.Clan=null;M.ClanRank=null
						M.LeftClan();break
					src<<"[ThisMemb] has been Removed from your Clan"
					SaveClans();src:Manage_Members()
				else	alert("You cannot Kick this Member!","Fail")
			else	alert("Your Clan Rank does not have Access to that Command!","Access Denied")

		if("CreateRank")
			var/datum/Clan/ThisClan=locate(href_list["clan"])
			if(src.Clan==ThisClan && src.HasClanRankPower("Create Ranks"))
				src.EditClanRank=new
				for(var/datum/ClanRank/C in src.Clan.Ranks-src.EditClanRank)	if(C.name==src.EditClanRank.name)	src.EditClanRank.name="[src.EditClanRank.name](1)"
				src.Clan.Ranks+=src.EditClanRank
				src.OpenClanRanks()
				src.Clan.LogClanLog("[src] Created a New Rank")
				winset(src,"ClanRankWindow","is-visible=true;pos=100,100;size=512x448")
		if("EditRank")
			var/datum/Clan/ThisClan=locate(href_list["clan"])
			if(src.Clan==ThisClan && src.HasClanRankPower("Edit Ranks"))
				src.EditClanRank=locate(href_list["Rank"])
				if(src.EditClanRank.Level>=src.ClanRank.Level)	{alert("Cannot Edit Higher Level Ranks","WeakSauce");return}
				src.UpdateClanRankWindow()
				winset(src,"ClanRankWindow","is-visible=true;pos=100,100;size=512x448")
				src.Clan.LogClanLog("[src] Edited [src.EditClanRank]: Level [src.EditClanRank.Level] Rank")
		if("DeleteRank")
			var/datum/Clan/ThisClan=locate(href_list["clan"])
			var/datum/ClanRank/ThisRank=locate(href_list["Rank"])
			if(ThisRank.Level>=src.ClanRank.Level)	{alert("Cannot Delete Higher Level Ranks","WeakSauce");return}
			if(alert("Delete the Rank: [ThisRank]?\nAll Clan Members of this Rank will have their Powers Removed","Delete Rank","Delete","Cancel")=="Delete")
				if(ThisClan==src.Clan && src.HasClanRankPower("Create Ranks"))
					for(var/mob/M in src.Clan.OnlineMembers)	if(M.ClanRank==ThisRank)	M.SetClanRank(M.ClanRank.name)
					src.Clan.LogClanLog("[src] Deleted [ThisRank]: Level [ThisRank.Level] Rank")
					src.Clan.Ranks-=ThisRank
					src.OpenClanRanks()
	return ..()