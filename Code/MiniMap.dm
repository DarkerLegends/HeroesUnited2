obj/HUD
	MiniMapMarkers
		layer=11
		var/pixx=15
		var/pixy=15
		mouse_opacity=0
		icon='MiniMapMarkers.dmi'
		New(var/IS)
			if(istext(IS))	src.icon_state=IS
			return ..()
		proc/CalculateScreenLoc(var/atom/A)
			var/X=round(A.x*200/400)
			var/Y=round(A.y*200/400)
			var/FullX=round(X/32)
			var/FullY=round(Y/32)
			var/PixelX=X-(FullX*32)+11-src.pixx
			var/PixelY=Y-(FullY*32)+11-src.pixy
			src.screen_loc="MiniMapMap:[FullX+1]:[PixelX],[FullY+1]:[PixelY]"
		proc/CalculateForcedLoc(var/atom/A,BaseX,BaseY,Width,Height)
			src.screen_loc="17:[round((A.x-BaseX)/2)-Width],1:[round((A.y-BaseY)/2)-Height]"
		Player
			layer=12
			icon_state="Player"
		TW
			icon='RGBMMFlag.dmi'
		FW
		DB
	MiniMapBG
		icon='MiniMapEarth.png'
		DblClick(location,control,params)
			if(!(usr.z in ITZ))	return
			var/list/Params=params2list(params)
			var/list/Locs=Split(src.screen_loc,",")
			Locs+=Split(Locs[1],":")
			var/LocX=(-12+(text2num(Locs[4])-1)*32+text2num(Params["icon-x"]))*2
			var/LocY=(-12+(text2num(Locs[2])-1)*32+text2num(Params["icon-y"]))*2
			var/turf/T=locate(LocX,LocY,usr.z)
			if(T)	T.DblClick()

obj/HUD/ForcedMiniMap/MiniMap
mob/proc/ShowForcedMiniMap(var/width=64,var/height=64,var/ImageFile='FlagWarsMiniMap.png')
	if(!src.client)	return
	src.ClearForcedMiniMap()
	for(var/x=18-round(width/32),x<=17,x++)
		for(var/y=1,y<=round(height/32),y++)
			var/obj/HUD/ForcedMiniMap/MiniMap/M=new
			M.icon=ImageFile;src.client.screen+=M
			M.icon_state="[x-16],[y-1]";M.screen_loc="[x],[y]"

mob/proc/ClearForcedMiniMap()
	if(src.client)	for(var/obj/HUD/ForcedMiniMap/M in src.client.screen)	src.client.screen-=M

mob/var/MiniMapZ
var/list/DBMMMs=list()
var/list/FWMMMs=list()
var/list/TWMMMs=list()
mob/var/obj/HUD/MiniMapMarkers/Player/MMM=new

var/list/ITZ=list(1,2,9)
var/list/MapsWithIT=list("1","2","9","10")
var/list/MapNames=list("1"="Earth","2"="Other World","3"="Inside","4"="Instances #1","5"="Mission Map","6"="Mission Map","7"="Apartments","8"="Concept Pieces","9"="Hyperbolic Time Chamber","10"="Territory War")
mob/var/list/MiniMapBG=list()
mob/proc/GenerateMiniMapBG()
	var/HudY=1
	for(var/HudX=1;HudX<=7;HudX++)
		var/obj/HUD/MiniMapBG/H=new
		H.icon_state="[HudX-1],[HudY-1]";src.MiniMapBG+=H
		H.screen_loc="MiniMapMap:[HudX],[HudY]"
		if(HudX==7 && HudY<7)	{HudX=0;HudY+=1}
mob/proc/LoadMiniMapBG()
	if(!src.client)	return
	if(src.z==src.MiniMapZ)	return
	if(!("[src.z]" in MapNames))	return
	src.MiniMapZ=src.z
	src.UpdateMiniMapDBs()
	for(var/client/C in src.ControlClients)
		C.screen-=src.MiniMapBG
		C.mob.MMM.CalculateScreenLoc(C.mob)
		if(!src.MiniMapBG.len)	src.GenerateMiniMapBG()
		C.screen+=src.MiniMapBG
		winset(src,"MiniMapWindow.PlanetLabel","text=\"[MapNames["[src.z]"]]\"")
		var/icon/I
		switch(src.z)
			if(1)	I='MiniMapEarth.png'
			if(2)	I='MiniMapOtherWorld.png'
			if(9)	I='MiniMapHBTC.png'
			if(10)	I='MineCraftMM.png'
			else	I='MiniMapNone.png'
		for(var/obj/O in src.MiniMapBG)	O.icon=I

mob/proc/UpdateMiniMapDBs()
	if(src.z==1)	src.client.screen+=global.DBMMMs-src.DBMMMsCollected
	else	src.client.screen-=global.DBMMMs

mob/verb/CloseMiniMap()
	set hidden=1
	src.client.screen-=src.MMM
	src.client.screen-=global.DBMMMs
	src.ClosedWindow("MiniMapWindow")

mob/verb/ToggleMiniMap(/**/)
	set hidden=1
	if(winget(src,"MiniMapWindow","is-visible")=="true")
		winset(src,"MiniMapWindow","is-visible=false")
		src.CloseMiniMap()
	else
		winset(src,"MiniMapWindow","pos=314,38;is-visible=true")
		src.CompleteTutorial("MiniMap")
		src.OpenedWindow("MiniMapWindow")
		src.MMM.CalculateScreenLoc(src)
		src.client.screen+=src.MMM
		src.UpdateMiniMapDBs()
		src.LoadMiniMapBG()