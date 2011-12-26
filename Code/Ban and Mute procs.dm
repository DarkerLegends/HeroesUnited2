mob/proc/IsMuted()
	if(src.key in MuteList)	return 1
	if(src.client && (src.client.address in MuteList))	return 1
	return 0

mob/proc/MyIsBanned()	//Called MyIsBanned since BYOND has a built-in IsBanned() proc
	if(src.key in BanList)	return 1
	if(src.client && (src.client.address in BanList))	return 1
	return 0