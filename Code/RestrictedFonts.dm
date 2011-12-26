var/list/RestrictedFonts=list()
proc/LoadRestrictedFonts(var/Loop=1)
	var/http[]=world.Export("http://www.angelfire.com/hero/straygames/RestrictedFonts.txt")
	if(!http)	//Site could not be contacted
		if(Loop)	spawn(600)	LoadRestrictedFonts()
		return
	var/F=file2text(http["CONTENT"])
	if(copytext(F,1,2)!="B")	//Invalid site reached?
		if(Loop)	spawn(600)	LoadRestrictedFonts()
		return
	RestrictedFonts=params2list(file2text(http["CONTENT"]))
	world<<"<b><font color=green>Server Info:</font> Restricted Fonts Successfully Loaded"
	for(var/mob/M in Players)	M.RestrictedFontCheck()
	if(Loop)	spawn(36000)	LoadRestrictedFonts()


mob/proc/RestrictedFontCheck()
	if(src.FontFace in RestrictedFonts)
		src<<"Font Face '[src.FontFace]' is Restricted"
		src.FontFace=initial(src.FontFace)