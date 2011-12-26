obj/HUD/Popups
	var/Clicked
	var/mob/Sender
	New(var/mob/NU)
		src.Sender=NU
		return ..()
	proc/ClickCheck()
		if(src.Clicked)	return 1
		else	src.Clicked=1
	Click()
		if(src.desc)	winset(usr,"SmallInfoWindow","is-visible=false")
		usr.RemovePopupHUD(src)
	Clan_Invite
		var/datum/Clan/Clan
		icon_state="ClanInvite"
		New(var/mob/NU,var/NC)
			src.Sender=NU
			src.Clan=NC
			return ..()
		Click()
			if(src.ClickCheck())	return
			spawn(-1)	usr.ClanInvite(src.Sender,src.Clan)
			return ..()
	Duel_Request
		var/DuelType
		icon_state="DuelRequest"
		New(var/mob/NU,var/DT)
			src.Sender=NU
			src.DuelType=DT
			return ..()
		Click()
			if(src.ClickCheck())	return
			spawn(-1)	usr.AcceptDuel(src.Sender,src.DuelType)
			return ..()
	Party
		icon_state="PartyInvite"
		Click()
			if(src.ClickCheck())	return
			spawn(-1)	usr.AcceptPartyInvite(src.Sender)
			return ..()
	Fusion_Request
		icon_state="FusionRequest"
		Click()
			if(src.ClickCheck())	return
			spawn(-1)	usr.AcceptFusionRequest(src.Sender)
			return ..()

mob/var/list/HudPopups
mob/proc/PopupHUD(var/obj/HUD/Popups/P,var/Desc)
	if(!src.HudPopups)	src.HudPopups=list()
	P.desc=Desc;src.HudPopups+=P;src.UpdatePopupsHUD()

mob/proc/ClearHUDPopups()
	for(var/obj/HUD/Popups/P in src.HudPopups)	src.RemovePopupHUD(P)
	if(src.DuelRequests)	src.DuelRequests=list()
	if(src.PartyInvites)	src.PartyInvites=list()

mob/proc/RemovePopupHUD(var/obj/HUD/Popups/P)
	if(!(P in src.HudPopups))	src=src.GetFusionMob()
	for(var/client/C in src.ControlClients)	C.screen-=P
	src.HudPopups-=P;src.UpdatePopupsHUD()

mob/proc/UpdatePopupsHUD()
	for(var/client/C in src.ControlClients)
		C.screen-=src.HudPopups
		var/counter=0
		for(var/obj/HUD/Popups/P in src.HudPopups)
			counter+=1
			P.screen_loc="[min(5,counter)]:2,1:2"
			C.screen+=P