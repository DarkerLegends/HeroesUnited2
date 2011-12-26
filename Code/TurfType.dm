obj/TurfType
	layer=2
	density=1
	mouse_opacity=0
	var/ApplyDensity=0
	New()
		if(src.layer<=2)	src.layer=2.2
		if(src.ApplyDensity)	src.loc.density=src.density
		return ..()
	FormatPainter
		layer=10
		icon='Other.dmi'
		icon_state="FormatPainter"
		var/list/Vars2Paint
		New()
			src.icon_state=""
			for(var/obj/TurfType/O in src.loc.contents-src)
				for(var/v in src.Vars2Paint)	O.vars[v]=src.vars[v]
			return ..()
	Cliff
		icon='NewCliffs.dmi'
		icon_state="TM1"
		density=1
		New()
			if(src.icon_state=="TM1")	src.icon_state="TM[rand(2,3)]"
			if(src.icon_state=="BM1")	src.icon_state="BM[rand(1,3)]"
			return ..()
	CloudsOverlay
		layer=5
		icon='CloudsOverlay.dmi'
	BuildingLetters
		icon_state="GoldZ"
		icon='BuildingLetters.dmi'
	BuildingToppers
		icon='SquareBuilding.dmi'
		icon_state="RoofGrate"
	CircusSign
		layer=5
		density=0
		pixel_y=16
		icon='CircusSign.png'
	TentEntrance
		icon='TentEnt.png'
	GrassCorners
		density=0
		ApplyDensity=1
		icon='NewTurfs.dmi'
		icon_state="DarkGrassTL"
	DenseGrassFuzz
		density=0
		layer=2.3	//was 2.3?  So that it would appear over cliffs!  Then changed to 2.1?
		icon='NewTurfs.dmi'
		icon_state="GrassFuzzL"
	Dumpster
		icon='CityTurfs.dmi'
		icon_state="DumpsterB"
	Tree
		layer=5
		density=0
		icon='Tree.png'
		New()
			if(src.icon_state=="1,0")	{src.layer=2.1;src.density=1}
			return ..()
	FancyTree16
		layer=5;density=0
		pixel_x=16
		icon='FancyTree.png'
	PalmTree
		layer=5;density=0
		icon='PalmTree.png'
	RockSlide
		icon='RockSlide.png'
	RoundBallTop
		icon='BallTop.png'
	TournamentSign
		layer=5;density=0
		icon_state="SignBL"
		icon='TournamentTurfs.dmi'
	TournEntrance
		layer=5
		icon='TournEntrance.png'
	TournTop
		layer=5;density=0
		icon='TournTop.png'
	GiftShop
		icon='GiftShop.png'
	FoodShop
		icon='FoodShop.png'
	DrinkShop
		icon='DrinkShop.png'
	PuncherFiller
		icon='NPCs.dmi'
		icon_state="PuncherR"
	SnakeWay
		ApplyDensity=1
		icon='SnakeWay.png'
	SnakeWayOverlay
		layer=5;density=0
		icon='SnakeWayOverlay.png'
	SnakeWayHead
		ApplyDensity=1
		icon='SnakeHead.png'
	SnakeWayHeadOver
		layer=5;density=0
		icon='SnakeHeadOver.png'
	YemmaEntranceOver
		layer=5;density=0
		icon='YemmaEntOver.png'
	Submarine
		icon='Submarine.png'
	AirShip
		icon='AirShip.png'
	KingYemma
		layer=5;density=0
		icon='KingYemma.png'
		verb/Revive()
			set category=null
			set src in oview()
			if(usr.JoinMissionCheck())	return
			var/NewLoc=input("Where should I send you this time?","Revival Location") as anything in Locations
			if(!usr)	return
			usr=usr.GetFusionMob()
			if(MyGetDist(usr,src)<=world.view)
				usr.IsDead=0
				usr.Locate(NewLoc)
				usr.overlays-=global.Halo
				usr.CompleteTutorial("Alpha Revival")
	Capsule_Ship
		icon='CapsuleShip.png'
	Saiyan_Space_Pod
		density=0;layer=5
		icon='SaiyanSpacePod.png'
	Kame_House
		icon='NewKameHouse.png'
	CellGamesArena
		density=0
		icon='CellGamesArena.png'
	CellGamesPillarT
		density=0;layer=5
		icon='CellGamesPillarT.png'
	CellGamesPillarB
		density=0;layer=5
		icon='CellGamesPillarB.png'
	KamisLookout
		density=0
		icon='KamisLookout.png'
	KamisLookoutOverlayers
		density=0;layer=5
		icon='KamisLookoutOverlayers.png'
	HBTC
		density=0
		icon='HBTC.png'
	HbtcOverlay
		density=0;layer=5
		icon='HbtcOverlay.png'
	Friezas_Ship
		icon='FriezaShip.png'
