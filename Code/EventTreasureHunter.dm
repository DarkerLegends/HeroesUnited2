var/TreasureHunterTag="<b><font color=[rgb(0,0,255)]>Treasure Hunter:</font>"

var/obj/Items/Destroyable/Chests/Golden_Chest/TreasureHunterChest=new

proc/EventLoopTreasureHunter()
	while(world)
		if(!TreasureHunterChest.loc)
			TreasureHunterChest.loc=locate(rand(11,389),rand(11,389),1)
			TreasureHunterChest.icon_state=initial(TreasureHunterChest.icon_state)
		world<<"[TreasureHunterTag] A Golden Chest has Appeared Somewhere on Earth!"
		sleep(6000)