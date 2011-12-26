var/list/GlobalDBs=list()
mob/var/list/DragonBalls=list()
mob/var/list/DBMMMsCollected=list()

proc/RandomLoc(var/Z)
	var/ViewSet=world.view*2
	return locate(rand(ViewSet,world.maxx-ViewSet),rand(ViewSet,world.maxy-ViewSet),Z)

proc/PopulateDragonBalls()
	for(var/i=1;i<=7;i++)
		var/obj/Items/DragonBalls/D=new(RandomLoc(1))
		D.icon_state="DB[i]";D.name="[i] Star DragonBall"
		D.MMM=new(D.icon_state);global.DBMMMs+=D.MMM
		D.MMM.CalculateScreenLoc(D)

obj/Items/DragonBalls
	icon='DragonBalls.dmi'
	var/obj/HUD/MiniMapMarkers/DB/MMM
	New()
		GlobalDBs+=src
		return ..()
	Collect(var/mob/M)
		if(!M.client)	return
		if(src.icon_state in M.DragonBalls)	{M<<"You already have the [src.name]";return}
		M<<"You've Collected [M.DragonBalls.len+1] DragonBalls"
		PlaySound(M,'Rupee.ogg',VolChannel="Menu")
		M.DragonBalls+=src.icon_state
		M.DBMMMsCollected+=src.MMM
		M.client.screen-=src.MMM
		src.loc=RandomLoc(src.z)
		src.MMM.CalculateScreenLoc(src)
		if(M.DragonBalls.len>=7)	M.ShowWishWindow()

var/obj/HUD/Wish/WishHUD=new()
obj/HUD
	Wish
		icon_state="Wish"
		screen_loc="10,1"
		name="DragonBall Wishes"
		desc="Collect 7 DragonBalls and Wish!"
		MouseEntered()
			src.desc="[initial(src.desc)]\nYou've Collected [usr.DragonBalls.len] DragonBalls..."
			return ..()
		Click()	usr.ShowWishWindow()

mob/proc/ShowWishWindow()
	if(src.DragonBalls.len>=7)
		winset(src,"WishWindow.TextLabel","text=\"You who have gathered the seven DragonBalls.\nI shall grant you any one Wish.\"")
		for(var/i=1;i<=7;i++)	winset(src,"WishWindow.Btn[i]","is-disabled=false")
		if(src.Level<999999)	winset(src,"WishWindow.Btn7","is-disabled=true")
		if(!src.Clan)	winset(src,"WishWindow.Btn6","is-disabled=true")
	else
		winset(src,"WishWindow.TextLabel","text=\"You have Collected [usr.DragonBalls.len] DragonBalls...\"")
		for(var/i=1;i<=7;i++)	winset(src,"WishWindow.Btn[i]","is-disabled=true")
	winset(src,"WishWindow","size=432x432;pos=100,100;is-visible=true")

mob/var/WishesMade=0
mob/var/LastWishDate
mob/verb/Wish(var/WishFor as null|text)
	set hidden=1
	if(src.LastWishDate!=time2text(world.timeofday,"YYYYMMDD"))	src.WishesMade=0
	var/WishesAvailable=1;if(src.Subscriber)	WishesAvailable+=1
	if(src.WishesMade>=WishesAvailable)	{src<<"Already Made [WishesAvailable] Wishes Today...";return}
	if(src.DragonBalls.len<7)	{src<<"You need [7-src.DragonBalls.len] more DragonBalls...";return}
	src.WishesMade+=1
	src.DragonBalls=list()
	src.DBMMMsCollected=list()
	src.UpdateMiniMapDBs()
	src.TrackStat("Wishes",1)
	winset(src,"WishWindow","is-visible=false")
	src.GiveMedal(new/obj/Medals/EternalDragon)
	src.LastWishDate=time2text(world.timeofday,"YYYYMMDD")
	var/WishedFor="1,000 Levels"
	var/WishTag="([src.WishesMade]/[WishesAvailable] Wishes Today)"
	switch(WishFor)
		if("Levels")
			WishedFor="1,000 Levels";src.AddExp(1000*100,"Wish Granted");src.TrackStat("Level Wishes",1)
		if("Zenie")
			WishedFor="10,000 Zenie";src.AddZenie(10000);src.TrackStat("Zenie Wishes",1)
		if("Perks")
			WishedFor="a Perk Respec";src.RespecPerks();src.TrackStat("Perk Wishes",1)
		if("Stats")
			WishedFor="a Stat Respec";src.RespecStats();src.TrackStat("Stat Wishes",1)
		if("Respec")
			WishedFor="a Full Respec";src.RespecStats();src.RespecPerks();src.TrackStat("Respec Wishes",1)
		if("ClanExp")
			if(!src.Clan)	return
			WishedFor="1,000 Clan Exp";src.Clan.AddClanExp(1000,src);src.TrackStat("Clan Exp Wishes",1)
		if("Rebirth")
			if(src.Level!=999999)	return
			WishedFor="a Character Rebirth"
			src.GiveMedal(new/obj/Medals/Reborn)
			src.Level=initial(src.Level);src.TrackStat("Character Rebirths",1)
	world<<"<b><i><font color=[rgb(255,128,0)]>[src] was Granted [WishedFor] by the Eternal Dragon [WishTag]"