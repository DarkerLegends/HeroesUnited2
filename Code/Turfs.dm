turf/Overflow
	Tree
		density=1
		icon='Tree.png'

turf/DblClick()
	usr=usr.GetFusionMob()
	if(!usr.CanAct())	return ..()
	if(src.Enter(usr))
		usr.CompleteTutorial("Instant Transmission")
		PlaySound(view(),'InstantTransmission.ogg')
		usr.ITing=1;flick("IT",usr)
		sleep(5);if(usr)	usr.ITing=0
		if(usr.FlagCaptured)	return ..()
		if(usr.CounterBeamMob)	return ..()
		if(!usr || !src.Enter(usr) || usr.z!=src.z)	return ..()
		if(!("[src.z]" in MapsWithIT) && MyGetDist(usr,src)>world.view)	return ..()
		if(global.TournStatus=="Face-Off" || global.TournStatus=="Battle")
			if(usr.InTournament)
				if(global.TournStatus=="Face-Off")	return ..()
				if(!(src in GetWTBlock()))	usr.LoseTournRound("Ring Out")
			else	if(src in GetWTBlock())	return ..()
		usr.TrackStat("Instant Transmissions",1)
		usr.loc=src;src.Entered(usr)
		usr.DuelRangeCheck()
		usr.MMM.CalculateScreenLoc(usr)
	return ..()

turf/Entered(var/mob/M)
	if(ismob(M))	M.LoopMap()
	return ..()

turf/Doorway
	layer=5
	var/NewX
	var/NewY
	var/NewZ
	Entered(var/mob/M)
		if(ismob(M))
			spawn(8)
			if(M && M.loc==src)
				if(src.NewZ)	M.loc=locate(src.NewX,src.NewY,src.NewZ)
				else	M<<"This doorway will lead somewhere someday.  <b>But that day is not today!"
				M.DuelRangeCheck()
				M.LoadMiniMapBG()
		return ..()
turf
	Teleport
		Plane_Enter
			Enter(A)
				if(ismob(A))
					var/mob/M = A
					if(M.client)
						M.loc=locate(239,193,2)
				else
					if(istype(A,/obj/)) del(A)
		Plane_Exit
			layer=MOB_LAYER+99999999999999999999999999999999
			Enter(A)
				if(ismob(A))
					var/mob/M = A
					if(M.client)
						M.loc=locate(369,20,2)
				else
					if(istype(A,/obj/)) del(A)
		Mansion_Enter
			Enter(A)
				if(ismob(A))
					var/mob/M = A
					if(M.client)
						M.loc=locate(245,191,10)
				else
					if(istype(A,/obj/)) del(A)
		Mansion_Exit
			Enter(A)
				if(ismob(A))
					var/mob/M = A
					if(M.client)
						M.loc=locate(247,199,2)
				else
					if(istype(A,/obj/)) del(A)
		Mansion_Enter
			Enter(A)
				if(ismob(A))
					var/mob/M = A
					if(M.client)
						M.loc=locate(245,191,10)
				else
					if(istype(A,/obj/)) del(A)


turf
	icon='NewTurfs.dmi'
	var/SuperDensity=0
	Enter(var/atom/A)
		if(src.SuperDensity)	return
		else	return ..()
	Images
		BankInterior
			icon='BankInterior.png'
	Other
		Density
			layer=10
			density=1
		SuperDensity
			layer=10
			density=1;SuperDensity=1
		White
			icon_state="White"
			DblClick()	return
		Blackness
			opacity=1
			density=1;SuperDensity=1
			icon_state="Black"
		HbtcClouds
			name="HBTC"
			icon='HbtcClouds.dmi'
			verb/Gravity()
				set src in oview()
				set category=null
				usr.GravityProc(src)
			verb/Shadow_Spar()
				set src in oview()
				set category=null
				usr.ShadowSparProc(src)
			verb/Sparring_Partner()
				set src in oview()
				set category=null
				usr.SparringPartnerProc(src)
			verb/Focus_Training()
				set src in oview()
				set category=null
				usr.FocusTrainingProc(src)
	Apartment_Interiors
		icon='ApartmentInts.dmi'
		Wall
			density=1
			icon_state="BaseWall"
		Floor
			icon_state="BaseTile"
	OtherWorld
		density=1
		icon='OtherWorld.dmi'
		Clouds
			icon='Clouds.dmi'
		CloudTop
			icon='CloudTop.png'
		UnderTongue
			density=0
			icon='UnderTongue.png'
		YemmaEntranceL
			icon='YemmaEntL.png'
		YemmaEntranceR
			icon='YemmaEntR.png'
		YemmaEntranceDoor
			icon='YemmaEntDoor.png'
		Tile
			icon_state="Tile"
			density=0
		Wall
			icon_state="WallB"
		WallTop
			density=1;SuperDensity=1
			icon_state="WallTopR"
		WallPeg
			density=1;SuperDensity=1
			icon_state="WallPegBR"
		YemmaRoof
			icon_state="YemmaRoof"
	Tournament
		density=1
		icon='TournamentTurfs.dmi'
		BrickWall
			icon_state="BrickWall"
		Fans
			FansL
				icon='FansL.png'
			FansR
				icon='FansR.png'
			FansTL
				icon='FansTL.png'
			FansTR
				icon='FansTR.png'
			FansB
				icon='FansB.png'
	HighwayCliffs
		icon='HighwayCliffs.dmi'
		Dirt
			icon_state="Dirt1"
			New()
				src.icon_state="Dirt[rand(1,4)]"
				return ..()
		Path
			icon_state="Path1"
			New()
				src.icon_state="Path[rand(1,3)]"
				return ..()
		GuardRail
			layer=5
			icon_state="GuardRailB"
		CliffEdge
			icon_state="CliffL"
		Cliff
			density=1
			icon_state="B"
		Density
			density=1
	Buildings
		density=1
		HerculeCityBank
			icon='HerculeCityBank.png'
		Planes
			density=0
			icon='Planes.png'
		GrandKaiMansion
			density=0
			icon='Mansion.png'
		Kaihouse
			density=0
			icon='Kai house.png'
		SquareBuilding
			icon_state="BL"
			icon='SquareBuilding.dmi'
		RectBuilding
			icon_state="BL"
			icon='RectBuilding.dmi'
		RoundBuilding
			icon_state="BL"
			icon='RoundTower.dmi'
		RedHut
			icon_state="7"
			icon='RedHut.dmi'
		PurpleHut
			icon_state="7"
			icon='PurpleHut.dmi'
	City
		icon='CityTurfs.dmi'
		Tile
			icon_state="Tile"
		Stairs
			icon='CityStairs.dmi'
			icon_state="Stairs"
		Road
			icon_state="Road"
		CrossWalk
			icon_state="CrossWalkH"
		Plant
			density=1
			icon_state="PlantM"
		CityWall
			density=1
			icon='CityWall.dmi'
			icon_state="B"
		Bench
			icon_state="BenchL"
		Portal
			icon_state="PortalTL"
	HerculeCity
		HerculeCityWall
			density=1
			icon='HerculeCityWall.dmi'
			icon_state="Wall"
	DbzTurfs
		icon='DbzTurfs.dmi'
		GrayTile
			icon_state="GrayTile"
		WallTop
			density=1;SuperDensity=1
			icon_state="WallTopB"
		FullTop
			opacity=1
			density=1;SuperDensity=1
			icon_state="FullTopV"
		KamisBar
			layer=5
			icon_state="KamisBarB"
	Generic
		Grass
			icon_state="DarkGrass1"
			New()
			/*	while(src)
					var/list/Winter=Season["Winter"]
					var/CurMonth=time2text(world.realtime,"Month")
					if(CurMonth in Winter)
						icon_state=pick("Snow 1","Snow 2")
					else
						src.icon_state="DarkGrass[rand(1,4)]"
					sleep(6000)
*/
				return ..()
		Water
			Phase=0
			density=1
			icon_state="Water"
turf
	Circus
		Circus1
			icon='Circus 1.png'
		Circus2
			icon='Circus 2.png'
		Circus3
			icon='Circus 3.png'
		Circus4
			icon='Circus 4.png'
	City
		City1
			icon='Hercule city part 1.png'
		City2
			icon='Hercule city part 2.png'
		City3
			icon='Hercule city part 3.png'
