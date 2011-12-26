var/UploadLogCount=0
var/UploadLogLoaded=0
var/UploadLog="<table border=1><tr><td><b>#<td><b>File<td><b>Size<td><b>Uploader ID\n"

world/New()
	spawn()	LoadUploadLog()
	return ..()

mob/GM/verb/Check_Upload_Log()
	set category="GM"
	usr<<browse("<title>Upload Log</title><center>[UploadLogCount] Uploads Logged[UploadLog]</table>","window=UploadLog")

proc/SaveUploadLog()
	var/savefile/F=new("UploadLog.sav")
	F["UploadLogCount"]<<UploadLogCount
	if(fexists("UploadLog.txt"))	fdel("UploadLog.txt")
	text2file(UploadLog,"UploadLog.txt")

proc/LoadUploadLog()
	if(fexists("UploadLog.sav"))
		var/savefile/F=new("UploadLog.sav")
		F["UploadLogCount"]>>UploadLogCount
	if(fexists("UploadLog.txt"))
		UploadLog=file2text("UploadLog.txt")
	UploadLogLoaded=1

proc/LogUpload(var/File,var/Size,var/Uploader)
	while(!UploadLogLoaded)	sleep(1)
	var/LogMsg="<td>[File]<td>[Size]<td>[Uploader]"
	if(!findtext(UploadLog,LogMsg,1,0))
		UploadLogCount+=1
		UploadLog+="<tr><td>[UploadLogCount][LogMsg]\n"
		SaveUploadLog()