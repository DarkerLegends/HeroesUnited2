mob/var/datum/Clan/Clan
mob/var/datum/Clan/ManagingClan
mob/var/list/ClanInviteIgnores=list()
mob/var/datum/ClanRank/ClanRank
var/list/Clans=list()
datum/Clan
	var/name="No-Name"
	var/Exp=0
	var/ExpSpent=0
	var/list/Upgrades=list()
	var/list/ExpEarners=list()
	var/MotD=""
	var/Color="Blue"
	var/ClanLog=""
	var/BankedZenie=0
	var/DefaultRank="Member"
	var/MaxMembers=25
	var/list/Ranks=list()
	var/list/Members=list()
	var/list/LastOnlineMembers=list()
	var/list/MinStats=list("Level"=0,"MaxPL"=0,"MaxKi"=0,"Str"=0,"Def"=0)
	var/tmp/NameColorIcon='TextInt.dmi'
	var/tmp/list/OnlineMembers=list()
	New()
		spawn(1)	src.UpdateNameColorIcon()
		return ..()
	proc/HasUpgrade(var/ThisUpgrade)
		if(ThisUpgrade in src.Upgrades)	return src.Upgrades[ThisUpgrade]
	proc/GetLastOnline(var/Key2Get)
		if(Key2Get in src.LastOnlineMembers)
			var/BaseDate=src.LastOnlineMembers[Key2Get]
			return ReadableLastDate(BaseDate)
		else	return ReadableLastDate()
	proc/LogClanLog(var/Info2Log)
		src.ClanLog+="<tr><td>[time2text(world.timeofday,"hh:mm MMM DD YYYY")]:<b>	[Info2Log]"
	proc/AddClanExp(var/Amt,var/mob/Earner)
		if(Amt<=0)	return
		src.Exp+=Amt
		if(Earner)
			Earner.GiveMedal(new/obj/Medals/ClanContributor)
			if(!(Earner.key in src.ExpEarners))	src.ExpEarners+=Earner.key
			src.ExpEarners[Earner.key]+=Amt
			Earner.TrackStat("Clan Exp Earned",Amt)
			src.LogClanLog("[Earner] Earned [FullNum(Amt)] Clan Exp")
	proc/UpdateNameColorIcon()
		var/icon/I=new(initial(src.NameColorIcon))
		I.Blend(src.Color)
		I.Blend('Text.dmi',ICON_UNDERLAY)
		src.NameColorIcon=I
	proc/GetRankLevel(var/RankName)
		for(var/datum/ClanRank/C in src.Ranks)	if(C.name==RankName)	return "(Rank Level [C.Level])"

proc/ClanNameGuard(var/Name)
	Name=RemoveHTML(Name)
	Name=AsciiCheck(Name)
	Name=html_encode(copytext(Name,1,26))
	if(length(Name)>=1)	Name="[uppertext(copytext(Name,1,2))][copytext(Name,2)]"
	for(var/datum/Clan/G in Clans)	if(G.name==Name)	Name=null
	return Name

mob/verb/ClearClanLog()
	if(src.HasClanRankPower("Clear Log"))
		src.Clan.ClanLog=""
		src.Clan.LogClanLog("[src] Cleared the Clan Log")
		src.ChangedClanTab()
	else
		alert(src,"You don't have Access to Clear the Clan Log","Access Denied")

mob/proc/GetClanTag(/**/)
	if(src.Clan)	return "<font color=[src.Clan.Color]>{[src.Clan]}</font color> "

mob/verb/ChangedClanTab()
	set hidden=1
	src.View_Clans()
	if(src.Clan)
		src.ClanExpPane()
		src:Online_Members()
		src:Manage_Members()
		src:Clan_Management()
		src<<browse("<body bgcolor=[rgb(0,0,64)]><center><table border=1 width=100% bgcolor=[rgb(255,128,0)]>[src.Clan.ClanLog]","window=ClanLogPane.ClanLogBrowser")

mob/proc/ClanExpPane()
	var/HTML="<body bgcolor=[rgb(0,0,64)]><center><table border=1 width=100% bgcolor=[rgb(255,128,0)]>"
	HTML+="<tr><td colspan=2><center><b><u>[FullNum(src.Clan.Exp)] Clan Exp"
	for(var/v in src.Clan.ExpEarners)	HTML+="<tr><td>[v]<td align=right>[FullNum(src.Clan.ExpEarners[v])]"
	src<<browse(HTML,"window=ClanExpPane.ClanExpBrowser")
	var/String=""
	for(var/v in global.AllClanUpgrades)
		var/ThisLevel=0
		var/ThisCost=10000
		if(v=="Clan Boost")	ThisCost=100000
		if(src.Clan.HasUpgrade(v))	ThisLevel=src.Clan.Upgrades[v]
		String+="ClanUpgradesPane.[ckeyEx(v)]Button.text=\"Lvl.[ThisLevel]/[AllClanUpgrades[v]] [v] [FullNum(ThisCost)] Exp\";"
	winset(src,,String)

obj/HUD
	Clan_Management
		icon_state="ClanManage"
		screen_loc="12,1"
		desc="Review Clan Settings, Status, and Members, Invite New Members, Clan Upgrades, and Other Doodles."
		MouseEntered()
			return ..()
			src.desc="[initial(src.desc)]\nWT Status: [global.TournStatus]"
			return ..()
		Click()	usr.UpdateClanWindows()

mob/proc/UpdateClanWindows(/**/)
	src.ChangedClanTab()
	if(src.Clan)	winset(src,"ClanWindow.ClanTabs","tabs='ClanManagementPane,ClanMembersPane,ClanBankPane,ClanListPane,ClanExpPane,ClanLogPane'")
	else	winset(src,"ClanWindow.Clantabs","tabs='ClanListPane,ClanCreatePane'")
	src.OpenedWindow("ClanWindow")
	winset(src,"ClanWindow","pos=100,100;size=640x480;title='Clan {[src.Clan]}';is-visible=true")

proc/SaveClans()
	if(fexists("Clans.sav"))	fdel("Clans.sav")
	var/savefile/F=new("Clans.sav")
	F["Clans"]<<Clans

proc/LoadClans()
	if(fexists("Clans.sav"))
		var/savefile/S=new("Clans.sav")
		S["Clans"]>>Clans

obj/Supplemental/ClanDisplay
	icon='Text.dmi'
	layer=FLOAT_LAYER
	pixel_y=-20
	var/DefaultOffset=9
	New(var/px,var/IS)
		src.pixel_x=px+DefaultOffset
		src.icon_state=IS
		if(LowLetter(IS))	src.pixel_y-=2
mob/proc/AddClanName(/**/)
	spawn()	src.AddTitle()
	for(var/O in src.overlays)	if(O:name=="ClanDisplay")	src.overlays-=O
	if(!src.Clan)	return
	var/Name2Add=src.Clan.name
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
		var/obj/NL=new/obj/Supplemental/ClanDisplay(px,letter)
		NL.icon=src.Clan.NameColorIcon
		if(SlimLetter(letter))	px-=4
		src.overlays+=NL

mob/proc/AssignClan()
	for(var/datum/Clan/G in Clans)	if(src.key in G.Members)
		src.Clan=G;src.SetClanRank(src.Clan.Members[src.key])
		src.JoinedClan();src.GroupMotD();return

mob/proc/LeftClan(/**/)
	src.AddClanName()
	src.ResetSuffix()
	src.ManagingClan=null
	src.ClanInviteIgnores=list()
	src.verbs+=/mob/verb/Create_Clan
	src.verbs-=typesof(/mob/Clan/verb)
	src.verbs-=typesof(/mob/ClanManagement/verb)
	if("ClanWindow" in src.OpenWindows)	src.UpdateClanWindows()

mob/proc/JoinedClan(/**/)
	src.AddClanName()
	src.ResetSuffix()
	src.verbs-=/mob/verb/Create_Clan
	src.verbs+=typesof(/mob/Clan/verb)
	src.GiveMedal(new/obj/Medals/UnitedWeStand)
	if(!(src in src.Clan.OnlineMembers))	src.Clan.OnlineMembers+=src
	if(src.HasClanRankPower("Invite"))	src.verbs+=/mob/ClanManagement/verb/Invite_Members
	if(src.HasClanRankPower("Change Color"))	src.verbs+=/mob/ClanManagement/verb/Set_Color

mob/proc/ClanTag(/**/)
	if(src.Clan)	return "{[src.Clan.name]} "

mob/proc/GroupMotD()
	if(src.Clan && src.Clan.MotD)
		winset(src,"ClanMotDWindow.Title","text=\"[src.Clan] : Clan MotD\"")
		winset(src,"ClanMotDWindow.MotD","text=\"[src.Clan.MotD]\"")
		winset(src,"ClanMotDWindow","pos=100,100;background-color=[src.Clan.Color];is-visible=true")
	else	src<<"No Clan MotD to Display..."

mob/proc/InviteEveryone()
	var/datum/Clan/ThisGroup=src.Clan
	var/list/PossibleInvites=list()
	for(var/mob/M in Players)
		if(!M.Clan && !(ThisGroup.name in M.ClanInviteIgnores)  && !("*Ignore All*" in M.ClanInviteIgnores))
			for(var/v in ThisGroup.MinStats)	if(M.vars[v]<ThisGroup.MinStats[v])	goto CONTINUE
			PossibleInvites+=M;CONTINUE
	var/Counter=0
	for(var/mob/M in PossibleInvites)
		if(!ThisGroup || !M || M.Clan)	continue
		M.ClanInviteIgnores+=ThisGroup.name
		src<<"Clan Invite sent to [M]"
		Counter+=1
		M.PopupHUD(new/obj/HUD/Popups/Clan_Invite(src,ThisGroup),"Clan Invite from [src] to Join [ThisGroup.name]")
	src<<"[Counter] Applicable Members Found and Invited!"

mob/ClanManagement/verb
	Invite_Members()
		set hidden=1
		set category="Clan"
		var/datum/Clan/ThisGroup=src.Clan
		var/list/PossibleInvites=list("* Invite Everyone *")
		for(var/mob/M in Players)
			if(!M.Clan && !(ThisGroup.name in M.ClanInviteIgnores) && !("*Ignore All*" in M.ClanInviteIgnores))
				for(var/v in ThisGroup.MinStats)	if(M.vars[v]<ThisGroup.MinStats[v])	goto CONTINUE
				PossibleInvites+=M
				CONTINUE
		var/mob/M=input("Invite a Player to Join your Clan:","Invite Clan Members") as null|anything in PossibleInvites
		if(!ThisGroup || !M)	return
		if(M=="* Invite Everyone *")	{src.InviteEveryone();return}
		if(M.Clan)	{alert(src,"[M] is Already in a Clan","Error");return}
		M.ClanInviteIgnores+=ThisGroup.name
		M.PopupHUD(new/obj/HUD/Popups/Clan_Invite(src,ThisGroup),"Clan Invite from '[src]' to Join '[ThisGroup.name]'")
		src<<"Clan Invite sent to [M]"
	Set_Color()
		set hidden=1
		var/datum/Clan/ThisClan=src.Clan
		ThisClan.Color=input("Select Clan Color","Clan Color",src.Clan.Color) as color
		src.ApplyClanManagement()
		if(ThisClan)
			ThisClan.UpdateNameColorIcon()
			for(var/mob/M in Players)	if(M.Clan==ThisClan)	M.AddClanName()
			ThisClan.LogClanLog("[usr] Changed Clan Color to <font color=[src.Clan.Color]>[src.Clan.Color]")

mob/proc/ClanInvite(var/mob/Inviter,var/datum/Clan/ThisGroup)
	if(!Inviter || !ThisGroup)	{src<<"Recruiter has Logged Out and/or Clan has Disbanded!";return}
	var/Choice=alert(src,"[Inviter] has Invited you to Join their Clan '[ThisGroup.name]'","Clan Invite","Join","Decline","Ignore")
	if(!ThisGroup || src.Clan)	{Inviter<<"[src] could not join your Clan";return}
	if(Choice=="Join")
		Inviter<<"[src] has Joined your Clan"
		src.Clan=ThisGroup
		src.Clan.Members+=src.key
		src.SetClanRank(src.Clan.DefaultRank)
		src.Clan.Members[src.key]=src.Clan.DefaultRank
		src.UpdateClanWindows()
		src.JoinedClan()
		src.GroupMotD()
		src.Clan.LogClanLog("[Inviter] Succesfully Invited [src]")
		SaveClans()
	else	Inviter<<"[src] has Declined your Clan Invite"
	if(Choice!="Ignore")	src.ClanInviteIgnores-=ThisGroup.name

mob/proc/UpdateClanManagementPage()
	if(!src.Clan)	return
	//winset(src,"ClanManagementPane","background-color=\"[src.Clan.Color]\"")
	winset(src,"ClanManagementPane.LevelInput","text=\"[src.Clan.MinStats["Level"]]\"")
	winset(src,"ClanManagementPane.PowerLevelInput","text=\"[src.Clan.MinStats["MaxPL"]]\"")
	winset(src,"ClanManagementPane.KiEnergyinput","text=\"[src.Clan.MinStats["MaxKi"]]\"")
	winset(src,"ClanManagementPane.StrengthInput","text=\"[src.Clan.MinStats["Str"]]\"")
	winset(src,"ClanManagementPane.DefenseInput","text=\"[src.Clan.MinStats["Def"]]\"")
	winset(src,"ClanManagementPane.MotDInput","text=\"[src.Clan.MotD]\"")
	winset(src,"ClanManagementPane.ColorBtn","text-color=\"[src.Clan.Color]\"")
	winset(src,"ClanManagementPane.DefaultRankInput","text=\"[src.Clan.DefaultRank]\"")

mob/Clan/verb
	Online_Members()
		return ..()
		var/HTML="<body bgcolor=[rgb(0,0,64)]><center><table bgcolor=[rgb(255,128,0)] border=1 width=100%>"
		HTML+="<tr><td><b><u><center>[src.Clan.OnlineMembers.len] Members Online"
		for(var/mob/M in src.Clan.OnlineMembers)	HTML+="<tr><td><b><center>[M]"
		src<<browse(HTML,"window=ClanChatPane.OnlineMembersBrowser")
	Manage_Members()
		set hidden=1
		set background=1
		set category="Clan"
		var/TF="<td><center><b>"
		var/HTML="<body bgcolor=[rgb(0,0,64)]><center><table bgcolor=[rgb(255,128,0)] border=1 width=100%>"
		HTML+="<tr><td colspan=100%><center><b>~ [src.Clan.Members.len] Clan Members ~"
		HTML+="<tr>[TF]<u>Member[TF]<u>Rank<td colspan=2><center><b><u>Options<td><center><b><u>Last Online"
		var/SmallHTML=""
		for(var/v in src.Clan.Members)
			SmallHTML+="<tr>[TF][v][TF][src.Clan.Members[v]][TF]<a href='?src=\ref[src];action=ChangeRank;member=[v];clan=\ref[src.Clan]'>Change Rank</a>[TF]<a href='?src=\ref[src];action=KickMember;member=[v];clan=\ref[src.Clan]'>Kick Member</a>[TF][src.Clan.GetLastOnline(v)]"
			if(length(SmallHTML)>=10000)	{HTML+=SmallHTML;SmallHTML=""}
		src<<browse(HTML+SmallHTML,"window=ClanMembersPane.ClanMembersBrowser")
	Clan_Management()
		set hidden=1
		set category="Clan"
		src.ManagingClan=src.Clan
		src.UpdateClanManagementPage()
		if(!src.HasClanRankPower("Management"))
			winset(src,"ClanManagementPane.ApplyBtn","is-disabled=true")
			winset(src,"ClanManagementPane.ColorBtn","command='SetFocus ClanManagementWindow'")
	View_Clan_MotD()
		set hidden=1
		set category="Clan"
		src.GroupMotD()
	Leave_Clan()
		set hidden=1
		set category="Clan"
		if(alert("Leave your Clan?","Leave Clan","Leave","Cancel")!="Leave")	return
		if(!src.Clan)	return
		if(src.Clan.Members[1]==src.key)
			src<<"Disbanding Clan..."
			for(var/mob/M in Players-src)	if(M.Clan==src.Clan)
				M<<"[src] has Disbanded your Clan"
				M.Clan.Members-=M.key
				M.Clan.OnlineMembers-=M
				M.Clan=null;M.ClanRank=null
				M.LeftClan()
			Clans-=src.Clan
		src.Clan.Members-=src.key
		src.Clan.OnlineMembers-=src
		src.Clan.LogClanLog("[src] Left the Clan")
		src.Clan=null;src.ClanRank=null
		src.LeftClan()
		SaveClans()
	SetCustomRanks()
		set hidden=1
		src<<"You do not have access..."

mob/verb/View_Clans()
	set hidden=1
	set category="Clan"
	var/ClanText="";var/ClansShown=0
	var/Fmt="<b><font>"
	Clans=SortDatumList(Clans,"Members",1)
	for(var/datum/Clan/G in Clans)	if(G.Members.len>=10)
		ClanText+="<tr><td>[Fmt]<a href='?src=\ref[src];action=ViewClan;Clan=[G.name]'>[G.name]</a>"
		ClansShown+=1;ClanText+="<td><center>[Fmt][G.Members[1]]<td><center>[Fmt][G.Members.len] / [G.MaxMembers]"
		ClanText+="<td><center>[Fmt][G.OnlineMembers.len]<td><center>[Fmt][FullNum(G.Exp)]<td><center>[Fmt][FullNum(G.ExpSpent)]"
	var/Text="<title>Clans</title><body bgcolor=[rgb(0,0,64)]>"
	Text+="<center><table border=1 bgcolor=[rgb(255,128,0)] width=100%>"
	Text+="<tr><td colspan=100%><center>[Fmt][ClansShown] of [Clans.len] Clans Displayed"
	Text+="<br>Only Showing Clans with 10+ Members"
	Text+="<tr><td><center>[Fmt]Clan<td><center>[Fmt]Leader<td><center>[Fmt]Members<td><center>[Fmt]Online<td><center>[Fmt]Exp<td><center>[Fmt]Spent"
	Text+="[ClanText]"
	src<<browse("[Text]</table>","window=ClanListPane.ClanListBrowser")

mob/verb/Create_Clan()
	set hidden=1
	set category="Clan"
	if(!src.Subscriber)	{alert("Only Stray Games Subscribers can Create Clans","Subscribers Only");return}
	if(src.Clan)	{alert("You are already in a Clan","Duplicate");return}
	var/datum/Clan/ThisClan=new
	ThisClan.Members+=src.key
	ThisClan.Members[src.key]="Leader"
	ThisClan.name=ClanNameGuard(input("Input the name of your Clan","Input Name","[src]'s Clan") as text)
	if(!ThisClan.name)	{alert("Invalid Clan name...","Error");del ThisClan;return}
	Clans+=ThisClan
	SaveClans()
	src.Clan=ThisClan
	src.SetClanRank("Leader")
	src.UpdateClanWindows()
	src.Clan.LogClanLog("[src] Created [src.Clan]")
	alert("Clan '[src.Clan.name]' has been Assembled!","Success!")

mob/verb
	Toggle_Clans()
		if("*Ignore All*" in src.ClanInviteIgnores)
			src.ClanInviteIgnores-="*Ignore All*"
			src<<"Players can now Invite you to Clans..."
		else
			src.ClanInviteIgnores+="*Ignore All*"
			src<<"You will no longer Receive Clan Invites..."