mob/proc/SpawnZenie(var/atom/Loc,var/Times=30,var/Min=3,var/Max=5,var/list/DropRates=list(400,200,100,50))
	for(var/Ticks=1;Ticks<=Times;Ticks++)
		PlaySound(view(Loc),'RupeeOut.ogg')
		for(var/i=1;i<=rand(Min,Max);i++)
			var/NewType=pick(prob(DropRates[1]);"Small_Silver",prob(DropRates[2]);"Small_Gold",prob(DropRates[3]);"Large_Silver",prob(DropRates[4]);"Large_Gold")
			NewType=text2path("/obj/Items/Lootable/Zenie/[NewType]")
			var/obj/Items/Lootable/Zenie/Z=new NewType(Loc)
			spawn(1)	if(Z)
				if(src.HasPerk("Pull"))
					walk_towards(Z,src)
					spawn(1+get_dist(Z,src))	if(src && Z)	Z.Collect(src)
				else
					step(Z,pick(0,1,2,4,8,5,6,9,10))
					for(var/mob/Player/M in Z.loc)	Z.Collect(M)
		sleep(1)

obj/Items/Lootable
	Zenie
		var/Value=0
		icon='Zenie.dmi'
		New()
			src.pixel_x=rand(-16,16)
			src.pixel_y=rand(-16,16)
			src.layer-=src.pixel_y/100
			var/LifeSpan=rand(90,110)
			spawn(LifeSpan)	src.icon_state="[src.icon_state]Flicker"
			spawn(LifeSpan+50)	src.loc=null
			return ..()
		Collect(var/mob/M)
			PlaySound(view(src),'Rupee.ogg')
			src.loc=null;M.AddZenie(src.Value)
			if(M.HasClanUpgrade("Cash Flow"))	M.Clan.BankedZenie+=src.Value*M.HasClanUpgrade("Cash Flow")*0.05
		Small_Silver
			Value=1
			icon_state="SmallSilver"
		Small_Gold
			Value=2
			icon_state="SmallGold"
		Large_Silver
			Value=5
			icon_state="LargeSilver"
		Large_Gold
			Value=10
			icon_state="LargeGold"