mob/var/list/PartsInventory
var/list/RarityParts=list()
var/list/AllParts=list()
proc/PopulateRarityParts()
	for(var/v in typesof(/obj/Items/Lootable/Parts))
		var/obj/Items/Lootable/Parts/P=new v
		if(P.icon_state)
			if(!(P.Rarity in RarityParts))	RarityParts[P.Rarity]=list()
			RarityParts[P.Rarity]+=P;AllParts+=P

mob/proc/SpawnPart(var/atom/Loc,var/Times=1,var/Min=1,var/Max=1,var/DropRate=50)
	for(var/Ticks=1;Ticks<=Times;Ticks++)
		PlaySound(view(Loc),'RupeeOut.ogg')
		for(var/i=1;i<=rand(Min,Max);i++)
			if(rand(1,100)>DropRate)	continue
			var/RarityLevel
			if(MyProb(1))	RarityLevel="Functional Item"
			if(MyProb(5))	RarityLevel="Advanced Part"
			if(MyProb(10))	RarityLevel="Common Part"
			if(!RarityLevel)	RarityLevel="Scrap"
			var/obj/NewType=pick(RarityParts[RarityLevel])
			NewType=NewType.type
			var/obj/Items/Lootable/Parts/P=new NewType(Loc)
			spawn(1)	if(P)
				if(src.HasPerk("Pull"))
					walk_towards(P,src)
					spawn(1+get_dist(P,src))	if(src && P)	P.Collect(src)
				else
					step(P,pick(0,1,2,4,8,5,6,9,10))
					for(var/mob/Player/M in P.loc)	P.Collect(M)
		sleep(1)

obj/Items/Lootable/Parts
	suffix="1"
	var/Rarity
	icon='Parts.dmi'
	Collect(var/mob/M)
		PlaySound(view(src),'Rupee.ogg');src.loc=null
		if(!islist(M.PartsInventory))	M.PartsInventory=list()
		for(var/obj/Items/Lootable/Parts/P in M.PartsInventory)	if(P.type==src.type)
			P.suffix="[text2num(P.suffix)+1]";return
		M.PartsInventory+=new src.type
	MouseEntered()
		winset(usr,"SmallInfoWindow.NameLabel","text=\"[src.name]\"")
		winset(usr,"SmallInfoWindow.DescLabel","text=\"Item Class: [src.Rarity]\n0 Known Schematics\nNo Base Components\"")
		winset(usr,"SmallInfoWindow","pos=[250-2],[100+6];is-visible=true")
		winset(usr,"MainWindow.MainMap","focus=true")
	MouseExited()
		winset(usr,"SmallInfoWindow","is-visible=false")
	New()
		spawn(rand(150,200))	src.loc=null
		return ..()
	Scrap
		Rarity="Scrap"
		Large_Washer
			icon_state="Large Washer"
		Cross_Bolt
			icon_state="Cross Bolt"
		Large_Sprocket
			icon_state="Large Sprocket"
		Diamond_Bolt
			icon_state="Diamond Bolt"
		Small_Sprocket
			icon_state="Small Sprocket"
		Cross_Cube
			icon_state="Cross Cube"
		Glass_Chip
			icon_state="Glass Chip"
		Battery
			icon_state="Battery"
		Red_Wire
			icon_state="Red Wire"
		Blue_Wire
			icon_state="Blue Wire"
		Green_Wire
			icon_state="Green Wire"
		Sheet_Metal
			icon_state="Sheet Metal"
	Common_Parts
		Rarity="Common Part"
		Glass_Bubble
			icon_state="Glass Bubble"
		Energy_Pack
			icon_state="Energy Pack"
		Blank_Chip
			icon_state="Blank Chip"
		RG_Wire
			icon_state="RG Wire"
		RB_Wire
			icon_state="RB Wire"
		GB_Wire
			icon_state="GB Wire"
		Metal_Radar
			icon_state="Metal Radar"
		Lens
			icon_state="Lens"

		Blue_Chip
		Green_Chip
		Red_Chip
	Advanced_Parts
		Rarity="Advanced Part"
		Wired_Radar
			icon_state="Wired Radar"
		Blue_Chip
			icon_state="Blue Chip"
		Green_Chip
			icon_state="Green Chip"
		Red_Chip
			icon_state="Red Chip"
	Functional_Items
		Rarity="Functional Item"
		Dragon_Radar
			icon_state="Dragon Radar"
		Scouter
			icon_state="Scouter"