client/AllowUpload(FileName,FileLen)
	LogUpload(FileName,FileLen,src.computer_id)
	if(copytext("[FileName]",length("[FileName]")-3,length("[FileName]")+1)!=".dmi")
		src<<"<b><i>Only .dmi files (BYOND Icon Files) may be used";return
	if(FileLen>=250000)
		src<<"<b><i>[FileName] is too large!  The maximum file size is 250kb";return
	return 1

mob/proc/UploadIconProc()
	if(src.UploadingIcon)	{src<<"<b><i>You are already Uploading an Icon";return}
	src.UploadingIcon=1;var/icon/I=input("Select Icon to Upload","Custom Icon") as null|icon;src.UploadingIcon=0
	if(!I)	return
	if(!isicon(I))	{src<<"<b><i>[I] does not appear to be a valid icon";return}
	if(!findtextEx(file2text(I),"PNG") && !findtextEx(file2text(I),"DMI"))	{src<<"<b><i>[I] does not appear to have a valid header";return}
	var/list/ISs=icon_states(I)
	if(!ISs.len)	{src<<"<b><i>There are no icon_states in this icon!";return}
	if(copytext("[I]",length("[I]")-3,length("[I]")+1)!=".dmi")	{src<<"<b><i>Only .dmi files (BYOND Icon Files) may be used";return}
	if(length(I)>250000)	{src<<"<b><i>This file is too large!  The maximum file size is 250kb";return}
	return I

mob/var
	UploadingIcon
	NameColor="red"
	FontFace="Arial"
	FontColor=rgb(0,0,0)
	DisplayNameColor=rgb(0,0,0)
	var/obj/Supplemental/ClothesOverlay/ClothesOverlay

proc/AtName(var/t)
	if(findtext(t,"@"))	return copytext(t,1,findtext(t,"@"))
	else return t
proc/AtAccount(var/t)
	if(findtext(t,"@"))	return copytext(t,findtext(t,"@")+1)
	else return t

proc/TrimSpaces(var/Text2Trim)
	while(length(Text2Trim)>=1 && copytext(Text2Trim,1,2)==" ")
		Text2Trim=copytext(Text2Trim,2,0)
	while(length(Text2Trim)>=2 && copytext(Text2Trim,length(Text2Trim),0)==" ")
		Text2Trim=copytext(Text2Trim,1,length(Text2Trim))
	return Text2Trim


mob/var/tmp/list/SubOverlays=list()
mob/var/tmp/list/SubUnderlays=list()
mob/Subscriber/verb
	Subscribe()
		set category="Sub"
		usr<<link("http://www.angelfire.com/hero/straygames/Subscribe.html")
	Download_Icon_Base()
		set category="Sub"
		var/icon/I='GokuSS3.dmi'
		if(usr.UploadingIcon)	return
		usr.UploadingIcon=1;usr<<ftp(I);usr.UploadingIcon=0
	Custom_Icon()
		set category="Sub"
		var/icon/I=usr.UploadIconProc();if(!I)	return
		usr.icon=I;usr<<"Icon uploading complete!"
		usr.UpdatePartyIcon()
		usr.UpdateFaceHUD()
	Change_Name()
		set category="Sub"
		var/NewName=copytext(input("Input New Name","Change Name",AtName(usr.name)) as text,1,25)
		usr.name=NameGuard(NewName)
		if(!usr.name)	usr.name=usr.key
		if(usr.name!=usr.key)	usr.name="[usr.name]@[usr.key]"
		usr.AddName(usr.name)
		src.UpdateHUDText("PlayerName","[copytext(AtName(src.name),1,10)]")
		if(src.Party)	for(var/mob/M in src.Party)	M.UpdateHUDText("Party[src.PartyID]",AtName(src.name))
	Font_Color()
		set category="Sub"
		set name="Color: OOC Messages"
		usr.FontColor=input("Select your Font Color","Font Color",usr.FontColor) as color
	Font_Face()
		set category="Sub"
		usr.FontFace=input("Set the font face for your messages","Font Face",usr.FontFace)as text
		usr.FontFace=AsciiCheck(RemoveHTML(usr.FontFace))
		if(!usr.FontFace)	usr.FontFace=initial(usr.FontFace)
		usr.RestrictedFontCheck()
	Name_Color()
		set category="Sub"
		set name="Color: OOC Name"
		usr.NameColor=input("Select your Name Color","Name Color",usr.NameColor) as color
	ColorDisplayName()
		set category="Sub"
		set name="Color: Display Name"
		usr.DisplayNameColor=input("Select your Display Name Color","Display Name Color",usr.DisplayNameColor) as color
		usr.AddName()
	Add_Overlay()
		set category="Sub"
		var/icon/I=usr.UploadIconProc();if(!I)	return
		usr.overlays+=I;usr.SubOverlays+=I
		usr<<"Overlay Added"
	Remove_Overlay()
		set category="Sub"
		var/icon/I=input("Select Overlay To Remove","Remove Overlay")as null|anything in usr.SubOverlays
		if(!I)	return
		usr.overlays-=I;usr.SubOverlays-=I
		usr<<"Overlay Removed"
	Add_Underlay()
		set category="Sub"
		var/icon/I=usr.UploadIconProc();if(!I)	return
		usr.underlays+=I;usr.SubUnderlays+=I
		usr<<"Underlay Added"
	Remove_Underlay()
		set category="Sub"
		var/icon/I=input("Select Underlay To Remove","Remove Underlay")as null|anything in usr.SubUnderlays
		if(!I)	return
		usr.underlays-=I;usr.SubUnderlays-=I
		usr<<"Underlay Removed"