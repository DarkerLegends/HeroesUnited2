//Low CPU HUD Management
//ID is the "list" of HUD text to create/update
//First, use of WriteHUDText(): Feed NewText as your max length string, ie: 9999
//After that, just use UpdateHUDText() with the same ID and actual text as NewText
//hudx/hudpixx/etc should be easy enough positional variables to understand.
mob/var/list
	ObjectIDs=list()
	LastTextIDs=list()

obj/HUD/LowCPU
	layer=11
	icon='Text.dmi'
	mouse_opacity=0
	var/OrigScreenLoc
	var/OrigX;var/OrigPixX
	var/OrigY;var/OrigPixY
	New(hudx,hudxpix,hudy,hudypix,letter)
		src.icon_state=letter
		src.OrigX=hudx;src.OrigPixX=hudxpix
		src.OrigY=hudy;src.OrigPixY=hudypix
		src.screen_loc="[hudx]:[hudxpix],[hudy]:[hudypix]"
		src.OrigScreenLoc=src.screen_loc

var/list/SparArrowCodes=list("ô","ö","ò","º")
mob/proc/UpdateHUDText(var/ID,var/NewText)
	for(var/client/C in src.ControlClients)
		var/firstpos=0
		NewText="[NewText]"
		if(C.mob.LastTextIDs[ID]==NewText)	return
		C.mob.LastTextIDs[ID]=NewText
		if(!(ID in C.mob.ObjectIDs))	{C.mob.ObjectIDs+=ID;C.mob.ObjectIDs[ID]=list()}
		var/list/IdList=C.mob.ObjectIDs["[ID]"]
		C.screen-=IdList
		var/SlimOffset=0
		while(C.mob)
			firstpos+=1
			var/letter=copytext(NewText,firstpos,firstpos+1)
			if(!letter)	return
			if(firstpos>IdList.len)	return
			var/obj/HUD/LowCPU/O=IdList[firstpos]
			if(O)
				O.icon_state=letter
				var/LowOffset=LowLetter(letter)*2
				if(SlimOffset || LowOffset)	O.screen_loc="[O.OrigX]:[O.OrigPixX-SlimOffset],[O.OrigY]:[O.OrigPixY-LowOffset]"
				else	O.screen_loc=O.OrigScreenLoc
				if(SlimLetter(letter))	SlimOffset+=4
				if(letter in SparArrowCodes)	O.screen_loc="[O.OrigX]:[O.OrigPixX+src.SparTextOffsetX],[O.OrigY]:[O.OrigPixY+src.SparTextOffsetY]"
				C.screen+=O

mob/proc/UpdateReverseHUDText(var/ID,var/NewText)
	for(var/client/C in src.ControlClients)
		var/counter=0;var/LastPos=length(NewText)+1
		NewText="[NewText]"
		if(C.mob.LastTextIDs[ID]==NewText)	return
		C.mob.LastTextIDs[ID]=NewText
		if(!(ID in C.mob.ObjectIDs))	{C.mob.ObjectIDs+=ID;C.mob.ObjectIDs[ID]=list()}
		var/list/IdList=C.mob.ObjectIDs["[ID]"]
		C.screen-=IdList
		LastPos=min(IdList.len+1,LastPos)
		var/SlimOffset=0
		while(C.mob)
			if(LastPos<=1)	{C.mob.ObjectIDs["[ID]"]=IdList;return}
			var/letter=copytext(NewText,LastPos-1,LastPos)
			LastPos-=1
			counter+=1;if(counter>IdList.len)	return
			var/obj/HUD/LowCPU/O=IdList[counter]
			if(O)
				O.icon_state=letter
				var/LowOffset=LowLetter(letter)*2
				if(SlimLetter(letter))	SlimOffset+=4
				if(SlimOffset || LowOffset)	O.screen_loc="[O.OrigX]:[O.OrigPixX+SlimOffset],[O.OrigY]:[O.OrigPixY-LowOffset]"
				else	O.screen_loc=O.OrigScreenLoc
				if(letter in SparArrowCodes)	O.screen_loc="[O.OrigX]:[O.OrigPixX+src.SparTextOffsetX],[O.OrigY]:[O.OrigPixY+src.SparTextOffsetY]"
				C.screen+=O

mob/proc/WriteHUDText(var/hudx,var/hudxpix,var/hudy,var/hudypix,var/ID,var/NewText)
	for(var/client/C in src.ControlClients)
		var/firstpos=0
		var/PixelSpace=6
		NewText="[NewText]"
		var/list/IdList=list()
		src.LastTextIDs[ID]="/i"
		if(!(ID in C.mob.ObjectIDs))	{C.mob.ObjectIDs+=ID;C.mob.ObjectIDs[ID]=list()}
		for(var/obj/O in C.mob.ObjectIDs["[ID]"])	del O
		while(C.mob)
			firstpos+=1
			var/letter=copytext(NewText,firstpos,firstpos+1)
			if(!letter)	{C.mob.ObjectIDs["[ID]"]=IdList;break}
			var/obj/HUD/LowCPU/O=new(hudx,hudxpix,hudy,hudypix,letter)
			C.screen+=O
			IdList+=O
			hudxpix+=PixelSpace
			if(hudxpix>=32)
				hudx+=1;hudxpix-=32

mob/proc/WriteReverseHUDText(var/hudx,var/hudxpix,var/hudy,var/hudypix,var/ID,var/NewText)
	for(var/client/C in src.ControlClients)
		var/LastPos=length(NewText)+1
		var/PixelSpace=6
		NewText="[NewText]"
		var/list/IdList=list()
		src.LastTextIDs[ID]="/i"
		if(!(ID in C.mob.ObjectIDs))	{C.mob.ObjectIDs+=ID;C.mob.ObjectIDs[ID]=list()}
		for(var/obj/O in C.mob.ObjectIDs["[ID]"])	del O
		while(C.mob)
			if(LastPos<=1)	{C.mob.ObjectIDs["[ID]"]=IdList;break}
			var/letter=copytext(NewText,LastPos-1,LastPos)
			LastPos-=1
			var/obj/HUD/LowCPU/O=new(hudx,hudxpix,hudy,hudypix,letter)
			C.screen+=O
			IdList+=O
			hudxpix-=PixelSpace
			if(hudxpix<=-32)
				hudx-=1;hudxpix+=32