obj/HUD
	Player_vs_Player
		icon_state="PvP"
		screen_loc="7,1"
		desc="PvP Arenas"
		MouseEntered()
			return ..()
			src.desc="[initial(src.desc)]\nWT Status: [global.TournStatus]"
			return ..()
		Click()
			var/Choice=input("Select a PvP Arena","Arena Options") as null|anything in list("PvP Arena","Clan PvP Arena","Balanced PvP Arena","Exit Arena")
			if(Choice)	for(var/obj/O in usr.client.screen)	if(O.name==Choice)	O.Click()