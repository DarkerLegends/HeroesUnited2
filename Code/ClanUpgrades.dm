var/list/AllClanUpgrades=list("Leech"=5,"Fast Track"=5,"Cash Flow"=5,"Clan Boost"=1,"Crafters United"=5)

mob/proc/HasClanUpgrade(var/ThisUpgrade)
	if(src.Clan && src.Clan.HasUpgrade(ThisUpgrade))	return src.Clan.Upgrades[ThisUpgrade]
	else	return 0

mob/verb/RenameClan()
	var/datum/Clan/ThisClan=src.Clan
	if(!src.HasClanRankPower("Rename Clan"))	{alert(src,"Your Clan Rank Cannot Rename the Clan","Access Denied");return}
	if(!ThisClan || ThisClan.Exp<10000)	{alert(src,"More Clan Exp Required!","Insufficient Funds");return}
	var/NewName=ClanNameGuard(input("Input New Clan Name","Rename Clan",ThisClan.name) as text)
	if(!NewName || src.Clan!=ThisClan)	{alert(src,"Invalid Clan Name","Error");return}
	ThisClan.LogClanLog("[src] Renamed the Clan from <i>[ThisClan.name]</i> to <i>[NewName]</i>")
	for(var/mob/CombatNPCs/Enemies/TW_Guard/T in world)	if(T.Team==ThisClan.name)	T.Team=NewName
	for(var/mob/Player/P in Players)	if(P.Team==ThisClan.name)	P.SetTeam(NewName)
	ThisClan.name=NewName;ThisClan.Exp-=10000;src.ClanExpPane()
	for(var/mob/M in Players)	if(M.Clan==ThisClan)	M.AddClanName()

mob/verb/BuyClanUpgrade(var/ThisUpgrade as null|text)
	set hidden=1
	var/MaxLevel=5
	var/UpgradeCost=10000
	if(!src.Clan)	return
	var/datum/Clan/ThisClan=src.Clan
	if(ThisUpgrade=="Clan Boost")	{MaxLevel=1;UpgradeCost=100000}
	if(alert("Buy a [ThisUpgrade] Upgrade for [FullNum(UpgradeCost)]?","Buy Upgrade","Purchase","Cancel")=="Purchase")
		if(!src.HasClanRankPower("Buy Upgrades"))	{alert("Your Rank Doesn't Have Permission to Buy Clan Upgrades!","Access Denied!");return}
		if(src.Clan.Exp<UpgradeCost)	{alert("Your Clan doesn't have enough Exp for that Upgrade!","Too Poor!");return}
		if(src.HasClanUpgrade(ThisUpgrade)>=MaxLevel)	{alert("[ThisUpgrade] is Already at Max Level!","Too Late!");return}
		if(src.Clan!=ThisClan)	return
		if(!(ThisUpgrade in src.Clan.Upgrades))	src.Clan.Upgrades+=ThisUpgrade
		src.Clan.Upgrades[ThisUpgrade]+=1
		src.Clan.ExpSpent+=UpgradeCost
		src.Clan.Exp-=UpgradeCost;src.ClanExpPane()
		spawn(-1)	alert("[ThisUpgrade] Upgraded to Lvl.[src.Clan.Upgrades[ThisUpgrade]]!","Success!")
		src.Clan.LogClanLog("[src] Spent [FullNum(UpgradeCost)] Clan Exp to Upgrade [ThisUpgrade] to Lvl.[src.Clan.Upgrades[ThisUpgrade]]")